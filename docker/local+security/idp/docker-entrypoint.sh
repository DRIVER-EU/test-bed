#!/bin/bash
# -m option required to run fg command
set -exm

# Import custom realm if missing (must be mounted as volume)
function import_realm() {
    if [ -f "${KEYCLOAK_IMPORTED_REALM}" ]; then
        realm_name=$(jq -r ".id" ${KEYCLOAK_IMPORTED_REALM})
        echo "Waiting for server to be running before realm import"
        /opt/wtfc.sh --progress --timeout=600 --interval=10 --status=0 curl --verbose --max-time 5 http://${KEYCLOAK_HOSTNAME}:8080/auth 
        echo "Importing realm ${realm_name} into Keycloak from ${KEYCLOAK_IMPORTED_REALM}"
        /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://${KEYCLOAK_HOSTNAME}:8080/auth --realm master --user ${KEYCLOAK_USER} --password ${KEYCLOAK_PASSWORD} --client admin-cli
        # /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://iam.corp-demo.com:8080/auth --realm master --user admin --password changeit --client admin-cli
        if /opt/jboss/keycloak/bin/kcadm.sh get realms/${realm_name}; then
            echo "Realm ${realm_name} already present. Skipping."
        else
            # Do not use partialImport which fails to set the Realm settings and requires to create the realm first with create command
            /opt/jboss/keycloak/bin/kcadm.sh create realms -f ${KEYCLOAK_IMPORTED_REALM}
        fi
    fi
}

# Call the entrypoint script from parent Keycloak Docker image
echo "Entering custom entrypoint"
/opt/jboss/tools/docker-entrypoint.sh &
import_realm
# Move jboss process back to foreground
jobs
fg 1
