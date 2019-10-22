# Identity and Access Management Service 
The Docker Compose file enables to run an Identity and Access Management (IAM) service based on Keycloak (and an associated PostgreSQL database), including authentication and SSO for Web applications mostly. It relies on OpenID Connect (OIDC) as standard SSO protocol, and plays the role of OpenID Connect Provider in this context. 

To run in a specific environment, just copy the provided `.env.sample` to `.env` file and customize the environment variables there.