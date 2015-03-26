#!/bin/bash

# we have to do this in case we are running under Windows
cp -r /vagrant/ansible /tmp
chmod -x /tmp/ansible/inventory.ini


mkdir -p /opt/git
# we have to checkout the repo by hand just to deal with Windows permissions!
#git clone https://github.com/kurron/ansible-pull.git /opt/ansible-pull

ansible-pull --checkout master --directory /opt/ansible-pull --inventory-file=/opt/ansible-pull/inventory.ini  --module-name=git  --only-if-changed --url=https://github.com/kurron/ansible-pull.git --verbose playbook.yml