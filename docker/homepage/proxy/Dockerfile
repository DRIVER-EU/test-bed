FROM enoniccloud/apache2-letsencrypt

COPY vhost-443.conf /etc/apache2/sites-available/vhost-443.conf
COPY vhost-8443.conf /etc/apache2/sites-available/vhost-8443.conf
COPY ports.conf /etc/apache2/ports.conf

# Override original launcher.sh for more debugging
COPY launcher-verbose.sh /usr/local/bin/launcher-verbose.sh

RUN apt-get update -y &&\
    apt-get install libapache2-mod-auth-openidc uuid-runtime -y &&\
    apt-get clean -y &&\
    a2enmod -q headers &&\
    a2enmod -q remoteip &&\
    a2enmod -q rewrite &&\
    a2enmod -q proxy &&\
    a2enmod -q proxy_http &&\
    a2enmod -q proxy_wstunnel &&\
    a2enmod -q auth_openidc &&\
    chmod +x /usr/local/bin/launcher-verbose.sh

