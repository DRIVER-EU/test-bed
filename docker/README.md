# Testbed Docker Compose Files

In this directory you find the Testbed Docker Compose file that allows you to run the testbed on any machine that is [configured as a Docker host](https://docs.docker.com/engine/installation/).

## Initializing a new Local Test Bed

1. Navigate to the `./docker` directory
2. Run from the console: `docker-compose up -d`
3. Check if all the containers are running: `docker ps -a`

## Starting/Stopping the Local Test Bed

* To stop, run from the console: `docker-compose stop`
* To start, run from the console: `docker-compose start`

##  Stop and Remove the Local Test Bed

* To stop and remove, run from the console: `docker-compose down`

This command removes all containers and thus data and configuration that was present in the testbed.

# Configuring your Hosts File

If order to allow using the services provided by the testbed, several entries need to be [added to your hosts file](https://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/).

## Hosts Entries for Local Test Bed
For example, on Windows 10, you can find the `hosts` file at `C:\Windows\System32\drivers\etc\hosts`.

```
127.0.0.1	    broker
127.0.0.1	    zookeeper
127.0.0.1     kafka_rest
127.0.0.1	    schema_registry
127.0.0.1	    connect
```

# Available Testbed Services

Note: in order to use these services make sure you have added the above entries to your hosts file!

## Zookeeper

The Zookeeper instance is running and available at `zookeeper:3500`.

## Kafka Broker

A single Kafka Broker is running and available at `PLAINTEXT://broker:3501`.

## Schema Registry

The [Kafka Schema Registry](https://docs.confluent.io/current/schema-registry/docs/index.html) is reachable at [http://schema_registry:3502](http://schema_registry:3502) or [http://localhost:3502](http://localhost:3502).

## Kafka Connect

The [Kafka Connect](https://docs.confluent.io/current/connect/index.html) REST endpoint is reachable at [http://connect:3504](http://connect:3504) or [http://localhost:3504](http://localhost:3504).

## Kafka REST Proxy

The [Kafka REST Proxy](https://docs.confluent.io/current/kafka-rest/docs/index.html) can be reached at [http://kafka_rest:8082](http://kafka_rest:8082).

## Kafka Topics UI

A web interface that allows you to browse and search the topics that are available on the Kafka cluster is available at [http://localhost:3600](http://localhost:3600) if you run locally, or [http://driver-testbed.eu:3600](http://driver-testbed.eu:3600) if you use the TNO testbed.

## Kafka Schema Registry UI

A web interface that allows inspection and creation of AVRO schemas in the schema regisrty is available at [http://localhost:3601](http://localhost:3601) if you run locally, or [http://driver-testbed.eu:3601](http://driver-testbed.eu:3601) if you use the TNO testbed.

## Kafka Connect UI

A web interface that allows inspection and creation of Kafka Connectors (data sinks and sources) is available at [http://localhost:3602](http://localhost:3602) if you run locally, or [http://driver-testbed.eu:3602](http://driver-testbed.eu:3602) if you use the TNO testbed.
