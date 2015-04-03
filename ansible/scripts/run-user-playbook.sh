#!/bin/bash


if [ "$1" = "" ]
then
 echo "No user-specific Ansible playbook defined. Nothing to do."
 exit
fi

# the GitHub location of the custom Ansible plays to run eg, kurron/ansible-pull-desktop-tweaks.git
PROJECT=$1

# we have to do this in case we are running under Windows
cp -r /vagrant/ansible /tmp
chmod -x /tmp/ansible/*.ini

#mkdir -p /opt/git
ansible-pull --checkout master --directory /opt/ansible-pull-custom --module-name=git  --only-if-changed --url=https://github.com/${PROJECT} --verbose playbook.yml
