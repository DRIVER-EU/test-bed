## Docker with security features

This is similar to [docker/local](../local) folder, except it provides extra security features, especially for access control:
* **Certificate Management Service**: provides X.509 SSL certificates for Kafka client/consumer authentication.
* **Combined ACL-XACML authorizer for Apache Kafka**: based on [DRIVER+'s kafka-combined-acl-xacml-authorizer project](https://github.com/DRIVER-EU/kafka-combined-acl-xacml-authorizer) and deployed in the Kafka broker service, it enhances the native Kafka ACL-based *authorizer* with standard [XACML](http://docs.oasis-open.org/xacml/3.0/xacml-3.0-core-spec-os-en.html) evaluation, by interacting with the XACML PDP's REST API provided by the Authorization service below. 
* **Authorization service**: provides a REST API for managing Attribute-based Access Control (ABAC) policies in XACML - Kafka topic access policies in this case - also called PAP (Policy Administration Point) in XACML jargon; and a REST API for getting authorization decisions according to those ABAC policies, also called PDP (Policy Decision Point) in XACML jargon. The PDP API complies with [REST Profile of XACML 3.0](http://docs.oasis-open.org/xacml/xacml-rest/v1.0/xacml-rest-v1.0.html) and the endpoint address is given by the environment variable `KAFKA_ORG_OW2_AUTHZFORCE_KAFKA_PEP_XACML_PDP_URL` in the [docker-compose file](docker-compose.yml). The PAP API is described in the [Authorization Service project's README](https://github.com/DRIVER-EU/test-bed-security-authorization-service/blob/master/README.md#api-usage), and the endpoint address is the same as the PDP after replacing `pdp` with `pap` at the end.


# Usage

## Build, create and start services

```sh
$ ./preinst.sh
$ docker-compose up -d
```

## Certificate Management Service
The Certificate Management Service allows end-users such as Kafka consumers to enroll certificates with a REST API. *Soon, the Admin Tool will provide a user interface for this.*

The service requires client certificate authentication for admin operations. So you first need to retrieve the superadmin certificate and password from the service's docker container as follows:

```sh
$ docker cp localsecurity_cert_mgt_1:/opt/pki/ejbca/p12/superadmin.p12 /tmp
$ docker exec localsecurity_cert_mgt_1 grep superadmin.password /opt/pki/ejbca/conf/web.properties
superadmin.password=cb40ec9ee9875580325c6a6e4d1b382fb3e521f8
```

### User registration
If the user that you want to enroll is not registered yet, register him/her first as follows:

1. Create a file, say `/tmp/user.json`, with the user data as JSON object like this:
    ```js
        {
                "certificate_profile_name": "ENDUSER",
                "end_entity_profile_name": "TLS_EE",
                "username": "testUser",
                "password": "changeit",
                "email": "",
                "subject_dn":"CN=testUser,O=DRIVER_PROJECT",
                "ca_name": "Issuing_CA",
                "token_type": "P12"
        }
    ```
    
    Modify only the username, password and email that should be the contact for the contact person/owner of the client solution, and set the subject_dn to `CN=<username>,O=DRIVER_PROJECT`.
    
1. Register the user via the REST API as follows (separating the path to the superadmin certificate and password with `:` in the `--cert` argument):
    ```sh
    $ curl -k -v --cert /tmp/superadmin.p12:cb40ec9ee9875580325c6a6e4d1b382fb3e521f8 --cert-type p12  -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' --data @/tmp/user.json -i 'https://localhost:8443/ejbca/ejbca-rest-api/v1/ees' 

    HTTP/1.1 200 OK
    Connection: keep-alive
    X-Powered-By: Undertow/1
    Server: WildFly/10
    Content-Type: application/json
    Content-Length: 4
    Date: Sun, 03 Sep 2018 16:50:18 GMT
    
    true
    ```
    
You may list registered users as follows:
```sh
$ curl -k -v --cert /tmp/superadmin.p12:cb40ec9ee9875580325c6a6e4d1b382fb3e521f8 --cert-type p12  -X GET -H 'Accept: application/json' -i 'https://localhost:8443/ejbca/ejbca-rest-api/v1/ees'

{"end_entities":[
  {"username":"testUser", ...}
  ...
]}
```

Get a specific registered user info, e.g. user with `username=testUser`:
```sh
$ curl -k -v --cert /tmp/superadmin.p12:cb40ec9ee9875580325c6a6e4d1b382fb3e521f8 --cert-type p12  -X GET -H 'Accept: application/json' -i 'https://localhost:8443/ejbca/ejbca-rest-api/v1/ees/testUser'
```

You may deregister the user as follows:
```sh
$ curl -k -v --cert /tmp/superadmin.p12:cb40ec9ee9875580325c6a6e4d1b382fb3e521f8 --cert-type p12  -X DELETE -H 'Accept: application/json' -i 'https://localhost:8443/ejbca/ejbca-rest-api/v1/ees/testUser'
```

### Certificate request (aka enrollment)
Once the user is registered, you can request a certificate for that user as follows:

1. Create a file, say `/tmp/certReq.json`, with the certificate request data as JSON object like this:

    ```js
    {
        "username":"testUserRest",
        "password":"changeit",
        "key_alg":"RSA",
        "key_spec":"2048"
    }
    ```
    The username and password should match the registered user's username and password.
1. Request the certificate via the REST API as follows:
   ```sh
    $ curl -k --cert /tmp/superadmin.p12:cb40ec9ee9875580325c6a6e4d1b382fb3e521f8 --cert-type p12  -X POST -H 'Content-Type: application/json' -H 'Accept: application/json' --data @/tmp/certReq.json -i 'https://localhost:8443/ejbca/ejbca-rest-api/v1/certificate/enrollkeystore'

    {"keystore_data":"TUlJVWNBSUJBekNDRkNvR0NT...(content omitted)...kJvY1MvbXFhZURiakc0WQpBZ0lFQUE9PQ==","keystore_type":"TOKENSOFTP12"}
    ```

The returned `keystore_data` value is the password-protected (with the user's password) PKCS#12 keystore in PEM format, re-encoded in base64 (to get rid of line breaks for JSON compatibility). Therefore, in order to export to a binary p12 file for use with common SSL libraries, do as follows:
1. Save the `keystore_data` string to a file, say `/tmp/keystore_data.txt`. Make sure it is one line.
1. Base64-decode the content to get back the keystore in PEM format, then base64-decode again to get the keystore in binary (DER) format as most applications would expect. You can do it in one command line as follows:
    ```sh
    $ base64 -d /tmp/keystore_data.txt | base64 -d > /tmp/keystore.p12
    ```
1. Make sure the result P12 file is in the right format with a PKCS#12 tool such as openssl, keytool (or try import into your browser):
```sh
$ keytool -keystore /tmp/keystore.p12 -list

Enter keystore password:  
Keystore type: JKS
Keystore provider: SUN

Your keystore contains 1 entry

testuserrest, Sep 03, 2018, PrivateKeyEntry, 
Certificate fingerprint (SHA1): 04:DC:24:E3:87:D9:16:F7:B4:7A:9A:2D:09:51:56:54:33:1B:0C:2A
```

## Kafka client authentication
Once the services are running, Kafka clients must authenticate to the Kafka `broker` service using [SSL certificate authentication](https://kafka.apache.org/documentation/#security_ssl) with a client certificate issued by the Certificate Management Service mentioned previously. You can also find in folder [sample-ssl-clients](ca_service/sample-ssl-clients) a few examples of SSL client files (certificates and keystores) for testing:
- `admin-tool-client.p12`: PKCS#12 keystore of a test Admin Tool that can connect to Kafka broker as a super user, as defined by the environment variable `KAFKA_SUPER_USERS` in the [docker-compose file](docker-compose.yml).
- `other-tool-1-client.p12`: PKCS#12 keystore of a test client that can connect to Kafka broker as a normal user.
- `truststore.jks`: JKS keystore to be used as trusted certificate store (contains trusted CA certificate) when connecting to a SSL server (e.g. Kafka broker) with certificate issued by the aforementioned CA.

Example with Kafka console script (Kafka Console Producer):

```sh
$ cd sample-ssl-clients
$ /path/to/kafka_home_dir/bin/kafka-console-producer.sh --broker-list localhost:3501 --topic test --producer.config admin-tool-client-ssl.properties
```

More info in [Kafka documentation](https://kafka.apache.org/documentation/#security_configclients).


## Stop and remove services 

```sh
$ docker-compose down
```
