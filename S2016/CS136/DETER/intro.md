# Getting Started with Deter

### TA: Joshua Joy
`jjoy@cs.ucla.edu`

### DETER Lab
* public FIREWALL
* user ssh into gateway usr to go past the firewall
* ssh **AGAIN** into the node resource
* `terminate` once you are done with the lab
* assignment schedule is up; do at your own pace + finish at your own time

### Useful Tutorial to Set Up a Lab
1. Begin an Experiment
2. Select Class Project
3. Enter name: `username-exercisename`
4. Enterne description
5. Follow instruction for NS File
6. Idle Swap set to 1 h
7. Swap In Immediately means start lab now

### Working on an Exercise
1. Click `myDETERlab`
2. Click name of experiment under `Current Experiments`
3. Click `Swap Experiment`

### SSH In
1. (From your own Terminal): `ssh <username>@users.deterlab.net`
2. (From your users ssh): `ssh <yourNode>.<yourExp>.<yourProj>.isi.deterlab.net`
3. Use `logout` to exit one layer at a time

### Useful Tools for this lab

#### locate
1. `sudo updatedb`
2. `sudo locate *intro* -i`: find all entries with the name intro (case insensitive)


## Unix Information (might be useful later)

### Outline of all Unix directories

#### /bin
* contains user binaries
* contains executables programs that _must_ be available in order to attain minimal functionality for the purpose of _booting_ or repairing a system
* `/usr/bin` progrmas that are not required for booting the system
* `/sbin` system binaries: additional programs used to boot the system + root user accessibility

#### /boot 
* contains everything required for the boot process, except for config files _not_ needed during boot time

#### /dev
* contains special device files for all devices
* these device files communicate with a driver in the kernel --> in turn communicates with a piece of hardware

#### /etc
* used to store system configuration files

#### /home
* usually a user's personal files, directories, and storages are here

#### /lib
* kernel modules and shared library images needed to boot the system and run commands in the root filesystem

#### /usr/local/bin
* a directory for things a user would normally run
* safe from being overwritten when system software updates

#### /opt
* contains all software and add-on packages that are not part of the default installation

#### /proc 
* process information; contains information about system processes

#### /var
* variable files: files that are expected to grow

#### /tmp
* temporary variables created by the user: these files will be deleted when the user reboots

#### /usr
* contains everything needed for second-level programs

#### /media
* removable media such as USB, CD-ROM

#### /srv
* services related data
