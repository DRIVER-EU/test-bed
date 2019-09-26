#!/bin/bash
set -x

# Extract main domain name for Apache ServerName and if Letsencrypt enabled, for certificate directory name
SERVER_NAME=$(echo ${DOMAIN_NAMES}| awk -F, '{print $1}')
sed -i "s/#{SERVER_NAME}/${SERVER_NAME}/g" /etc/apache2/sites-available/vhost-ssl.conf
sed -i "s/#{SERVER_ALIASES}/${DOMAIN_NAMES}/g" /etc/apache2/sites-available/vhost-ssl.conf

if [[ "x${LETS_ENCRYPT_EMAIL}" == "x" ]]; then
        # No Letsencrypt -> fallback to default key/certificate (self-signed)
        rm -rf /etc/letsencrypt/certs
        mkdir /etc/letsencrypt/certs
        ln -s /etc/ssl/private/ssl-cert-snakeoil.key /etc/letsencrypt/certs/privkey.pem 
	ln -s /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/letsencrypt/certs/cert.pem 
	ln -s /etc/ssl/certs/ssl-cert-snakeoil.pem /etc/letsencrypt/certs/chain.pem
else
	# Letsencrypt usage enabled
        echo "Checking local Letsencrypt certificates ( if /etc/letsencrypt/live/${SERVER_NAME}/privkey.pem exist )."
	if [[ ! -e "/etc/letsencrypt/live/${SERVER_NAME}/privkey.pem" ]]; then
    		DOMAIN_CMD="-d $(echo ${DOMAIN_NAMES} | sed 's/\s+/ -d /')"
  		# Do not use certbot --apache option (apache plugin) because then it will run apachectl configtest, checking ssl certificate files, so if this is the first launch, there is none
  		# it will also try to restart apache right away which we don't want
  		certbot -vv -n certonly ${LETS_ENCRYPT_TEST_FLAG} --standalone --no-self-upgrade --agree-tos -m "${LETS_ENCRYPT_EMAIL}" ${DOMAIN_CMD}
  		rm -rf /etc/letsencrypt/certs
  		ln -s /etc/letsencrypt/live/${SERVER_NAME} /etc/letsencrypt/certs
	else
  		certbot renew --no-random-sleep-on-renew --no-self-upgrade
	fi
fi

# Generating the JSON file returned on /services path (see vhost-443.conf for the URL-to-file mapping )
cat > /var/www/services.json <<EOF
    {
        "title":"${TESTBED_TITLE}",
        "services":{
            "admin":"${ADMINTOOL_HOST_PORT}",
            "tmt":"${TMT_HOST_PORT}",
            "aar":"${AAR_HOST_PORT}"
        },
        "debugServices":{
            "topics":"${TOPICS_UI_HOST_PORT}",
            "schemas":"${SCHEMA_UI_HOST_PORT}"
        },
        "otherServices":{
            "time":"${TIME_SERVICE_HOST_PORT}",
            "lfs":"${LFS_HOST_PORT}"
        }
    }
EOF

a2ensite -q vhost-ssl
# Launching Apache HTTP server
apache2 -DFOREGROUND



