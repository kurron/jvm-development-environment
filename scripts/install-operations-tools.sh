#!/bin/bash

sudo ansible-pull --checkout master --directory /opt/ansible-pull-operations --inventory-file=/opt/ansible-pull-operations/inventory  --module-name=git  --url=https://github.com/kurron/ansible-pull-operations.git --verbose playbook.yml
