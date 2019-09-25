FROM enoniccloud/apache2-letsencrypt

COPY vhost-80.conf /etc/apache2/sites-available/vhost-80.conf
COPY vhost-443.conf /etc/apache2/sites-available/vhost-443.conf

# Override original launcher.sh for more debugging
COPY launcher-verbose.sh /usr/local/bin/launcher-verbose.sh

RUN a2enmod headers &&\
    a2enmod remoteip &&\
    a2enmod rewrite &&\
    a2enmod proxy &&\
    a2enmod proxy_http &&\
    a2enmod proxy_wstunnel &&\
    a2dissite 000-default.conf &&\
    a2dissite default-ssl.conf &&\
    a2ensite vhost-80 &&\
    a2ensite vhost-443 &&\
    chmod +x /usr/local/bin/launcher-verbose.sh

