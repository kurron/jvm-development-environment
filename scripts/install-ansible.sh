#!/bin/bash

DONEFILE=/var/ansible-install

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

sudo easy_install pip
sudo pip install ansible

# signal a successful provision
touch ${DONEFILE}
