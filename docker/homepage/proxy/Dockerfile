FROM httpd:2.4

LABEL creator="Cyril Dangerville <https://github.com/cdanger>"
LABEL maintainer="Cyril Dangerville <https://github.com/cdanger>"

COPY ./httpd-ssl.conf /usr/local/apache2/conf/extra/httpd-ssl.conf
COPY ./httpd.conf /usr/local/apache2/conf/httpd.conf
# Needed only if OIDC Provider is on same host as Apache
# COPY vhost-8443.conf /usr/local/apache2/conf/vhost-8443.conf

# Override original launcher.sh for more debugging
COPY launcher-verbose.sh /usr/local/bin/launcher-verbose.sh

# Install cerbot for Let's Encrypt certificates, uuid-runtime for random number generation in launcher-verbose.sh, and missing dependencies of libapache2-mod-auth-openidc
# We don't want to install libapache2-mod-auth-openidc package because it requires apache2 deb package install which is not compatible with this httpd image (not using apache2 deb package) 
RUN apt-get update -y &&\
    apt-get install software-properties-common -y &&\
    add-apt-repository universe -y &&\
    add-apt-repository ppa:certbot/certbot -y &&\
    apt-get install certbot libhiredis0.14 libcjose0 uuid-runtime ssl-cert -y &&\
    apt-get download libapache2-mod-auth-openidc &&\
    dpkg-deb -x $(ls libapache2-mod-auth-openidc*) /tmp/libapache2-mod-auth-openidc &&\
    cp /tmp/libapache2-mod-auth-openidc/usr/lib/apache2/modules/mod_auth_openidc.so /usr/local/apache2/modules/ &&\
    apt-get clean -y &&\
    chmod +x /usr/local/bin/launcher-verbose.sh

