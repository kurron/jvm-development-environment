#Overview
This project is a Vagrant box that is provisioned for sofware development.  It is a Xubuntu-based system and 
has many of the tools needed by a developer already installed.  The provisioning mechanism is based on Ansible 
and allows for user-specific customizations to be applied.

#Prerequisites

* [Vagrant](https://www.vagrantup.com/) installed and working
* [VirtualBox](https://www.virtualbox.org/) installed and working
* a working internet connection
* Transparent Language VPN running (we need to copy some key files around) 

#Building
All the components of the environment live in repositories on the internet so there is nothing to build.

#Installation
Type `vagrant up` and go get a cup of coffee.  The construction of the box greatly depends on your internet speeds.
To start the environment, run `./start.sh`.  That will pull down the Docker image and start them in the background.

#Tips and Tricks

##Verifying The Setup
Log into the system with a username of `vagrant` and password of `vagrant`.

##Installed Infrastructure
Docker containers running common infrastructure are installed in `/home/vagrant/bin/servers`.  Look at the `docker-compose.yml` 
file to see what services are currently available to use.  Run the `start.sh` script to install and run the servers.

##Applying Your Own Customizations
The system will look for an environment variable named `USER_PLAYS`.  If the shell running Vagrant specifies the variable 
such that it points to an Ansible project on GitHub, the plays will be run and the changes applied.  For example 
`USER_PLAYS = kurron/ansible-pull-desktop-tweaks.git` will result in 
[this playbook](https://github.com/kurron/ansible-pull-desktop-tweaks) getting run.  If the environment variable does 
not exist, the custom provisioning step is not run.

##Gather Docker Container Metrics
`sudo csysdig -pc` will fire up the sysdig tool.  Use `F2` to switch to the container view and see how each container is using
system resources.

##Installed Software

* current JDK
* SDKMAN! to manage various JVM tools, including Groovy, Grails, Gradle and Spring Boot
* Clojure's leinengen tool
* NodeJS and npm
* Packer
* Terraform
* AWS CLI
* Ant
* Maven
* a current version Docker
* various JetBrains IDEs

#Troubleshooting

## Partial Failure
Sometimes networks fail or mirror sites go down. If you experience a failure, you can attempt to resume the construction 
by issuing `vagrant provision` at the command line.  Vagrant will attempt to start over, but will skip any provisions that
have already taken place. 

#License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

#List of Changes

