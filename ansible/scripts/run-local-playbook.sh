#!/bin/bash

INVENTORY=$1
# we have to do this in case we are running under Windows
cp -r /vagrant/ansible /tmp
chmod -x /tmp/ansible/*.ini

ansible-playbook --verbose --connection=local --limit=${HOSTNAME} --inventory-file=/tmp/ansible/$INVENTORY /tmp/ansible/custom-playbook.yml
