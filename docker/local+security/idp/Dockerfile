FROM jboss/keycloak:6.0.1

LABEL maintainer="Cyril Dangerville <cyril.dangerville@thalesgroup.com>"
LABEL org.label-schema.vendor = "THALES"
LABEL org.label-schema.name="DRIVER+ Test-bed - Keycloak"
# LABEL org.label-schema.description=""

VOLUME /tmp

ARG WEBAUTHN_PLUGIN_VERSION
ENV WEBAUTHN_PLUGIN_URL="https://github.com/cdanger/keycloak-webauthn-authenticator/releases/download/${WEBAUTHN_PLUGIN_VERSION}/keycloak-webauthn4j-ear-${WEBAUTHN_PLUGIN_VERSION}.ear"

USER root

COPY docker-entrypoint.sh /opt/jboss/tools/docker-entrypoint-override.sh
COPY wtfc.sh /opt/wtfc.sh
RUN cd /opt/jboss/keycloak/standalone/deployments &&\
    curl --verbose --location ${WEBAUTHN_PLUGIN_URL} --output keycloak-webauthn4j-ear-${WEBAUTHN_PLUGIN_VERSION}.ear

USER 1000