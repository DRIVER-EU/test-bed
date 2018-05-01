#!/bin/sh
# preinst script for Apache Kafka broker with AuthzForce extensions
#

set -e

VERSION=0.2.0
wget --verbose --no-clobber https://github.com/DRIVER-EU/kafka-combined-acl-xacml-authorizer/releases/download/release-${VERSION}/authzforce-ce-kafka-extensions-${VERSION}-bin.tar.gz && tar xvzf authzforce-ce-kafka-extensions-${VERSION}-bin.tar.gz && ln -s authzforce-ce-kafka-extensions-${VERSION} authzforce-ce-kafka-extensions
