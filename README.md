# Overview
This project is a Vagrant box that is provisioned for sofware development.  It is a Linux-based system and
has many of the tools needed by a developer already installed.  The provisioning mechanism is based on Ansible
and allows for user-specific customizations to be applied.

# Prerequisites

* [Vagrant](https://www.vagrantup.com/) installed and working
* [VirtualBox](https://www.virtualbox.org/) installed and working
* [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads) installed into VirtualBox
* **[Virtualization support](https://en.wikipedia.org/wiki/X86_virtualization) enabled in your BIOS**
* a working internet connection
* Your corporate VPN running (if you want to apply some work-specific plays)

# Building
All the components of the environment live in repositories on the internet so there is nothing to build.
**UPDATE:** some people have experienced issues when rebuilding a box due to flaky networks, online assets
moving to different locations or installation processes changing.  When you need your box, you need your box
and you don't have the time to troubleshoot an installation issue.  To combat this problem, we've decided to
change the build model and bake in much of the software into the base image.  The trade-off we've made to
ensure quick and stable rebuilds is a larger initial download.  All boxes are currently housed in
[HashiCorp's Atlas](https://atlas.hashicorp.com) repository.

# Installation
Use Git to clone this project, go into the project folder and type `vagrant up` and go get a cup of coffee.  The construction time of the box
greatly depends on your internet speeds.

![xubuntu](xubuntu.png)

![xedora](xedora.png)

# Tips and Tricks

## Choice Of Disributions
We now support multiple Linux distributions.  If you run `vagrant status` you should see something like this:

```
vagrant status
Current machine states:

xubuntu                   not created (virtualbox)
xedhat                    not created (virtualbox)
```

`xubuntu` is the default but you can also run `vagrant up xedhat` to run
the Red Hat distribution.  You can run concurrent instances if you have the hardware and the need.

## Upgrading
Sometimes the Vagrant file changes which can cause some subtle issues, such as creating an orphaned virutal machine.
The safest upgrade procedure is the following:

1. `vagrant destroy` to remove the existing box
1. `git pull` to download the new files
1. **`vagrant box outdated`** to see if newer version of the box is available
1. `vagrant box update --box <boxname>` to pull down the current version of the box
1. `vagrant up` to build the new box

## RAM and CPU Settings
If you examine the `vagrantfile` file, you will see that the virtual machine is configured to use 6GB of RAM and
2 CPUs.  Feel free to change these values to match your computer's hardware.

## Low Disk Space
If an environment is used long enough, it is likely to run out of disk space.  The two main culprits are kernal updates
filling up the `/boot` partition and Docker images filling up the `/var/lib/docker` partition.  You have at least 3 options:

* throw away the environment and start fresh
* clean up the old kernels via `sudo apt-get autoremove`
* clean up Docker containers via `docker rm --volumes --force $(docker ps --all --quiet)`
* clean up Docker images, after cleaning up the containers, via `docker rmi --force $(docker images --quiet)`

## Verifying The Setup
Log into the system with a username of `vagrant` and password of `vagrant`.

## Installed Infrastructure
Docker containers running common infrastructure are installed in `/home/vagrant/bin/servers`.  Look at the `docker-compose.yml`
file to see what services are currently available to use.  Run the `start.sh` script to install and run the servers.  You can
also start up a single server, eg `docker-compose up -d mongodb`.

## Docker-based IDEs
We've deprecated the use of Docker-based IDEs.  We've found that projects that produce and consume Docker images can be
challeging when running from within a container.  If Docker in Docker ever becomes mainstream, we'll look into switching back.

## Applying Your Company Specific Customizations
The system will look for an environment variable named `CORPORATE_PLAYS`.  If the shell running Vagrant specifies the variable
such that it points to an Ansible project on GitHub, the plays will be run and the changes applied.  For example
`export CORPORATE_PLAYS=kurron/ansible-pull-transparent.git` will result in
[this playbook](https://github.com/kurron/ansible-pull-transparent.git) getting run.  If the environment variable does
not exist, the custom provisioning step is not run.

## Applying Your Personal Customizations
The system will look for an environment variable named `USER_PLAYS`.  If the shell running Vagrant specifies the variable
such that it points to an Ansible project on GitHub, the plays will be run and the changes applied.  For example
`export USER_PLAYS=kurron/ansible-pull-desktop-tweaks.git` will result in
[this playbook](https://github.com/kurron/ansible-pull-desktop-tweaks) getting run.  If the environment variable does
not exist, the custom provisioning step is not run. **Important: use a copy of the project if you decide to apply customizations.**  
If you reference this project, you will get somebody else's customizations, including Git configuration, which most certainly you do not want.

## Customizations: Linux Example
1. create and/or edit `~/.bash_profile`
1. add the two variables and save the file
1. open a new shell
1. `echo $CORPORATE_PLAYS` to verify the new variable has been properly set
1. `echo $USER_PLAYS` to verify the new variable has been properly set
1. you **may** have to log out and back in again for the variables to take affect

```
export CORPORATE_PLAYS=kurron/ansible-pull-transparent.git
export USER_PLAYS=foo/custom-tweaks.git
```

## Customizations: Windows 10 Example
1. In Search, search for and then select: System (Control Panel)
1. Click the Advanced system settings link.
1. Click Environment Variables.
1. In `User variables for ...` add `CORPORATE_PLAYS` variable, pointing it to your plays on GitHub
1. In `User variables for ...` add `USER_PLAYS` variable, pointing it to your plays on GitHub
1. In Search, search for and then select: Command (Command Prompt)
1. `echo %CORPORATE_PLAYS%` to verify that your new variable has been properly set
1. `echo %USER_PLAYS%` to verify that your new variable has been properly set

## Gather Docker Container Metrics
`sudo csysdig -pc` will fire up the sysdig tool.  Use `F2` to switch to the container view and see how each container is using
system resources.

## Docker-only Box
If you don't need a full desktop but just the Docker engine, try using [vagrant-docker-server](https://github.com/kurron/vagrant-docker-server)

## Sub-Projects
**Update:** we've moved away from using `ansible-pull` and to using [Ansible Roles](http://docs.ansible.com/ansible/playbooks_roles.html), which give us a better
mechansim for reusing provisioning logic.  You can find a
[list of available roles](https://galaxy.ansible.com/kurron/) in my Ansible Galaxy account.  More are sure
to be included over time.

## Installed Software (partial list)

* current [JDK](http://www.oracle.com/technetwork/java/index.html)
* [SDKMAN!](http://sdkman.io/) to manage various JVM tools, including Groovy, Scala, Clojure, Grails, Gradle, Maven, Ant and Leiningen
* [NodeJS](https://nodejs.org/en/) and [npm](https://www.npmjs.com/)
* [Packer](https://packer.io/)
* [Terraform](https://terraform.io/)
* [AWS CLI](https://aws.amazon.com/cli/)
* [Docker](https://www.docker.com/)
* [Docker Compose](https://www.docker.com/products/docker-compose)
* [Docker Machine](https://www.docker.com/products/docker-machine)
* various [JetBrains IDEs](http://www.jetbrains.com/)
* [httpie](https://github.com/jkbrzt/httpie) - a more friendly alternative to cURL and wget

## Different Windowing Systems
*NOTE:* currently a work in incubation.

We have branches that use different window managers that may appeal to you.  Use Git to switch to approriate branch and run `vagrant up` to try it out.

* Xubuntu
* Lubuntu
* Gnome
* Kubuntu
* Mate
* Cinnamon
* Unity

# Troubleshooting

## Vagrant Asks Me Which Network Interface To Bind To
By default, the box is configured to join the local network as a fully accessable machine.
The `desktop.vm.network "public_network"` in the `vagrantfile` is the key to this.  If you have
multiple networks available on your machine, running a VPN for example, Vagrant needs to know which
network you want to put your Vagrant box onto and will wait until you give it guidance.

```
==> desktop: Setting the name of the VM: jvmguy.desktop
==> desktop: Clearing any previously set network interfaces...
==> desktop: Available bridged network interfaces:
1) Intel(R) 82579V Gigabit Network Connection
2) Juniper Networks Virtual Adapter
==> desktop: When choosing an interface, it is usually the one that is
==> desktop: being used to connect to the internet.
    desktop: Which interface should the network bridge to?
```

## Vagrant Box Does Not Come Up
If you find that when you are building a new box that it does not come up, try going into the `Settings->USB` section of your box in the VirtuabBox UI and
disabling the USB controller. If you want USB support, make sure you have installed
[VM VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads).

You should also double check that you have **enabled virtualization support** in your BIOS.

## Partial Failure
Sometimes networks fail or mirror sites go down. If you experience a failure, you can attempt to resume the construction
by issuing `vagrant provision` at the command line.  Vagrant will attempt to start over, but will skip any provisions that
have already taken place.

## Cannot Acquire Repository Lock
**UPDATE:** we've altered some of the installation logic to perform the retry logic described below automatically so
you probably don't have to worry about this scenario any longer.

One of the first steps is to update the APT repositories via `apt-get update` which every once in a while can fail.
What appears to happen in those cases is that the Ubuntu GUI has already acquired the lock and is running the update
on its own.  The solution is to wait a bit and then reset the environment so that provisioning can continue.  This issue
will manifest in "Ansible is not installed" errors.

1. `vagrant ssh`
1. `sudo rm /var/lib/dpkg/lock` to remove the lock file
1. `sudo apt-get update` -- repeat this step until you can successfully acquired the lock and update
1. `sudo rm /var/ansible-install`
1. `exit`
1. `vagrant provision` should resume the provisioning of the box

## My Git settings are all wrong!
You need to specify a custom Git configuration file.  The best way to do that is to create and apply your own customizations.
See the *Applying Your Own Customizations* section above on how to do that.  You can use [kurron/ansible-pull-desktop-tweaks.git](https://github.com/kurron/ansible-pull-desktop-tweaks)
as inspiration. **Do not blindly copy the customizations as they are specific to a particular person.**

# Change History
1. Smaller download, replaced ext4 with xfs, updates to Docker, IntelliJ, PyCharm, WebStorm, Node JS, Atom, Packer and VirtualBox 5.1.10 support
1. VirtualBox 5.1.8 support

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).
