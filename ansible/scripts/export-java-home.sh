#!/bin/bash

DONEFILE=/var/ansible-java-home

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

echo 'JAVA_HOME=/usr/lib/jvm/oracle-jdk-8' | tee --append /etc/environment
echo 'JDK_HOME=/usr/lib/jvm/oracle-jdk-8' | tee --append /etc/environment

# signal a successful provision
touch ${DONEFILE}
