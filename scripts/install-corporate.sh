#!/bin/bash

if [ "$1" = "" ]
then
 echo "No corporate-specific Ansible playbook defined. Nothing to do."
 exit
fi

# the GitHub location of the custom Ansible plays to run eg, https://github.com/kurron/ansible-pull-transparent.git 
PROJECT=$1

ansible-pull --checkout master --directory /opt/ansible-pull-corporate --inventory-file=/tmp/inventory --module-name=git --url=https://github.com/${PROJECT} --verbose playbook.yml

