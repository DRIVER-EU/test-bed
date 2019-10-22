FROM jboss/keycloak:7.0.0

LABEL maintainer="Cyril Dangerville <cyril.dangerville@thalesgroup.com>"
LABEL org.label-schema.vendor = "THALES"
LABEL org.label-schema.name="DRIVER+ Test-bed - Keycloak"
# LABEL org.label-schema.description=""

VOLUME /tmp

ARG WEBAUTHN_PLUGIN_VERSION
ENV WEBAUTHN_PLUGIN_URL="https://github.com/cdanger/keycloak-webauthn-authenticator/releases/download/${WEBAUTHN_PLUGIN_VERSION}/keycloak-webauthn4j-ear-${WEBAUTHN_PLUGIN_VERSION}.ear"

USER root

# For customizing default TLS key and certificate
#COPY tls.crt /etc/x509/https/tls.crt
#COPY tls.key /etc/x509/https/tls.crt
#COPY tls-ca-crt.pem /etc/x509/https/tls-ca-crt.pem

# Custom entrypoint script ("wrapping" original script from base image)
COPY docker-entrypoint.sh /opt/jboss/tools/docker-entrypoint-wrapper.sh
COPY wtfc.sh /opt/wtfc.sh
# Add third-party plugin for FIDO2/Webauthn plugin
RUN cd /opt/jboss/keycloak/standalone/deployments &&\
    curl --verbose --location ${WEBAUTHN_PLUGIN_URL} --output keycloak-webauthn4j-ear-${WEBAUTHN_PLUGIN_VERSION}.ear

# Install certbot for Letsencrypt certificate retrieval
# And change permissions so that the command script may create symlinks in /etc/x509/https to map the tls.crt and tls.key to different files depending on whether Let's encrypt.org is used 
# RUN chown -R 1000 /etc/x509/https &&\
RUN yum install -y certbot &&\
    yum clean all

#USER 1000
