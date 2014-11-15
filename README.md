This project creates a virtualized development environment tailored to JVM developers.  You must have both VirtualBox and Vagrant installed.  To use all you have
 to do is issue the `vagrant up` command.  That will start the creation of the virtual machines.  Once the process is complete, you can log into the desktop
using `vagrant\vagrant` as credentials. 


Initial box creation can take some time so _do not log into the desktop vm until the Vagrant command completes_.  Logging in prior to completion may cause
certain previsions to fail.  On occassion, networks timeout or files get corrupted and there are a few simple techniques you can use to correct errors.

1. retry the process.  Determine the name of the box that failed and attempt to retry build.  For example, if the `mysql` box failed you can
   try issuing the command `vagrant provision mysql`.
2. all downloaded files are stored in the `/root` directory and you might be able to correct a faulty download by removing the file.  Log
   into the box via ssh using the command `vagrant ssh mysql`.  Once you are in, you will have to examine the `/root` and remove the file
   that has problems.  Since the directory is owned by root, you will have to use `sudo` to remove any files.  Once the file is removed,
   exit the shell and try the provision again.
3. if you cannot figure out which file is failing you could nuke the box from orbit and try again -- `vagrant destroy mysql` followed by
   `vagrant up mysql`.

Currently, the following software is installed into the desktop box:

* Docker 
* Oracle JDK 8
* Oracle JDK 7
* GVM 
* Jetbrains IntelliJ IDEA 
* Tomcat 8 
* Tomcat 7 
* logFACES client 
* DbVisualizer database browser 
* Charles proxy 

