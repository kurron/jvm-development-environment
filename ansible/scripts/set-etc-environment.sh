#!/bin/bash

# sets the specified environment variable in /etc/environment in an idempotent way

VARIABLE_NAME=$1
VARIABLE_VALUE=$2

DONEFILE=/var/ansible-${VARIABLE_NAME}

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

echo ${VARIABLE_NAME}=${VARIABLE_VALUE} | tee --append /etc/environment

# signal a successful provision
touch ${DONEFILE}
