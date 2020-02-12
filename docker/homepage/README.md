# Usage

1. Copy the file `.env.sample` to `.env` and set the environment variables there according to your preferences.
1. Run docker-compose

```console
docker-compose up -d
```

In the next sections, we will address a few common scenarios and how to set environment variables accordingly.

# Running locally without access control (testing only)
If you want to test locally without (OpenID Connect) authentication/authorization, proceed as follows:

1. Add the hostname `driver-testbed.localdomain` to your `/etc/hosts` file (or Windows equivalent) with a local IP address, e.g. 127.0.0.2, so that the hostname is resolved locally (but do not use `localhost` name, else the test is not realistic enough)
1. Add the environment variables as follows 
    ```
    ...
    DOMAIN_NAMES=driver-testbed.localdomain

    # Set variable below to empty string to disable OIDC auth
    OIDC_PROVIDER_METADATA_URL=

    OIDC_VALIDATE_PROVIDER_CERT=Off
    ...
    ```

1. Run docker-compose as follows:
   ```
   $ docker-compose -f docker-compose-no-iam-net.yml up -d
   ```
1. With your local browser (tested with Chrome), go to: https://driver-testbed.localdomain/
You should get a security warning because it is using a self-signed certificate, just for testing.