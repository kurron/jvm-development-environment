#!/bin/bash

# sets the specified environment variable in /.bashrc in an idempotent way

KEY=$1
TO_APPEND=$2

DONEFILE=/var/ansible-bashrc-${KEY}

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

echo ${TO_APPEND} | tee --append /home/vagrant/.bashrc

# signal a successful provision
touch ${DONEFILE}
