# Usage

`docker-compose up -d`

## Allowing connections from other devices

This will start a trial1 dryrun version of the testbed reachable at *localhost*. 

To allow applications on other machines to connect to the testbed running on your machine:

Update the line `KAFKA_ADVERTISED_LISTENERS: 'EXTERNAL://localhost:3501,PLAINTEXT://broker:9092'` in the docker-compose.yml file. Change *localhost* to the ip or hostname of the network interface that you wish to expose the test-bed on.

## Updating the Gateway Converter (XVR Item to GeoJSON) Topics

Update the input (xvritem) and output (geojson) topics of the gateway converter in the config/xvritem-geojson-converter/gatewayconverter.properties file.
