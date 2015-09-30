#!/bin/bash

sudo ansible-pull --checkout master --directory /opt/ansible-pull-transparent --inventory-file=/tmp/inventory  --module-name=git  --url=https://github.com/kurron/ansible-pull-transparent.git --verbose playbook.yml
