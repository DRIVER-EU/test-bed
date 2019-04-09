FROM ubuntu:18.04

LABEL maintainer="Cyril Dangerville <cyril.dangerville@projectdriver.eu>"

ENV LANG=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update --quiet=2 &&\
    apt-get install --quiet=2 net-tools git unzip openjdk-8-jdk-headless ant ant-optional psmisc bc patch curl openssl &&\
    apt-get clean --quiet=2 &&\
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* &&\
    update-java-alternatives -s java-1.8.0-openjdk-amd64 &&\
    groupadd --system pki && useradd --no-log-init --system --gid pki --home-dir /opt/pki pki &&\
    mkdir /opt/pki &&\
    chown -R pki:pki /opt/pki

USER pki

WORKDIR /opt/pki

COPY --chown=pki:pki root-ca.p12 root-ca.p12
RUN keytool -exportcert -keystore root-ca.p12 -storepass changeit -alias ca -rfc -file root-ca-crt.pem &&\
    git clone https://github.com/DRIVER-EU/ejbca.git ejbca.git

COPY --chown=pki:pki ejbca-profiles ejbca-profiles
COPY --chown=pki:pki ejbca-setup.sh ejbca.git/bin/extra/custom-ejbca-setup.sh

ENV LAUNCH_JBOSS_IN_BACKGROUND=true

RUN chmod +x ejbca.git/bin/extra/custom-ejbca-setup.sh &&\
    ejbca.git/bin/extra/custom-ejbca-setup.sh &&\
    ejbca/bin/ejbca.sh ca init --verbose --caname Issuing_CA --dn "O=DRIVER_PROJECT,OU=WP923,CN=Issuing_CA" --tokenType soft --tokenPass null --keytype RSA --keyspec 2048 -v 1460 --policy null -s SHA256WithRSA --signedby External -externalcachain /opt/pki/root-ca-crt.pem &&\
    openssl req -inform DER -outform PEM -in ejbca/Issuing_CA_csr.der -out ejbca/Issuing_CA_csr.pem &&\
    keytool -keystore root-ca.p12 -storepass changeit -gencert -v -alias ca -ext BasicConstraints:critical=0 -validity 1460 -keypass changeit -infile ejbca/Issuing_CA_csr.pem -rfc -outfile Issuing_CA_crt.pem &&\
    ejbca/bin/ejbca.sh ca importcacert --verbose --caname Issuing_CA -f /opt/pki/Issuing_CA_crt.pem &&\
    ejbca/bin/ejbca.sh ca importprofiles --verbose -d /opt/pki/ejbca-profiles &&\
    ejbca/bin/ejbca.sh ra addendentity --verbose --username testadmintool --password changeit --dn "CN=testadmintool,O=DRIVER_PROJECT" --email "cyril.dangerville@projectdriver.eu" --caname Issuing_CA --type 1 --token P12 --eeprofile TLS_EE &&\
    rm -rf Download &&\
    rm -rf wildfly/standalone/configuration/standalone_xml_history

EXPOSE 8080/tcp
EXPOSE 8442/tcp
EXPOSE 8443/tcp
EXPOSE 4447/tcp
EXPOSE 9990/tcp

CMD ["wildfly/bin/standalone.sh", "-b", "0.0.0.0"]
