FROM openjdk:8-jre-alpine
LABEL maintainer="Cyril Dangerville <cyril.dangerville@projectdriver.eu>"
LABEL org.label-schema.schema-version = "1.0"
LABEL org.label-schema.vendor = "THALES"
LABEL org.label-schema.name="DRIVER+ EU Project - Testbed Authorization Service"
# LABEL org.label-schema.description=""

ARG JAR_VERSION
ENV JAR_URL="https://raw.githubusercontent.com/DRIVER-EU/maven-repo/master/eu/driver/driver-testbed-sec-authz-service/${JAR_VERSION}/driver-testbed-sec-authz-service-${JAR_VERSION}.jar"
VOLUME /tmp

# COPY target folder must match policyLocation's folder in config/pdp.xml
COPY config/default-policies /opt/driver-testbed-sec-authz-service/data/policies

RUN apk --no-cache add curl &&\
    curl --verbose --output /app.jar --location $JAR_URL

EXPOSE 8443
ARG JAVA_OPTS
ENV JAVA_OPTS="$JAVA_OPTS"
CMD ["java",$JAVA_OPTS,"-jar","/app.jar"]