FROM alpine:latest

LABEL maintainer="Cyril Dangerville <cyril.dangerville@projectdriver.eu>"

RUN apk add --no-cache wget &&\
    wget --verbose --no-clobber https://github.com/DRIVER-EU/kafka-combined-acl-xacml-authorizer/releases/download/release-${AUTHZFORCE_EXT_VERSION}/authzforce-ce-kafka-extensions-${AUTHZFORCE_EXT_VERSION}-bin.tar.gz &&\
    tar xvzf authzforce-ce-kafka-extensions-${AUTHZFORCE_EXT_VERSION}-bin.tar.gz &&\
    ln -s authzforce-ce-kafka-extensions-${AUTHZFORCE_EXT_VERSION} /opt/kafka_sec_extensions

CMD ["/bin/true"]


