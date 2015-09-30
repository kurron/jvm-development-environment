#!/bin/bash

sudo ansible-pull --checkout master --directory /opt/ansible-pull-development --inventory-file=/opt/ansible-pull-development/inventory  --module-name=git  --url=https://github.com/kurron/ansible-pull-development.git --verbose playbook.yml
