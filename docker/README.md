# Testbed Docker Compose Files

In this directory you find the Testbed Docker Compose file that allows you to run the testbed on any machine that is [configured as a Docker host](https://docs.docker.com/engine/installation/).

## Initializing a new Local Test Bed

1. Navigate to the `./docker/local/` directory
2. Run from the console: `docker-compose up -d`
3. Check if all the containers are running: `docker ps -a`

## Starting/Stopping the Local Test Bed

* To stop, run from the console: `docker-compose stop`
* To start, run from the console: `docker-compose start`

##  Stop and Remove the Local Test Bed

* To stop and remove, run from the console: `docker-compose down`

This command removes all containers and thus data and configuration that was present in the testbed.

# Available Testbed Services

## Local Test Bed (localhost)

* Kafka Broker: `localhost:3501` or `PLAINTEXT://localhost:3501` depending on your adapter
* [Kafka Schema Registry](https://docs.confluent.io/current/schema-registry/docs/index.html): [http://localhost:3502](http://localhost:3502)
* Kafka Topics Browser UI: [http://localhost:3600](http://localhost:3600)
* Kafka Schema Browser UI: [http://localhost:3601](http://localhost:3601)
* Test-bed Admin Interface: [http://localhost:8090](http://localhost:8090). See the [GitHub Project Page](https://github.com/DRIVER-EU/test-bed-admin) for more info.
* Test-bed Large File Service: [http://localhost:9090/api](http://localhost:9090/api). See the [GitHub Project Page](https://github.com/DRIVER-EU/large-file-service)
* Test-bed Time Service: [http://localhost:8100/time-service/](http://localhost:8100/time-service/). See the [GitHub Project Page](https://github.com/DRIVER-EU/test-bed-time-service)

## Lightweight Local Test Bed (localhost)

The Lightweight Local Test-bed will contain the Test-bed in Dev Mode. This means no Admin Tool is started. Nextcloud is also excluded to save CPU/Memory resources.

* Kafka Broker: `localhost:3501` or `PLAINTEXT://localhost:3501` depending on your adapter
* [Kafka Schema Registry](https://docs.confluent.io/current/schema-registry/docs/index.html): [http://localhost:3502](http://localhost:3502)
* [Kafka Connect](https://docs.confluent.io/current/connect/index.html): [http://localhost:3504](http://localhost:3504)
* Kafka Topics Browser UI: [http://localhost:3600](http://localhost:3600)
* Kafka Schema Browser UI: [http://localhost:3601](http://localhost:3601)

## TNO Hosted Test Bed (driver-testbed.eu)

Up to 10 Test-beds can be hosted at the TNO Cloud (driver-testbed.eu), at hostnames tb1.driver-testbed.eu until tb10.driver-testbed.eu

This example is for https://tb1.driver-testbed.eu. Only the broker and schema registry use a port. All web services can be reached via a relative path.

* Kafka Broker: `tb1.driver-testbed.eu:3501` or `PLAINTEXT://tb1.driver-testbed.eu:3501` depending on your adapter
* [Kafka Schema Registry](https://docs.confluent.io/current/schema-registry/docs/index.html): [http://tb1.driver-testbed.eu:3502](http://tb1.driver-testbed.eu:3502)
* Kafka Topics Browser UI: [https://tb1.driver-testbed.eu/topics-ui/](https://tb1.driver-testbed.eu/topics-ui/)
* Kafka Schema Browser UI: [https://tb1.driver-testbed.eu/schema-ui/](https://tb1.driver-testbed.eu/schema-ui/)
* Test-bed Admin Interface: Not yet available, awaiting https://github.com/DRIVER-EU/test-bed-admin/issues/17
* Test-bed Large File Service: [https://tb1.driver-testbed.eu/large-file-service/api](https://tb1.driver-testbed.eu/large-file-service/api). See the [GitHub Project Page](https://github.com/DRIVER-EU/large-file-service/)
* Test-bed Time Service: [https://tb1.driver-testbed.eu/time-service/](https://tb1.driver-testbed.eu/time-service/). See the [GitHub Project Page](https://github.com/DRIVER-EU/test-bed-time-service)

## Local Test Bed with Security-Enabled Kafka Broker for topic access control (localhost)
*More info in the [README](local+security/README.md)*
* Zookeeper: `localhost:3500`
* Kafka Broker: `localhost:3501` or `SSL://localhost:3501` depending on your adapter, requires client certificate authentication and authorization by the Authorization Service below
* [Authorization Service](https://github.com/DRIVER-EU/test-bed-security-authorization-service):  `https://localhost:8443/services/authz/pap` for topic access policy administration by the Admin Tool, requires client certificate authentication
* [Kafka Schema Registry](https://docs.confluent.io/current/schema-registry/docs/index.html): [http://localhost:3502](http://localhost:3502)
* [Kafka Connect](https://docs.confluent.io/current/connect/index.html): [http://localhost:3504](http://localhost:3504)
* [Kafka REST Proxy](https://docs.confluent.io/current/kafka-rest/docs/index.html): [http://localhost:8082](http://localhost:8082).
* Kafka Topics Browser UI: [http://localhost:3600](http://localhost:3600)
* Kafka Schema Browser UI: [http://localhost:3601](http://localhost:3601)
* Test-bed Admin Interface: [http://localhost:8090](http://localhost:8090). See the [GitHub Project Page](https://github.com/DRIVER-EU/test-bed-admin) for more info.
* Test-bed Large File Service: [http://localhost:9090/api](http://localhost:9090/api). See the [GitHub Project Page](https://github.com/DRIVER-EU/large-file-service)
* Test-bed Time Service: [http://localhost:8100/time-service/](http://localhost:8100/time-service/). See the [GitHub Project Page](https://github.com/DRIVER-EU/test-bed-time-service)

