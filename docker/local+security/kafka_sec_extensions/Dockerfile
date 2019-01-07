FROM alpine:latest

LABEL maintainer="Cyril Dangerville <cyril.dangerville@projectdriver.eu>"

ARG AUTHZFORCE_EXT_VERSION

RUN apk add --no-cache wget &&\
    wget --verbose --no-clobber http://central.maven.org/maven2/org/ow2/authzforce/authzforce-ce-kafka-extensions/${AUTHZFORCE_EXT_VERSION}/authzforce-ce-kafka-extensions-${AUTHZFORCE_EXT_VERSION}-bin.tar.gz &&\
    tar xvzf authzforce-ce-kafka-extensions-${AUTHZFORCE_EXT_VERSION}-bin.tar.gz &&\
    rm authzforce-ce-kafka-extensions-${AUTHZFORCE_EXT_VERSION}-bin.tar.gz &&\
    ln -s authzforce-ce-kafka-extensions-${AUTHZFORCE_EXT_VERSION} /kafka_sec_extensions

CMD ["/bin/true"]


