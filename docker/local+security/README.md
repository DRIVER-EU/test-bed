## Docker with security features

This is similar to [docker/local](../local) folder, except it provides extra security features, especially for access control:
* **Combined ACL-XACML authorizer for Apache Kafka**: based on [DRIVER+'s kafka-combined-acl-xacml-authorizer project](https://github.com/DRIVER-EU/kafka-combined-acl-xacml-authorizer) and deployed in the Kafka broker service, it enhances the native Kafka ACL-based *authorizer* with standard [XACML](http://docs.oasis-open.org/xacml/3.0/xacml-3.0-core-spec-os-en.html) evaluation, by interacting with the XACML PDP's REST API provided by the Authorization service below. 
* **Authorization service**: provides a REST API for managing Attribute-based Access Control (ABAC) policies in XACML - Kafka topic access policies in this case - also called PAP (Policy Administration Point) in XACML jargon; and a REST API for getting authorization decisions according to those ABAC policies, also called PDP (Policy Decision Point) in XACML jargon. The PDP API complies with [REST Profile of XACML 3.0](http://docs.oasis-open.org/xacml/xacml-rest/v1.0/xacml-rest-v1.0.html) and the endpoint address is given by the environment variable `KAFKA_ORG_OW2_AUTHZFORCE_KAFKA_PEP_XACML_PDP_URL` in the [docker-compose file](docker-compose.yml). The PAP API is described in the [Authorization Service project's README](https://github.com/DRIVER-EU/test-bed-security-authorization-service/blob/master/README.md#api-usage), and the endpoint address is the same as the PDP after replacing `pdp` with `pap` at the end.


# Usage

## Build, create and start services

```sh
$ ./preinst.sh
$ docker-compose up -d
```

## Kafka client authentication
Once the services are running, Kafka clients must authenticate to the Kafka `broker` service using [SSL certificate authentication](https://kafka.apache.org/documentation/#security_ssl) with a client certificate issued by the Certificate Authority in [ca_service](ca_service) folder (keystore file is `ca.p12`). You can find in folder [sample-ssl-clients](ca_service/sample-ssl-clients) a few examples of SSL client files (certificates and keystores) for testing:
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
