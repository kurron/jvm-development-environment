#!/bin/bash

# we have to do this in case we are running under Windows
cp -r /vagrant/ansible /tmp
chmod -x /tmp/ansible/inventory.ini

ansible-playbook --verbose --connection=local --limit=${HOSTNAME} --inventory-file=/tmp/ansible/inventory.ini /tmp/ansible/playbook.yml
