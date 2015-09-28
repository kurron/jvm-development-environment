#!/bin/bash

DONEFILE=/var/ansible-install

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

sudo apt-get -y update
sudo apt-get install -y python-yaml python-jinja2 git
sudo git clone http://github.com/ansible/ansible.git --recursive /usr/lib/ansible

sudo sed  --in-place "s/PATH=/#PATH=/" /etc/environment
sudo echo 'PATH="/usr/lib/ansible/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games"' >> /etc/environment
sudo echo 'ANSIBLE_LIBRARY=/usr/lib/ansible/library' >> /etc/environment
sudo echo 'PYTHONPATH=/usr/lib/ansible/lib:$PYTHON_PATH' >> /etc/environment

# signal a successful provision
touch ${DONEFILE}
