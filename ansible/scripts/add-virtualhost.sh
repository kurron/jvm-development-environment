#!/bin/bash

# creates the specified RabbitMQ virtualhost in an idempotent way

VHOST=$1
RABBIT_HOST=$2
USERNAME=$3
PASSWORD=$4

DONEFILE=/var/ansible-vhost-${VHOST}

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

curl --include --user $USERNAME:$PASSWORD --header "content-type:application/json" -XPUT http://$RABBIT_HOST:15672/api/vhosts/$VHOST
curl --include --user $USERNAME:$PASSWORD --header "content-type:application/json" -XPUT http://$RABBIT_HOST:15672/api/vhosts/$VHOST/$USERNAME --data'{"configure":".*","write":".*","read":".*"}'

# signal a successful provision
touch ${DONEFILE}
