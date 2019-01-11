import sys, subprocess, re, requests_pkcs12, json, base64

# Requires Python >= 3.6
if sys.version_info.major < 3 or sys.version_info.minor < 6:
    raise Exception("Must be using Python 3.6 or later")

if len(sys.argv) < 2:
    print("Missing username argument")
    print("Usage: ./enroll-cert.py username")
    sys.exit(2)

inputUsername = sys.argv[1]
userPassword = "P@55w0/2d"

# Extract superadmin p12 from cert_mgt container to /tmp
subprocess.run(['docker', 'cp', 'localsecurity_cert_mgt_1:/opt/pki/ejbca/p12/superadmin.p12', '/tmp'])

print("Superadmin keystore extracted to: /tmp/superadmin.p12")

# Extract superadmin password
result = subprocess.run(['docker', 'exec', 'localsecurity_cert_mgt_1', 'grep', 'superadmin.password', '/opt/pki/ejbca/conf/web.properties'], stdout=subprocess.PIPE)
superadminPass = re.search("=([a-f0-9]+)\n", result.stdout.decode('utf-8')).group(1)

print(f"Superadmin keystore password: {superadminPass}")

# Register the user on the Certificate Management's REST API
headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}
eesApiUrl = 'https://localhost:8443/ejbca/ejbca-rest-api/v1/ees'

userDataJson = {
            "certificate_profile_name": "ENDUSER",
            "end_entity_profile_name": "TLS_EE",
            "username": inputUsername,
            "password": userPassword,
            "email": f"{inputUsername}.admin@the.org",
            "subject_dn":f"CN={inputUsername},O=TheOrganization",
            "ca_name": "Issuing_CA",
            "token_type": "P12"
    }

# If this triggers ssl error, try with no password protection on p12 as mentioned here: http://docs.python-requests.org/en/master/user/advanced/
# Get trusted Management CA for admin operations
mgtCaUrl = 'http://localhost:9090/ejbca/publicweb/webdist/certdist?cmd=cacert&issuer=CN%3DManagementCA%2COU%3DWP923%2CO%3DDRIVER+PROJECT&level=0'
response = requests_pkcs12.get(mgtCaUrl, allow_redirects=False)
open('/tmp/mgt-ca-crt.pem', 'w').write(response.text)

response = requests_pkcs12.post(eesApiUrl, headers=headers, json=userDataJson, verify='/tmp/mgt-ca-crt.pem', pkcs12_filename='/tmp/superadmin.p12', pkcs12_password=superadminPass)
if response.status_code != 200:
    raise RuntimeError(f"User registration failed. Server response: {response.text}")

# Request certificate
certEnrollApiUrl = 'https://localhost:8443/ejbca/ejbca-rest-api/v1/certificate/enrollkeystore'
certReqJson = {
    "username":inputUsername,
    "password":userPassword,
    "key_alg":"RSA",
    "key_spec":"2048"
}

response = requests_pkcs12.post(certEnrollApiUrl, headers=headers, json=certReqJson, verify='/tmp/mgt-ca-crt.pem', pkcs12_filename='/tmp/superadmin.p12', pkcs12_password=superadminPass)
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
p12Path = "/tmp/keystore.p12"
open(p12Path, 'wb').write(keystoreBin)
print(f"\nPKCS#12 keystore for username '{inputUsername}' saved to file: '{p12Path}'")
print(f"You may display the content with this command (password: {userPassword}):\n keytool -list -v -keystore /tmp/keystore.p12")

