# Introduction

This 'Swarm' Test-Bed composition is created to allow running the Test-Bed on the Docker Swarm in combination with Traefik as a reverse proxy. Only the Broker and Schema Regsitry will still be exposed via a port. The other services are exposed via a relative URL on a specified domain name. Traefik also handles certificates for the domain by using lets-encrypt. This ensures that communication with all web services is performed via HTTPS without requiring configuration of the services themselves.

## Relative URL's for services:

The following services can be reached via HTTPS on these relative URL's, where TESTBED_HOST is the configured hostname for the Cloud Test-Bed:

* Topics-ui: https://TESTBED_HOST/topics-ui/
* Schema-ui: https://TESTBED_HOST/schema-ui/
* Time Service: https://TESTBED_HOST/time-service/
* Large File Service: https://TESTBED_HOST/large-file-service/
* Admin Tool: Not yet available, awaiting Issue: https://github.com/DRIVER-EU/test-bed-admin/issues/17

# Starting Traefik

Configuration for running Traefik can be found in the `docker/swarm/traefik` folder. It is also present on the Test-bed master machine at `/opt/traefik/`.

For more info on the Traefik config with lets-encrypt, please consult the [Traefik Documentation](https://docs.traefik.io/user-guide/docker-and-lets-encrypt/).

1. SSH to the test-bed master machine, and navigate to `/opt/traefik`.
2. Run `sudo docker stack deploy --compose-file docker-compose.yml traefik`

# Stopping Traefik

1. SSH to the test-bed mastr machine.
2. Run `sudo docker stack rm traefik`

# Test-Bed Configuration With Traefik

Traefik automatically listens to stacks and services starting on the Docker Swarm. Configuration can be provided via labels on the services in the stack. See https://github.com/DRIVER-EU/test-bed/blob/treafik/docker/swarm/docker-compose.yml for example.

Important labels are:

* `traefik.port=xxxx` the port on which the web service runs. Traefik will route from port 443 (HTTPS) to this port on the container.
* `traefik.enable=true` ensures that Traefik will function as a reverse proxy for this service. By default it will NOT in the current configuration.
* `traefik.docker.network=traefik-net` The Docker network that is used by Traefik to route to the container. This network 'traefik-net' has been predefined and is already present for the Docker Swarm at TNO.
* `traefik.frontend.rule=Host:${TESTBED_HOST};PathPrefixStrip:/relative-path/` specifies on which hostname and relative URL the service can be reached. Also allows modifying the request URL before forwarding requests to the service.  Many things are possible here, for more details please check the [Traefik Documentation](https://docs.traefik.io/basics/#frontends).

# Starting a new Cloud Test-Bed with Portainer

1. Go to the portainer instance running at http://134.221.20.201:9000/ and login.
2. Go to the 'Stacks' page by clicking Stacks in the left menu bar.
3. Click 'Add Stack'
4. Provide a suitable name for the Test-Bed stack (e.g. tb4 or test-bed-4)
5. Paste the docker-compose file located in `docker/swarm/docker-compose.yml` (see [here](https://github.com/DRIVER-EU/test-bed/blob/treafik/docker/swarm/docker-compose.yml)) into the web editor. Alternatively use the upload form and upload the docker-compose file directly.
6. Scroll down. Under Environment: add 3 environment variables:
  1. `TESTBED_HOST` the hostname to be used for the test-bed (e.g. tb4.driver-testbed.eu)
  2. `BROKER_PORT` the port to be used by the kafka broker (e.g. 3501). This port must not already be in use by another stack or service.
  3. `SCHEMA_REGISTRY_PORT` the port to be used by the schema registry (e.g. 3502). This port must not already be in use by another stack or service.
  4. `ADMINTOOL_PORT` (temporary) the port to be used by the AdminTool Web UI (e.g. 809*X*, for domain tb*X*.driver-testbed.eu). **TODO: make it work behind traefik proxy (WebSocket issue to be solved)**
  5. `CERT_MGT_PORT` the port to be used by the Certificate Management's Admin Web UI for testbed security experts (e.g. 844*X*, for domain tb*X*.driver-testbed.eu)
7. Press 'Deploy the stack'.
8. Traefik (running in the Traefik stack) will now automatically pick up the starting pack and handle routing for the configured domain.

*Available Domain Names*

Currently the available domain names for the Docker Swarm are tb1.driver-testbed.eu up to tb10.driver-testbed.eu

# Stopping a Cloud Test-Bed

1. Go to the portainer instance running at http://134.221.20.201:9000/ and login.
2. Go to the 'Stacks' page by clicking Stacks in the left menu bar.
3. Check the Test-Bed stack you wish to remove and press remove.

# Updating Services in a Running Stack

If a service (for example the admin tool) has been updated to a newer version, it is possible to update a running stack.

1. Go to the portainer instance running at http://134.221.20.201:9000/ and login.
2. Go to the 'Stacks' page by clicking Stacks in the left menu bar.
3. Click the Stack you wish to update.
4. You can now make changes to the composition under 'Stack editor'. For example by upgrading the image version of the admin tool.
5. Press 'Update the stack'.
6. The updated containers are now automatically restarted for you.
7. Traefik (running in the Traefik stack) will now automatically pick up the restarted containers and handle routing.
