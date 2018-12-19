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
