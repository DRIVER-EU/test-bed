# How to deploy the secure testbed

## Install portainer-cli

```
$ git clone https://github.com/sparqueur/portainer-cli.git
$ cd portainer-cli
$ git checkout feature/stack_create_and_acl
$ make install
$ make
$ pip3 install dist/portainer-cli-0.3.0.tar.gz
```

*You may have noticed that we are using a fork from the official **portainer-cli** project. Because the latter does not yet support the `create_stack` command as of writing, for which there is a [pull request](https://github.com/Ilhasoft/portainer-cli/pull/5) pending. So we are using the forked repo of this PR for now.*

By default, the `portainer-cli` command will be installed in `~/.local/bin`, so make sure it's included in your `PATH` shell environment variable.

## Deploy the stack
Make sure the `.env` file passed to `--env-file` arg is formatted as a Docker .env file with all the Docker environment variables, esp. **BROKER_SECRETS_ZIP_URL**.

```
$ portainer-cli --debug configure https://<driver_portainer_hostname>:<port>/
$ portainer-cli --debug login <username> <password>
$ portainer-cli --debug create_stack --stack-name tb6-core --endpoint-id 1 --stack-file docker-compose.yml --env-file .env
```

### Re-deploy 
If you need to re-deploy, get the ID of the previously deployed stack:

```
$ portainer-cli --debug request /stacks
```

Then use the stack ID in the following stack_update command:

```
$ portainer-cli --debug update_stack --stack-id <stack_ID> --endpoint-id 1 --stack-file docker-compose.yml --env-file .env
```

You may add `--prune` option to prune the services before the update. 

[More info on the Portainer CLI](https://github.com/sparqueur/portainer-cli/tree/feature/stack_create_and_acl).