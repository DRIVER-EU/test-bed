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

## Local Test Bed

* Zookeeper: `localhost:3500`
* Kafka Broker: `localhost:3501` or `PLAINTEXT://localhost:3501` depending on your adapter
* [Kafka Schema Registry](https://docs.confluent.io/current/schema-registry/docs/index.html): [http://localhost:3502](http://localhost:3502)
* [Kafka Connect](https://docs.confluent.io/current/connect/index.html): [http://localhost:3504](http://localhost:3504)
* [Kafka REST Proxy](https://docs.confluent.io/current/kafka-rest/docs/index.html): [http://localhost:8082](http://localhost:8082).
* Kafka Topics Browser UI: [http://localhost:3600](http://localhost:3600)
* Kafka Schema Browser UI: [http://localhost:3601](http://localhost:3601)
* Kafka Connect Browser uI: [http://localhost:3602](http://localhost:3602)

## TNO Hosted Test Bed

* Zookeeper: `driver-testbed.eu:3500`
* Kafka Broker: `driver-testbed.eu:3501` or `PLAINTEXT://driver-testbed.eu:3501` depending on your adapter
* [Kafka Schema Registry](https://docs.confluent.io/current/schema-registry/docs/index.html): [http://driver-testbed.eu:3502](http://driver-testbed.eu:3502)
* [Kafka Connect](https://docs.confluent.io/current/connect/index.html): [http://driver-testbed.eu:3504](http://driver-testbed.eu:3504)
* [Kafka REST Proxy](https://docs.confluent.io/current/kafka-rest/docs/index.html): [http://driver-testbed.eu:8082](http://driver-testbed.eu:8082).
* Kafka Topics Browser UI: [http://driver-testbed.eu:3600](http://driver-testbed.eu:3600)
* Kafka Schema Browser UI: [http://driver-testbed.eu:3601](http://driver-testbed.eu:3601)
* Kafka Connect Browser uI: [http://driver-testbed.eu:3602](http://driver-testbed.eu:3602)

## Zookeeper

The Zookeeper instance is running and available at `localhost:3500`.

## Kafka Broker

A single Kafka Broker is running and available at `PLAINTEXT://localhost:3501`.

## Schema Registry

The [Kafka Schema Registry](https://docs.confluent.io/current/schema-registry/docs/index.html) is reachable at [http://localhost:3502](http://localhost:3502).

## Kafka Connect

The [Kafka Connect](https://docs.confluent.io/current/connect/index.html) REST endpoint is reachable at [http://localhost:3504](http://localhost:3504).

## Kafka REST Proxy

The [Kafka REST Proxy](https://docs.confluent.io/current/kafka-rest/docs/index.html) can be reached at [http://localhost:8082](http://localhost:8082).

## Kafka Topics UI

A web interface that allows you to browse and search the topics that are available on the Kafka cluster is available at [http://localhost:3600](http://localhost:3600).

## Kafka Schema Registry UI

A web interface that allows inspection and creation of AVRO schemas in the schema regisrty is available at [http://localhost:3601](http://localhost:3601).

## Kafka Connect UI

A web interface that allows inspection and creation of Kafka Connectors (data sinks and sources) is available at [http://localhost:3602](http://localhost:3602).
