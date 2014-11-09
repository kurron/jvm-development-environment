#!/bin/bash

if [ "$1" = "" ]
then
 echo "Usage: $0 <username> <e-mail>"
 exit
fi
if [ "$2" = "" ]
then
 echo "Usage: $0 <username> <e-mail>"
 exit
fi
NAME=$1
EMAIL=$2

git config --global user.name "${NAME}"
git config --global user.email ${EMAIL} 
git config --global color.ui true
git config --global core.autocrlf input
git config --global core.editor vi
git config --global push.default simple
