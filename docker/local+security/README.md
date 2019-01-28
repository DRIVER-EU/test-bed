## Docker with security features

This is similar to [docker/local](../local) folder, except it provides extra security features, especially for access control:
* **Certificate Management Service**: provides X.509 SSL certificates for Kafka client/consumer authentication.
* **Combined ACL-XACML authorizer for Apache Kafka**: based on [DRIVER+'s kafka-combined-acl-xacml-authorizer project](https://github.com/DRIVER-EU/kafka-combined-acl-xacml-authorizer) and deployed in the Kafka broker service, it enhances the native Kafka ACL-based *authorizer* with standard [XACML](http://docs.oasis-open.org/xacml/3.0/xacml-3.0-core-spec-os-en.html) evaluation, by interacting with the XACML PDP's REST API provided by the Authorization service below. 
* **Authorization service**: provides a REST API for managing Attribute-based Access Control (ABAC) policies in XACML - Kafka topic access policies in this case - also called PAP (Policy Administration Point) in XACML jargon; and a REST API for getting authorization decisions according to those ABAC policies, also called PDP (Policy Decision Point) in XACML jargon. The PDP API complies with [REST Profile of XACML 3.0](http://docs.oasis-open.org/xacml/xacml-rest/v1.0/xacml-rest-v1.0.html) and the endpoint address is given by the environment variable `KAFKA_ORG_OW2_AUTHZFORCE_KAFKA_PEP_XACML_PDP_URL` in the [docker-compose file](docker-compose.yml). The PAP API is described in the [Authorization Service project's README](https://github.com/DRIVER-EU/test-bed-security-authorization-service/blob/master/README.md#api-usage), and the endpoint address is the same as the PDP after replacing `pdp` with `pap` at the end.


# Usage

## Build, create and start services

```sh
$ docker-compose up -d
```

## Kafka client authentication
Once the services are running, Kafka clients must authenticate to the Kafka `broker` service using [SSL certificate authentication](https://kafka.apache.org/documentation/#security_ssl) with client certificates issued by the test-bed Certificate Management Service. More details on this service in the last section.

### Testing client authentication with existing sample certificates in `sample-ssl-clients` folder

As a convenience and especially for initial security testing, you should use the examples of SSL client files, certificates and keystores in folder [sample-ssl-clients](ca_service/sample-ssl-clients):
- `admin-tool-client.p12`: PKCS#12 keystore of a test Admin Tool that can connect to Kafka broker as a super user, as defined by the environment variable `KAFKA_SUPER_USERS` in the [docker-compose file](docker-compose.yml).
- `other-tool-1-client.p12`: PKCS#12 keystore of a test client that can connect to Kafka broker as a normal user.
- `truststore.jks` or `test-ca-crt.pem`: trusted CA certificate; for Java clients, you can use the JKS keystore [truststore.jks](sample-ssl-clients/truststore.jks) as trusted certificate store; for others, you can use the (root) CA certificate in PEM format: [test-ca-crt.pem](sample-ssl-clients/test-ca-crt.pem), this is the standard format that should be supported by most SSL/TLS stacks.

Example with Kafka console script (Kafka Console Producer):

```sh
$ cd sample-ssl-clients
$ /path/to/kafka_home_dir/bin/kafka-console-producer.sh --broker-list localhost:3501 --topic test --producer.config admin-tool-client-ssl.properties
```

More info in [Kafka documentation](https://kafka.apache.org/documentation/#security_configclients).

### Testing client authentication with new certificate enrollment

After testing the previous section, it is time to get a new certificate on your own, for your own identity, as solution provider for example. For that purpose, we provide a [python script](sample-ssl-clients/enroll-cert.py) on this repository, which registers a user with the input user info in the Certificate Management Service, then performs the certificate enrollment for that user in order to retrieve the certificate. You execute it as follows:

```sh
$ cd sample-ssl-clients
$ python3 enroll-cert.py best.solution.com BestOrganization
```

The first argument is the solution name, in a form of CommonName (CN), e.g. a FQDN (Fully Qualified Domain Name) that uniquely identifies your solution. The second argument is the name of the solution's organization (use the short form preferably). It will prompt for the password you want to use to protect the .p12 (private key in particular).

**The script requires Python 3.6 or later, and `requests_pkcs12` module (can be installed with `pip install requests_pkcs12`). On some platforms, you may have to use simply `python` instead of `python3`, depending on the name of the Python 3.x executable.**

**You cannot run it twice with the same arguments because a user cannot be registered twice in the system. If you wish to renew the certificate for an existing user (already registered), you can do it manually by following the instructions in section *Certificate Request (aka enrollment)* down below.**

In the near future, you'll be able to request a certificate via the Admin Tool GUI as well, instead of CLI like above.

## Stop and remove services 

```sh
$ docker-compose down
```

## Kafka authorization
At this point, every authenticated user (with a valid certificate) can access any Kafka consumer group or topic. In order to restrict topic/group access, optionally, you can enable authorization on the test-bed as follows:

First stop and remove any running service as told previoulsy, then boot up again:

```sh
$ docker-compose down
$ docker-compose -f docker-compose.yml -f docker-compose+authz.yml up -d
```

This boots up the Authorization Service and enables a special Kafka Authorizer integrated with the Authorization Service.

If you intend to enable Kafka authorization most of the time, create a symbolink link named `docker-compose.override.yml` to `docker-compose+authz.yml` (use `ln` command on Linux, or `mklink` on Windows 10). With that symlink, you can use the simple command as usual:

```sh
$ docker-compose up -d
```

Indeed, by default, [Compose reads two files](https://docs.docker.com/compose/extends/#understanding-multiple-compose-files), a `docker-compose.yml` and an optional `docker-compose.override.yml` file.

For testing, replace `admin-tool-client-ssl.properties` with a normal user configuration (as opposed to the Admin Tool that is superadmin) such as `other-tool-1-client-ssl.properties`.

To disable authorization, shutdown Compose and remove the symlink before you restart:

```sh
$ docker-compose down
$ rm docker-compose.override.yml
$ docker-compose up -d
```

More info in [Kafka documentation](https://kafka.apache.org/documentation/#security_configclients).

## Testing Kafka security with the demo chat application
For demo purposes, you can use the Secure Kafka Chat application - provided on DRIVER+'s repository - that uses Kafka topics as chatrooms.

1. Get the last released JAR (`.jar` file) of the Chat app from [Driver's Maven repository on github](https://github.com/DRIVER-EU/maven-repo/tree/master/com/sothawo/kovasbak): `kovasbak-XXX.jar` (replace `XXX` with the current version).


1. Run a first Chat participant (using a Kafka client backend), e.g. the sample Admin Tool:

    ```sh
    $ cd sample-ssl-clients
    $ java -jar /path/to/kovasbak-1.0.0.jar --spring.config.location=sec-kafka-chat-admin.yml
    ```

    The app uses properties in the file specified by `spring.config.location` .

    *If you wish to override properties in the above `.yml` file on the command line, you specify them prefixed with `--` and before `--spring.config.location` as follows:*

    ```sh
    $ java -jar /path/to/kovasbak-1.0.0.jar --server.port=6666 --spring.config.location=sec-kafka-chat-admin.yml
    ```

    This overrides the `server.port` property, which is the port that the local web chat server for the web UI is listening to.
    Overriding this property is useful if you want to start multiple instances of the app on your host, in order to use different participant identities (Kafka clients using different TLS client certificates), one per instance.

    There are two other important application properties you may wish to customize:
    - `chat.rooms`: comma-separated list of chat rooms the chat participant may participate in, each room corresponds to a Kafka topic;
    - `spring.kafka.consumer.group-id` (optional): Kafka consumer group ID.

1. Once the app is running, you can access the chat app's web UI by opening a browser to `http://localhost:${server.port}`, where `server.port` is `8080` by default.

1. Run a second chat participant, e.g. the sample "Other Tool 1":

    ```sh
    $ java -jar /path/to/kovasbak-1.0.0.jar --spring.config.location=sec-kafka-chat-other-tool-1.yml
    ```

    If authorization is enabled on the test-bed, you will notice a bunch of authorization errors in the console. In this case, follow the instructions in section [Testing with authorization](#testing-with-authorization), then restart the chat participant and make sure these errors are gone, before going further.

1. Start typing messages in one or the other chat participant's browser tab/window on the same room, by accessing the right `http://localhost:${server.port}` URL depending on the chat participant's `server.port`. Notice that messages sent from one chat participant's window are received on the other chat participant's window.
1. You may also run another chat participant using a certificate generated using the provided [python script](sample-ssl-clients/enroll-cert.py). This script enables you to request a certificate from the command line for a given solution in a given organization in one shot (by running the script) instead of using the Admin Tool UI:

```sh
$ cd sample-ssl-clients
$ python3 enroll-cert.py best.solution.com BestOrganization
```

The first argument is the solution name, in a form of CommonName (CN), e.g. a FQDN (Fully Qualified Domain Name) that uniquely identifies your solution. The second argument is the name of the solution's organization (use the short form preferably). It will prompt for the password you want to use to protect the .p12 (private key in particular).

**The script requires Python 3.6 or later, and `requests_pkcs12` module (can be installed with `pip install requests_pkcs12`). On some platforms, you may have to use simply `python` instead of `python3`, depending on the name of the Python 3.x executable.**

Then you have to use the [sec-kafka-chat-enrolled-user.yml](sample-ssl-clients/sec-kafka-chat-enrolled-user.yml) file as `spring-config-location` argument to run the chat app. You'll have to change the keystore (.p12 file) location in that file, according to where the .p12 file was saved by the script.

### Testing with authorization
If authorization is enabled on the test-bed (see previous section for enabling/disabling authorization), each Chat participant, i.e. Kafka client, except for the Admin Tool - the superadmin with all privileges - must be authorized explicitly (by a policy in the Authorization Service) to:
- publish/subscribe to the topics listed by `chat.rooms` property;
- create those topics if they are not already created by another participant;
- join its consumer group defined by `spring.kafka.consumer.group-id` if one is defined (non-empty).

In this sample scenario, we assume the Admin Tool participant is started first in the previous command, and therefore all topics created successfully by the Admin Tool. In our example, the other participant "Other Tool 1" has the same `chat.rooms`, therefore is using the same Kafka topics. So we don't need to authorize the latter to create the topics (already done by the Admin Tool) but we still need to authorize it to join its consumer group and to publish/subscribe to the topics. You authorize such actions on the Authorization Service as a system admin, either with the Admin Tool, or using the REST API directly with the command line as described below. 

1. If authorization enabled, you have to authorize `Other Tool 1` to join the consumer group specified by `spring.kafka.consumer.group-id` property (`firefighters`) with the Admin Tool, or with the command line:

    ```sh
    $ curl --verbose --include -k --cert admin-tool-client.p12:changeit --cert-type p12  -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' --data @permit-other-tool-rd.policy.json 'https://localhost:9443/services/authz/pap/policies/resource.type=GROUP/policies;resource.id=firefighters'
    ```
    
    You may do the same for other users (solutions) by copying the file `permit-other-tool-rd.policy.json` to some temporary file, e.g. `/tmp/permit-my-user.policy.json`, and replacing the `subject.id` value in the JSON content with the subject name in the user certificate (e.g. `CN=some.user.name,O=SomeOrganization`), then redo the same command with argument `--data @/tmp/permit-my-user.policy.json` instead of `--data @permit-other-tool-rd.policy.json`.

1. If authorization enabled, in addition, you have to authorize the user to publish/subscribe the requested topics corresponding to the chatrooms (see `chat.rooms` property in the [config file](sec-kafka-chat-other-tool-1.yml) ). For demonstration purposes, we'll use group-based access control, i.e. grant permissions to the consumer group (`firefighters`) instead of granting to the user directly:

    ```sh
    $ curl --verbose --include -k --cert admin-tool-client.p12:changeit --cert-type p12  -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' --data @permit-firefighters-rwd.policy.json 'https://localhost:9443/services/authz/pap/policies/resource.type=TOPIC/policies;resource.id=all'

    $ curl --verbose --include -k --cert admin-tool-client.p12:changeit --cert-type p12  -X PUT -H 'Content-Type: application/json' -H 'Accept: application/json' --data @permit-firefighters-rwd.policy.json 'https://localhost:9443/services/authz/pap/policies/resource.type=TOPIC/policies;resource.id=COP'
    ```

    You may restart whatever chat participant having authorization issues, to see the changes.

## Certificate Management Service API

This section describes the REST API of the Certificate Management Service. It is relevant for Admin Tool developers or other developers willing to integrate directly with the Certificate Management Service without interacting via the Admin Tool. Solution providers and adapter developers should not have to read this section, except for personal understanding. They should use the instructions given in the previous section.

The Certificate Management Service allows end-users such as Kafka consumers to enroll certificates with a REST API. *Soon, the Admin Tool will provide a user interface for this.*
The Certificate Management Service is instantiated with a Certificate Authority (CA) named "Issuing CA" that is a sub-CA of the Root CA materialized in PKCS#12 keystore file `cert_mgt/root-ca.p12`.

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
                "username": "thesolution.the.org",
                "password": "changeit",
                "email": "thesolution.admin@the.org",
                "subject_dn":"CN=thesolution.the.org,O=TheOrganization",
                "ca_name": "Issuing_CA",
                "token_type": "P12"
        }
    ```
    
    Set the username to the DNS name of the solution/tool instance or, if it does have any, any valid Common Name - according to ITU-T Recommendation X.520 - that uniquely identifies the organization and solution/too. In the latter case, if the organization that owns the solution instance has a domain name, we recommend to use the pattern `<solution_name>.<domain_name_of_the_organization_owning_the_solution_instance>`, e.g. `thesolution.the.org` if the organization's domain name is `the.org`. In addition, set the `password` parameter to the password you want to use for protecting the generated keystore; and set the `email` parameter to the contact email address of the contact person/owner of the solution/tool; finally, set the subject_dn to  `CN=<username>,O=<Name_of_the_organization_owning_the_solution_instance>`.
    Leave the other fields unchanged.
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
  {"username":"thesolution.the.org", ...}
  ...
]}
```

Get a specific registered user info, e.g. user with `username=thesolution.the.org`:
```sh
$ curl -k -v --cert /tmp/superadmin.p12:cb40ec9ee9875580325c6a6e4d1b382fb3e521f8 --cert-type p12  -X GET -H 'Accept: application/json' -i 'https://localhost:8443/ejbca/ejbca-rest-api/v1/ees/thesolution.the.org'
```

You may deregister the user as follows:
```sh
$ curl -k -v --cert /tmp/superadmin.p12:cb40ec9ee9875580325c6a6e4d1b382fb3e521f8 --cert-type p12  -X DELETE -H 'Accept: application/json' -i 'https://localhost:8443/ejbca/ejbca-rest-api/v1/ees/thesolution.the.org'
```

### Certificate request (aka enrollment)
Once the user is registered, you can request a certificate for that user as follows:

1. Create a file, say `/tmp/certReq.json`, with the certificate request data as JSON object like this:

    ```js
    {
        "username":"thesolution.the.org",
        "password":"changeit",
        "key_alg":"RSA",
        "key_spec":"2048"
    }
    ```
    The username and password should match the registered user's username and password (see first step).
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
    
    You may do it in Java as well like this:
    ```java
	package test;
	
	import java.io.IOException;
	import java.nio.charset.StandardCharsets;
	import java.nio.file.Files;
	import java.nio.file.Paths;
	import java.util.Base64;
	
	public class EjbcaRestApiKeystoreDataParser
	{
	
		public static void main(final String[] args) throws IOException
		{
			final String encodedPem = new String(Files.readAllBytes(Paths.get("/tmp/keystore_data.txt")));
			System.out.println("Original: " + encodedPem);
			System.out.println();
			final byte[] pemBytes = Base64.getDecoder().decode(encodedPem);
			final String pem = new String(pemBytes, StandardCharsets.UTF_8);
			System.out.println("PEM: " + pem);
			System.out.println();
			final byte[] p12Bytes = Base64.getMimeDecoder().decode(pem);
			Files.write(Paths.get("/tmp/keystore.p12"), p12Bytes);
		}
	
	}
	```
	
1. Make sure the result P12 file is in the right format with a PKCS#12 tool such as openssl, keytool (or try import into your browser):
	```sh
	$ keytool -keystore /tmp/keystore.p12 -list
	
	Enter keystore password:  
	Keystore type: JKS
	Keystore provider: SUN
	
	Your keystore contains 1 entry
	
	thesolution.the.org, Sep 03, 2018, PrivateKeyEntry, 
	Certificate fingerprint (SHA1): 04:DC:24:E3:87:D9:16:F7:B4:7A:9A:2D:09:51:56:54:33:1B:0C:2A
	```
