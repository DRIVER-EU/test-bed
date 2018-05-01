## Docker with security features

This is similar to [docker/local](docker/local) folder, except it provides extra security features, especially for access control:
* **Combined ACL-XACML authorizer for Apache Kafka**: based on [DRIVER+'s kafka-combined-acl-xacml-authorizer project](https://github.com/DRIVER-EU/kafka-combined-acl-xacml-authorizer) and deployed in the Kafka broker service, it enhances the native Kafka ACL-based *authorizer* with standard [XACML](http://docs.oasis-open.org/xacml/3.0/xacml-3.0-core-spec-os-en.html) evaluation, by interacting with the XACML PDP's REST API provided by the Authorization service below. 
* **Authorization service**: based on [AuthzForce Server](https://github.com/authzforce/server), it provides a REST API for managing Attribute-based Access Control (ABAC) policies in XACML - Kafka topic access policies in this case - also called PAP (Policy Administration Point) in XACML jargon; and a REST API for getting authorization decisions according to those ABAC policies, also called PDP (Policy Decision Point) in XACML jargon. The PDP API complies with [REST Profile of XACML 3.0](http://docs.oasis-open.org/xacml/xacml-rest/v1.0/xacml-rest-v1.0.html). Both APIs are described in [AuthzForce Server's documentation](https://authzforce-ce-fiware.readthedocs.io/en/latest/UserAndProgrammersGuide.html#policy-administration-api) (see *Policy Administration API* and *Policy Decision API*).

*In a later version, the Authorization Service will also support a simpler format (than XACML) for topic access policies, closer to the Kafka's native ACL format.*

# Usage

```console
./preinst.sh
docker-compose up -d
```

Stops containers and removes containers, networks, volumes, and images created by previous command:

```console
docker-compose down
```
