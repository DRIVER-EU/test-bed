#!/bin/bash
# -m option required to run fg command
set -exm

# Import custom realm if missing (must be mounted as volume)
function import_realm() {
    if [ -f "${KEYCLOAK_IMPORTED_REALM}" ]; then
        realm_name=$(jq -r ".id" ${KEYCLOAK_IMPORTED_REALM})
        echo "Waiting for server to be running before realm import"
	# Assuming only one public interface IP address (in Docker container)
	BIND_IP=$(hostname --all-ip-addresses | tr -d '\n ')
        /opt/wtfc.sh --progress --timeout=600 --interval=10 --status=0 curl --verbose --max-time 5 http://${BIND_IP}:8080/auth 
        echo "Importing realm ${realm_name} into Keycloak from ${KEYCLOAK_IMPORTED_REALM}"
        /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://${BIND_IP}:8080/auth --realm master --user ${KEYCLOAK_USER} --password ${KEYCLOAK_PASSWORD} --client admin-cli
        if /opt/jboss/keycloak/bin/kcadm.sh get realms/${realm_name}; then
            echo "Realm ${realm_name} already present. Skipping."
        else
            # Do not use partialImport which fails to set the Realm settings and requires to create the realm first with create command
            /opt/jboss/keycloak/bin/kcadm.sh create realms -f ${KEYCLOAK_IMPORTED_REALM}
        fi
    fi
}

function setup_tls() {
   rm -rf /etc/x509/https/tls.{crt,key}
   if [[ "x${LETS_ENCRYPT_EMAIL}" == "x" ]]; then
        # No letsencrypt, use default key & cert provided with the docker image
	echo "Let's Encrypt.org certificate usage disabled. Using Keycloak default auto-generated key and certificate"
        #CERT_PATH="/etc/x509/https/default-tls.crt"
        #KEY_PATH="/etc/x509/https/default-tls.key"
   else
        # Letsencrypt usage enabled
        echo "Checking local Letsencrypt certificates ( if /etc/letsencrypt/live/${CERT_CN}/privkey.pem exist )."
        if [[ ! -e "/etc/letsencrypt/live/${CERT_CN}/privkey.pem" ]]; then
                certbot -vv -n certonly ${LETS_ENCRYPT_CERTBOT_FLAGS} --standalone --no-self-upgrade --agree-tos -m "${LETS_ENCRYPT_EMAIL}" -d ${CERT_CN}
                ln -s /etc/letsencrypt/live/${SERVER_NAME} /etc/letsencrypt/certs
        else
                certbot renew --no-random-sleep-on-renew --no-self-upgrade
        fi
        CERT_PATH="/etc/letsencrypt/live/${CERT_CN}/cert.pem"
        KEY_PATH="/etc/letsencrypt/live/${CERT_CN}/privkey.pem"
        mkdir -p /etc/x509/https
        ln -s ${CERT_PATH} /etc/x509/https/tls.crt
        ln -s ${KEY_PATH} /etc/x509/https/tls.key
        #ls -l /etc/x509/https
        #ls -l /etc/letsencrypt/live/${CERT_CN}
   fi
}

# Call the entrypoint script from parent Keycloak Docker image
echo "Entering custom entrypoint"
setup_tls
/opt/jboss/tools/docker-entrypoint.sh &
import_realm
# Move jboss process back to foreground
fg 1
