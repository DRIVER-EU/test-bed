FROM enoniccloud/apache2-letsencrypt

COPY vhost-ssl.conf /etc/apache2/sites-available/vhost-ssl.conf

# Override original launcher.sh for more debugging
COPY launcher-verbose.sh /usr/local/bin/launcher-verbose.sh

RUN a2enmod -q headers &&\
    a2enmod -q remoteip &&\
    a2enmod -q rewrite &&\
    a2enmod -q proxy &&\
    a2enmod -q proxy_http &&\
    a2enmod -q proxy_wstunnel &&\
    a2dissite -q 000-default.conf &&\
    a2dissite -q default-ssl.conf &&\
    chmod +x /usr/local/bin/launcher-verbose.sh

