# Usage

1. Copy the file `.env.sample` to `.env` and set the environment variables there according to your preferences.
1. Run docker-compose

```console
docker-compose up -d
```

# Running locally unprotected (without access control)
**For testing only.**
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

# Adding new application
If you want to add a new application behind the proxy, you need to know this app's base URL when running in the backend, and the public URL path on which you want to expose it on proxy, i.e. which path on the proxy it will be mapped to. Let's assume for example that this path is `/mynewapp/` and the backend URL is `http://mynewapp.example.com:8080/` and the required roles to access this app is `mynewapp_user` as defined in Keycloak (OIDC Provider) realm roles, then what you need to do is to insert these lines before the last in [proxy/httpd-ssl.conf](proxy/httpd-ssl.conf):

```
<Location "/mynewapp/">
  <IfDefine AccessControl>
    AuthType openid-connect
    Require claim realm_access.roles:mynewapp_user
  </IfDefine>

  ProxyPass "http://mynewapp.example.com:8080/"
</Location>
```
*The directives in the IfDefine section apply if and only if Access Control is enabled, i.e. if `OIDC_PROVIDER_METADATA_URL` is defined. Besides if you want finer-grained authorization, please refer to `mod_authz_core` [documentation](https://httpd.apache.org/docs/2.4/mod/mod_authz_core.html). *

Then restart the container, e.g. with:

```
$ docker-compose restart proxy
```


# Accessing OpenID Connect claims in the backend application
If OpenID Connect (OIDC) is enabled (environment variable `OIDC_PROVIDER_METADATA_URL` is set to a valid OpenID Connect Provider metadata URL), the user is authenticated when trying to access one of the protected applications. In this case, the proxy forwards the OIDC claims of the user to the backend app in request headers prefixed with `OIDC_CLAIM_`. You can find the list of standard claims in the [OIDC specification](https://openid.net/specs/openid-connect-core-1_0.html#StandardClaims).

In addition to the standard claims, the proxy adds a custom claim for the user roles which is forwarded in the request header `OIDC_CLAIM_realm_access.roles`. 

The proxy also forwards a `REMOTE_USER` header set to the username (corresponding to OIDC claim `preferred_username`).
