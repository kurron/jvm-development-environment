#!/bin/bash

if [ "$1" = "" ]
then
 echo "No user-specific Ansible playbook defined. Nothing to do."
 exit
fi

# the GitHub location of the custom Ansible plays to run eg, kurron/ansible-pull-desktop-tweaks.git
PROJECT=$1

ansible-pull --checkout master --directory /opt/ansible-pull-custom --inventory-file=/tmp/inventory --module-name=git  --url=https://github.com/${PROJECT} --verbose playbook.yml

