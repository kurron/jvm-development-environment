#!/bin/bash

# sets the specified alias in ~/.bashrc_alias in an idempotent way

ALIAS_NAME=$1
ALIAS_COMMAND=$2

DONEFILE=/var/ansible-alias-${ALIAS_NAME}

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

echo alias ${ALIAS_NAME} = '${ALIAS_COMMAND}' | tee --append  /home/vagrant/.bash_aliases 

# signal a successful provision
touch ${DONEFILE}
