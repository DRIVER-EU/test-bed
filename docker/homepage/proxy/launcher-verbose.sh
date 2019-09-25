#!/bin/bash
set -x

ls -l /etc/apache2/sites-enabled

echo "Checking certificates ( if /etc/letsencrypt/live/driver-testbed.eu/privkey.pem exist )."
if [[ ! -e /etc/letsencrypt/live/driver-testbed.eu/privkey.pem ]]
then
  if [[ ! "x$LETS_ENCRYPT_DOMAINS" == "x" ]]; then
    DOMAIN_CMD="-d $(echo $LETS_ENCRYPT_DOMAINS | sed 's/,/ -d /')"
  fi

  # Do not use certbot --apache option (apache plugin) because then it will run apachectl configtest, checking ssl certificate files, so if this is the first launch, there is none
  # it will also try to restart apache right away which we don't want
  certbot -vvv -n certonly --test-cert --standalone --no-self-upgrade --agree-tos -m "$LETS_ENCRYPT_EMAIL" $DOMAIN_CMD
  rm -rf /etc/letsencrypt/certs
  ln -s /etc/letsencrypt/live/driver-testbed.eu /etc/letsencrypt/certs
else
  certbot renew --no-random-sleep-on-renew --no-self-upgrade
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

# Launching Apache HTTP server
apache2 -DFOREGROUND



