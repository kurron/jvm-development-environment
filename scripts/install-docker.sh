#!/bin/bash

sudo ansible-pull --checkout trusty-x64-final --directory /opt/ansible-pull-docker --inventory-file=/tmp/inventory  --module-name=git  --url=https://github.com/kurron/ansible-pull-docker.git --verbose playbook.yml
