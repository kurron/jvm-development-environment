#!/bin/bash

DONEFILE=/var/ansible-install

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

# I put this in because Carl's install got wedged once because it couldn't acquire the repository lock
sudo apt-get update

sudo apt-get install -y libssl-dev libffi-dev
sudo easy_install pip
sudo pip install ansible

# signal a successful provision
touch ${DONEFILE}
