#!/bin/bash

DONEFILE=/var/ansible-idea-jdk

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

echo 'IDEA_JDK=/usr/lib/jvm/oracle-jdk-8' | tee --append /etc/environment

# signal a successful provision
touch ${DONEFILE}
