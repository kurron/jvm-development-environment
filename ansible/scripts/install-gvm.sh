#!/bin/bash

DONEFILE=/var/ansible-gvm

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

curl --silent get.gvmtool.net | bash

# signal a successful provision
sudo touch ${DONEFILE}