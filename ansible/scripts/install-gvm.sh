#!/bin/bash

DONEFILE=/var/ansible-gvm

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

curl -s get.gvmtool.net | bash

# signal a successful provision
touch ${DONEFILE}