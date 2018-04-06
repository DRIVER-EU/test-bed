# Usage

`docker-compose up -d`

This will start a trial1 dryrun version of the testbed reachable at *localhost*. 

To allow applications on other machines to connect to the testbed running on your machine:

Update the line `KAFKA_ADVERTISED_LISTENERS: 'EXTERNAL://localhost:3501,PLAINTEXT://broker:9092'` in the docker-compose.yml file. Change *localhost* to the ip or hostname of the network interface that you wish to expose the test-bed on.
