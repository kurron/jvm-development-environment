#!/bin/bash

sudo ansible-pull --checkout master --directory /opt/ansible-pull-docker --inventory-file=/tmp/inventory  --module-name=git  --url=https://github.com/kurron/ansible-pull-docker.git --verbose playbook.yml
