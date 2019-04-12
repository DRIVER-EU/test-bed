import sys, os, subprocess, re, requests_pkcs12, json, base64, tempfile, getpass

# Requires Python >= 3.6
if sys.version_info.major < 3 or sys.version_info.minor < 6:
    raise Exception("Must be using Python 3.6 or later")

if len(sys.argv) < 4:
    print("Missing username argument")
    print("Usage: ./enroll-cert-remote.py ejbca_admin_base_url ejbca_pub_base_url '/path/to/admin.p12' username [organization]")
    sys.exit(2)

inputEjbcaAdminBaseUrl = sys.argv[1]
inputEjbcaPubBaseUrl = sys.argv[2]

inputAdminP12Path = sys.argv[3]
superadminP12Path = os.path.abspath(inputAdminP12Path)
print(f"Please enter the password for the admin keystore '{superadminP12Path}'")
superadminPass = getpass.getpass()

inputUsername = sys.argv[4]
print("Please enter the new user password")
userPassword = getpass.getpass()

inputOrganization = sys.argv[5] or "TheOrg"

tmpDir = tempfile.mkdtemp()

# Register the user on the Certificate Management's REST API
headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}
eesApiUrl = '%s/ejbca/ejbca-rest-api/v1/ees' % inputEjbcaAdminBaseUrl

userDataJson = {
            "certificate_profile_name": "ENDUSER",
            "end_entity_profile_name": "TLS_EE",
            "username": inputUsername,
            "password": userPassword,
            "email": f"{inputUsername}.admin@the.org",
            "subject_dn":f"CN={inputUsername},O={inputOrganization}",
            "ca_name": "Issuing_CA",
            "token_type": "P12"
    }

# If this triggers ssl error, try with no password protection on p12 as mentioned here: http://docs.python-requests.org/en/master/user/advanced/
# Get trusted Management CA for admin operations
mgtCaUrl = "{}/ejbca/publicweb/webdist/certdist?cmd=cacert&issuer=CN%3DManagementCA%2COU%3DWP923%2CO%3DDRIVER+PROJECT&level=0".format(inputEjbcaPubBaseUrl)
response = requests_pkcs12.get(mgtCaUrl, allow_redirects=False)
mgtCaCertPath = os.path.join(tmpDir, 'mgt-ca-crt.pem')
open(mgtCaCertPath, 'w').write(response.text)

response = requests_pkcs12.post(eesApiUrl, headers=headers, json=userDataJson, verify=mgtCaCertPath, pkcs12_filename=superadminP12Path, pkcs12_password=superadminPass)
if response.status_code != 200:
    raise RuntimeError(f"User registration failed. Server response: {response.text}")

# Request certificate
certEnrollApiUrl = '%s/ejbca/ejbca-rest-api/v1/certificate/enrollkeystore' % inputEjbcaAdminBaseUrl
certReqJson = {
    "username":inputUsername,
    "password":userPassword,
    "key_alg":"RSA",
    "key_spec":"2048"
}

response = requests_pkcs12.post(certEnrollApiUrl, headers=headers, json=certReqJson, verify=mgtCaCertPath, pkcs12_filename=superadminP12Path, pkcs12_password=superadminPass)
if response.status_code != 200:
    raise RuntimeError(f"Certificate enrollment failed. Server response: {response.text}")

# Get keystore_data from JSON response
responseJson = json.loads(response.content)
keystoreData = responseJson['keystore_data']
# Decode one-liner b64 to PEM
keystoreBytes = base64.b64decode(keystoreData)
keystorePem = keystoreBytes.decode("utf-8")
#print("PEM: \n" + keystorePem)
# Decode PEM to binary P12
keystoreBin = base64.b64decode(keystorePem)
# Save result to binary file username.p12
p12Path = os.path.join(tmpDir, 'keystore.p12')
open(p12Path, 'wb').write(keystoreBin)
print(f"\nPKCS#12 keystore for username '{inputUsername}' saved to file: '{p12Path}'")
print(f"With JDK installed, you may display the content with this command (password: {userPassword}):\n keytool -list -v -keystore {p12Path}")

