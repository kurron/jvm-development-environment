This project creates a virtualized development environment tailored to JVM developers.  You must have both [VirtualBox](https://www.virtualbox.org/) and [Vagrant](https://www.vagrantup.com/) installed.  To use this environment all you have
 to do is issue the `vagrant up` command.  That will start the creation of the virtual machines.  Once the process is complete, you can log into the desktop
using `vagrant\vagrant` as credentials. 


Initial box creation can take some time so _do not log into the desktop vm until the Vagrant command completes_.  Logging in prior to completion may cause
certain provisions to fail.  On occassion, networks timeout or files get corrupted and there are a few simple techniques you can use to correct errors.

1. retry the process.  Determine the name of the box that failed and attempt to retry build.  For example, if the `desktop` box failed you can
   try issuing the command `vagrant provision desktop`.
2. all downloaded files are stored in the `/root` directory and you might be able to correct a faulty download by removing the file.  Log
   into the box via ssh using the command `vagrant ssh desktop`.  Once you are in, you will have to examine the `/root` and remove the file
   that has problems.  Since the directory is owned by root, you will have to use `sudo` to remove any files.  Once the file is removed,
   exit the shell and try the provision again.
3. if you cannot figure out which file is failing you could nuke the box from orbit and try again -- `vagrant destroy desktop` followed by
   `vagrant up desktop`.

The current version of this project generates a single virtual machine.  It is an Xubuntu desktop running Docker.  Multiple Docker containers are running to provide various services, including RabbitMQ, MongoDB, Nginx and MySQL.  Upon entering the box, type `docker ps` to see the currently running containers.

The provisioning of this box uses multi-pass Ansible steps.  The first pass is based on [a project](https://github.com/kurron/ansible-pull) that provides generalized Ansible plays suitable for a variety of envirionments.  The plays are shared but the inventory is controlled by this project.  Using customized inventory files allows you to pick and choose which plays get applied to which boxes.  As the plays are updated, you get the changes for free.

The second pass is based on a local Playbook and is expected to be project specific.  For example, the project may expect certain databases to exist in MySQL and will provision them.

The last pass is based on a remote Ansible playbook specific to the user running Vagrant.  This is an optional phase that is controlled by an environment variable: `USER_PLAYS`.  If the shell running Vagrant specifies the variable such that it points to an Ansible project on GitHub, the plays will be run and the changes applied.  For example `USER_PLAYS = kurron/ansible-pull-desktop-tweaks.git` will result in [this playbook](https://github.com/kurron/ansible-pull-desktop-tweaks) getting run.  If the environment variable does not exist, the last provisioning step is not run.

Since we are using Docker for services, we also need to use Docker for CLI access.  To that end, I've created numerous aliases to help with that process.  For each service, there should be 2 aliases.  One to run the cli tool and one to provide shell access to the service container itself.  Running the `alias` will show the current list of aliases.
