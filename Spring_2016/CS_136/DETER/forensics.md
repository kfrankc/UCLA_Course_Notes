# Computer Forensics

## Overview

* investigate disk images of three compromised computers, in order to determine what happened to them.

Things to learn:

1. be familiar with basic computer forensic theory
	* identification methods
	* common types of tools
	* common locations of data
	* data integrity protocols
2. know how to use basic system analysis tools, such as:
	* dd and mount
	* e2undel
	* chkrootkit
	* system logs
	* strings
	* hex editors
	* find and locate
	* grep
3. have analyzed three computer disk images in order to determine:
	* cause of the system's failure
	* identity of the intruder (if one exists)
	* how the problem could have been prevented
	* what needs to be done before returning the system to production
4. written up a 1-2 page analysis report on each disk image detailing the info discovered and any recommendations

## Required Reading

### Positive ID: fingerprints and DNA

#### Username

* concept of the user, account protected by username/password combination, or, in some case, encryption key.
* info on server is logged by user
* sometimes login credentials are stolen, lost, or given away

#### Network Addresses

* computer on network has an address
* most data packets on a network have source and destination addresses encoded into the packet.
* due to decentralized nature of the Internet, we don't know if dest address is the final destination.
* source and dest. address can be forged.
	* DDoS attacks

#### CPU Serial Numbers

* Personal Serial Number (PSN) accessed with a special opcode; Intel Pentium III processors

#### Hardware/Software Artifacts

#### Software Watermarks and GUID

* incorporate unique software serial numbers into files created with that software.
* MS Office, GUIDs into files

#### Encryption Keys

* Public Key Cryptography: double edged sword
	* prereq for secure, confidential communication
	* taking ideas of digital signatures and turning it around in order to positively identify a party that may not wish to be known

#### Magnifying Glasses and Microscopes

* Disk Imaging
	* sector by sector copy of the entire hard disk
	* boot sector, swap, other partition, protected areas
* Editors / Viewers
	* tools to scan live memory
	* process monitors (ps, top)
	* network monitors (netstat)
	* filesystem monitors (Isof)
* System logs and Process accounting
	* /var/log
	* kernel op: /var/log/kern.log
	* system op: /var/log/syslog
* Network Scanning and Monitoring
	* port scanner: nmap
	* monitor connections: iptraf
	* filter packets: tcpdump or Wireshark
* Software Scanners
	* scan the software installed on system with trused tools
	* rootkits
	* chkrootkit
* Data Recovery Software
	* srm
	* shred to destroy files
	* e2undel to undelete

#### Where Data Hides

1. deleted files
2. temporary files
3. hidden files
4. caches
5. spools
6. RAM
7. backups
8. printouts and notes
9. external media
10. swap space
11. memory buffers
12. network storage
13. ISP records
14. steganography

#### Data Integrity: The Evidence Bag

* Cryptographic hashes
	* MD5, SHA-1: functions that produce a unique fixed-length result for any given input. 

### Software Tools

* `loadimage.sh`: load forensics lab images
* `losetup`: mounting a image
* `mount`: 
* `e2undel`: delete files from ext2 filesystem
* `strings`: search for strings in a file
* `chkrootkit`: check for rootkits
* `gpg`: open source cryptography
* `john the ripper`: brute force user passwords
* `shell tools`: less, tail, head, cat, grep
* `find`, `xargs`: build command lines from standard input
* `locate`: a faster way to search
* `hexedit`: edit hexadecimal and ASCII

