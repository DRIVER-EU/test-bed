# Local Kafka environment to interact with XVR OS

The more generic schemas in the `schemas/sim` folder have been renamed to include the `xvr_` preamble. These are the messages that XVR needs to understand and support.

## Starting the testbed

```bash
docker-compose up -d
```

Useful links:

- [Kafka topics and schema registry](http://localhost:3600/) to view exchanged messages
- [Trial Management Tool](http://localhost:3210/tmt) to create or run a scenario. You can use it to send inputs to XVR, e.g. an inject.

NOTE that in this version, the Kafka port has been changed to 9092 from localhost, port 29092 from inside the docker. When running on a server, please change the KAFKA listener 'ALICE' to have the correct IP address.

## Configuring XVR OS

...Describe how to configure XVR OS so it will connect to Kafka.

## Miscellaneous

### XVR Inputs

- `xvr_simulation_request_startinject`: A start inject request is a specific request for starting a pre-defined sequence of events defined at one or more connected applications.
- `xvr_simulation_request_move`: A move request is a specific request for moving or transporting a given simulation entity towards a given destination, possibly over a given set of waypoints or route.
- `xvr_simulation_request_ownership`: An ownership request is a specific request for becoming owner of a given simulation entity.
- `xvr_simulation_request_route`: A route request is a specific request for calculating a route from a starting location, passing through several waypoints.
- `xvr_simulation_entity_post`: A post is a specific entity representing a piece of writing, image or other content published. Examples of posts can range from (e-)mail to social media posts.

### XVR Outputs

- `xvr_simulation_entity_featurecollection`: A feature collection represents one or more points, lines, or areas of interest to the common simulation space. For example, specific places or buildings, routes, borders, flooded areas or disaster zones. A well-known standard for sharing a collection of geographic features is GeoJSON, created by the Internet Engineering Task Force (IETF), RFC 7946. Each feature can be a point, multi-point, line, multi-line, polyline, polygon, or multi-polygon (with or without holes). In addition, every feature has a map of arbitrary properties for other standards or specifications to include relevant information per feature. Similar to the simplestyle specification, this CWA defines a list of common feature properties for structuring additional information about its context on top of the GeoJSON standard, making it easier to share simulation relevant data. 
- `xvr_simulation_entity_item`: An item is a specific entity that is bound to one position in the world. It should represent a tangible object, person or vehicle.
- `xvr_simulation_entity_post`: A post is a specific entity representing a piece of writing, image or other content published. Examples of posts can range from (e-)mail to social media posts.
- `xvr_simulation_entity_aggregation`: The entity aggregation message is a wrapper message containing a map with all entities that require an aggregated update. The values of this map would be the defined entity messages, with all described properties to be optional allowing the message to only contain the relevant changed properties. 
- `xvr_simulation_entity_deletion`: An entity deletion message is a support messages indicating a shared entity should no longer be shared.
