# POSIX Permissions & Stateful Firewalls

## Overview
* introduction to filesystems and network access control schemes
* principle of least privilege
* using POSIX filesystem permissions and `iptables` firewalls

Goal of learning:
1. understand POSIX permission structure: SUID and SGID bits
2. understand essence of `sudo` utility and how to configure and use it securely
3. be able to apply `sudo` knowledge to configure permissions in multiple scenarios, such as
 * shared system directories
 * user home directories + private directories
 * privileged system directories
 * unprivileged system directories
 * editing important configuration files
 * retarting system processes
 * potential prvilege escalation problems
4. understand basics of stateful firewalls
5. be able to apply that knowledge to configure a basic firewall in Linux using `iptables`

## Required Reading Notes

### POSIX Permissions
* POSIX - Portable Operating System Interface
 * IEEE standard **IEEE 1003.1**
 * formalize the API for Unix Operating System
* POSIX specifies standards for:
 * kernel APIs
 * commands
 * required utilities
 * user level APIs
* it is expensive to be certified
 * therefore: FreeBSD + Linux are created
* POSIX is a standard that influences software design and OS implementations in:
 * Windows NT, 2000, XP, beyond

#### Unix OS
* devices are files in Unix, file system permissions also mediate control over many aspects of the OS
* in most Unix OS, permission system is as follows:
 * each file has `read`, `write`, `execute` for each of 3 groups of users called "access classes"
 * three classes are `user` (owner), `group`, and `other`.
 * each access class represent one or more users in the following way:
  * users have unique user ID (`/etc/passwd`) - only they can control
  * groups are collections of users.
  	* each group has own group ID (`/etc/group`)
  * membership of `other` class for each file is dependent on the `user` and members of the `group` class
   * represents everyone that is **NOT** the user (owner) of the file and/or a member of the file's `group` class.
* each access class is encoded by `3` bits. 
* each bit grants additioanl permission from the set `read`, `write`, and `execute`.

Example:
```
12345678910
-rw-r--r--

1:    file type: d=directory, l=symbolic link, - means regular file
2-4:  user permissions
5-7:  group permissions
8-10: other permissions

Example:
d 		rwx 	rwx 	rwx
type	user 	group 	other
```

* symbolic links are special kind of file that is a pointer to a disk location
* 3 kinds of additional permissions that are rarely used but are extremely important to understand
 * `setuid` bit: file run as userid of the file's owner opposed to userid executing the file
 * `setgid` bit: process gains effective user of the file's _group_
 * `sticky` bit: tell kernel to keep executable's image in memory so that it would not have to be reloaded from disk.

### Criticisms

* out of data / woefully inexpressive compared to power of other access control systems
* permissions only tested when you _first open the file for reading, writing, executing_
* traditional Unix permissions and auth assigns group membership at login time and _never_ checks again
 * example of _time of check vs. time of use_ problem

### `sudo` and alternatives

* `sudo` is a setuid root application with its own ACL (stored in `/etc/sudoers`) that specifies tasks that users and groups can perform as root.
 * backlash: easy access to root
* other alternatives:
 * SELinux and grsecurity
 * LDAP
 * Novell eDirectory

### Software Tools

#### adduser, chfn, passwd: add users to a system

To create a new user:
```
$ adduser <username>
```

To add a user to a group
```
usermod -a -G <groupname> username
```

To add a admin user
```
sudo adduser --home /admins/<username> <username>
```

`adduser` copy files from `/etc/skel` directory to become the new homedir of the new user in the `/home/` directory.

`chfn` set `finger` information for the user:
```
$ sudo chfn jimbo
Changing finger information for jimbo.
Name []: ...

$ sudo passwd jimbo
```

Once account created, use following methods to login:
1. if logged into system where you created the account, use `ssh newuser@localhost` to reconnect
2. if local, use `su` command `su newuser` to change to that user. 
3. if logged in to `users.deterlab.net`, you can ssh to the node as the new user

#### groupadd: add groups to a system

```
groupadd <newgroup>
```

#### chown, chgrp: change ownership of a file

`chown` stands for 'change ownership' and is unsurprisingly used to change the owner and group of a file
```
$ chown newowner filename

$ chown newowner:newgroup filename

$ chgrp newgroup filename

$ chmod 777
// full permissions, whereas 000 means no permission
// 7 = 4 + 2 + 1, for r, w, x respectively

// Table for usefulness
special   user     group    other
s  g  t   r w x    r w x    r w x
4  2  1   4 2 1    4 2 1    4 2 1
```

More examples:
```
$ chmod u+x somefile.sh
$ chmod ugo+x somefile.sh
$ chmod u+s somefile.sh
$ chmod ugo-rwxsgt somefile.sh
```

## Firewalls

### Stateless Firewalls

* first functional firewall - inspected individual packet headers without regard for established connections, other packets, or their content. 
 * ex. TCP or UDP: reject packets destined for port 23 (telnet) on host 10.10.10.10 from any address other than 10.10.10.11
 * simple packet filters are known as stateless firewall

### Stateful Firewalls

* keep tables of network connections and states in memory in order to determine if a packet is part of:
 * a preexisting network connection
 * start of a new and legitimate connection
 * unwanted or unrelated packet
* advantage: while stateless firewalls allow all packets from acceptable hosts to an open port
 * stateful firewall configured to allow packets to that port **ONLY** if a legitimate TCP connection has already been established.

#### Application Layer Firewall

* "deep packet inspection"
* look **NOT** just at the header of the packet and state of the connection
 * at payload of the packet in context of what the application processing the packet will do
 * total control over the network stream
 * expense in terms of CPU time and software complexity

### Firewall Policy Design

* **default allow** policy: default allows anything _not_ considered a threat. 
 * allow all outbound traffic, BUT only allows 'untrusted' inbound traffic to special services
 * ex. trojan horse opened insided firewall, but makes connection to malicious website outside of firewall
* **default deny** policy: principle of least privilege
 * limits inbound traffic; ONLY allows outbound traffic to carefully chosen targets
 * trojan horse won't work because outbound traffic is also limited
 * expensive to maintain and inconvenient

### Firewall and Network Testing Tools

#### `iptables`: set and clear rules in netfilter

* **`iptables`** is user space tool for administering the `netfilter` function and tables in Linux kernel. 
 * `filter` and `nat` are built in tables of rules
 * built in chains
 * set of loadable modules of matching stateful filters
 * set of stateless criteria
 * set of targets that represent what to do with a matching packet

Sample `iptables` cmd
```
$ iptables -t filter -i ethX -A INPUT -m state --state NEW -p tcp -s 192.168.0.1 --dport 23 -j REJECT

breakdown:
cmd/arg 					translation
iptables					use iptables tool to insert a new rule into netfilter
-t filters 					go in filter table, apply only to:
-i eth0							packets that are inbound on device ethX (use -o ethX to match outbound)
-A INPUT 						packets that have been put into the INPUT chain either by kernel or by prev rule
-m state --state NEW 			represent a new connection
-p tcp 							transmissino control protocol packets
-s 192.168.0.1 					are from host 192.168.0.1
--dport 23	 					are destined for port 23
-j REJECT 						reject any matching packets. 
```

More examples:
```
$ iptables -p tcp --syn --dport 23 -m connlimit --connlimit-above 2 -j REJECT

^ above command allows 2 telnet connections per client host

$ iptables -A INPUT -i 1o -j ACCEPT
$ iptables -A OUTPUT -o 1o -j ACCEPT

^ above commands accept any inbound or outbound traffic on the internal loopback network device
the `-i 1o` and `-o 1o` arguments specify the "input interface" and "output interface" the packet arrives on.

$IPTABLES -t filter -A INPUT -m state --state NEW, RELATED, ESTABLISHED -j ACCEPT
$IPTABLES -t filter -A OUTPUT -m state --state NEW, RELATED, ESTABLISHED -j ACCEPT

These rules accept all INBOUND and OUTBOUND traffic regardless of interface, address, port, or protocol. Basically like no firewall at all
```

### NEW, RELATED, ESTABLISHED

* NEW: no ID badge yet b/c first packet of a new stream of traffic
* RELATED or ESTABLISHED part of something that by definition has already come through the firewall in the past.

#### nmap: network mapping port scanner

* Nmap is a popular port scanner
 * determine kind of services running on a remote or local host
 * perform OS fingerprinting
 * perform tasks in stealth mode

Sample usage:
```
$ sudo nmap yahoo.com # scans yahoo.com 
$ sudo nmap www.somehost.edu -P0 # shows all ports and their services
```

#### ifconfig: configure Linux network devices
* used by users to see network addresses and statistics
* determine which network addresses are running on what interfaces

Sample usage:
```
$ ifconfig
# eth0 64.81.0.256
# eth1 10.10.10.10
# this means that the two interfaces are on different networks
```

#### telnet: cleartext remote shell
* user issues commands over a TCP socket
* server replies with results of those commands and waits for more inputs
* incredibly insecure b/c low level access to system and cleartext nature

Sample usage:
```
$ telnet yahoo.com 80 # perform get on yahoo.com
$ telnet mailserver.net 25 # connected to mailserver.net and get message
```

#### netcat: network swiss army knife
* netcat is Unix entity for creating TCP and UDP sockets
* to create a fake TCP/UDP server with netcat

```
$ sudo nc -l 80 # we need to sudo because 80 is privileged port
```
This will begin listening TCP socket on port 80. From another host, you can either use telnet or nc to connect to the server you just started on the first host. 

```
[server]$ nc -u -l 10000 # listen for UDP traffic on port 10000
[client]$ nc -u server 10000 # connect to server via UDP on port 10000
```






