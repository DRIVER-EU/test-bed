# Usage

`docker-compose up -d`

# Updating the test-bed hostname

Update the line `KAFKA_ADVERTISED_LISTENERS: 'EXTERNAL://localhost:3501,PLAINTEXT://broker:9092'` in the docker-compose.yml file. Change *localhost* to the ip or hostname of the network interface that you wish to expose the test-bed on.
