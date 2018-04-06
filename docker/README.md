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

* Zookeeper: `localhost:3500`
* Kafka Broker: `localhost:3501` or `PLAINTEXT://localhost:3501` depending on your adapter
* [Kafka Schema Registry](https://docs.confluent.io/current/schema-registry/docs/index.html): [http://localhost:3502](http://localhost:3502)
* [Kafka Connect](https://docs.confluent.io/current/connect/index.html): [http://localhost:3504](http://localhost:3504)
* [Kafka REST Proxy](https://docs.confluent.io/current/kafka-rest/docs/index.html): [http://localhost:8082](http://localhost:8082).
* Kafka Topics Browser UI: [http://localhost:3600](http://localhost:3600)
* Kafka Schema Browser UI: [http://localhost:3601](http://localhost:3601)
* Kafka Connect Browser uI: [http://localhost:3602](http://localhost:3602)

## TNO Hosted Test Bed (driver-testbed.eu)

** NOTE: the TNO Hosted Test Bed will be offline from 6-4-2018 until 9-4-2018 due to a power outtage **

* Zookeeper: `driver-testbed.eu:3500`
* Kafka Broker: `driver-testbed.eu:3501` or `PLAINTEXT://driver-testbed.eu:3501` depending on your adapter
* [Kafka Schema Registry](https://docs.confluent.io/current/schema-registry/docs/index.html): [http://driver-testbed.eu:3502](http://driver-testbed.eu:3502)
* [Kafka Connect](https://docs.confluent.io/current/connect/index.html): [http://driver-testbed.eu:3504](http://driver-testbed.eu:3504)
* [Kafka REST Proxy](https://docs.confluent.io/current/kafka-rest/docs/index.html): [http://driver-testbed.eu:8082](http://driver-testbed.eu:8082).
* Kafka Topics Browser UI: [http://driver-testbed.eu:3600](http://driver-testbed.eu:3600)
* Kafka Schema Browser UI: [http://driver-testbed.eu:3601](http://driver-testbed.eu:3601)
* Kafka Connect Browser uI: [http://driver-testbed.eu:3602](http://driver-testbed.eu:3602)
