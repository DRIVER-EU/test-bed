FROM openjdk:8-jre-alpine
LABEL maintainer="Cyril Dangerville <cyril.dangerville@projectdriver.eu>"
LABEL org.label-schema.schema-version = "1.0"
LABEL org.label-schema.vendor = "THALES"
LABEL org.label-schema.name="DRIVER+ EU Project - Testbed Authorization Service"
# LABEL org.label-schema.description=""

VOLUME /tmp

COPY conf /opt/driver-testbed-sec-authz-service/conf
COPY application.yml /application.yml
ARG JAR_VERSION
ENV JAR_URL="https://raw.githubusercontent.com/DRIVER-EU/maven-repo/master/eu/driver/driver-testbed-sec-authz-service/${JAR_VERSION}/driver-testbed-sec-authz-service-${JAR_VERSION}.jar"

# Inside the container, copy the default policies to the folder that matches policyLocation's folder in conf/pdp.xml (missing directories in the path are created)
RUN mkdir /opt/driver-testbed-sec-authz-service/data &&\
    cp -r /opt/driver-testbed-sec-authz-service/conf/default-policies /opt/driver-testbed-sec-authz-service/data/policies &&\
    apk --no-cache add curl &&\
    curl --verbose --output /app.jar --location $JAR_URL

EXPOSE 8080
EXPOSE 8443
ENV JAVA_OPTS="-Djava.security.egd=file:/dev/./urandom -Djava.awt.headless=true -Djavax.xml.accessExternalSchema=all -Xms1024m -Xmx2048m -XX:+UseConcMarkSweepGC -server"
CMD ["java",$JAVA_OPTS,"-jar","/app.jar"]