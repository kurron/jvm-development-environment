#!/bin/bash

DONEFILE=/var/ansible-install

# make sure we are idempotent
if [ -f "${DONEFILE}" ]; then
    exit 0
fi

# I put this in because Carl's install got wedged once because it couldn't acquire the repository lock
#sudo apt-get update
# see if waiting for the apt-get lock makes peo
until sudo apt-get update; do echo "Waiting for apt-get lock"; sleep 5; done

#sudo apt-get install -y libssl-dev libffi-dev
#sudo easy_install pip

# supposedly, this is the newer way to install pip
sudo apt-get install -y python-pip python-dev build-essential libssl-dev libffi-dev
sudo pip install --upgrade pip
sudo pip install --upgrade ansible
#sudo pip install --upgrade boto

# signal a successful provision
touch ${DONEFILE}
