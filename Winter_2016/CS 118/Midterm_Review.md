# Midterm Review

Aliasing vs. Proxying  
* aliasing - multiple names for one
    - support internetworking
        + name in upper common layer
        + name in egress layer (the one you are leaving)
        + name in the ingress layer (the one you are entering)
* proxying - one name for multiple parties
    - load distribution --> google has too much traffic, they distribute it
        + google.com --> many IP addresses
        + localization --> nearby IP addresses
        + backup time servers
* Resolution Mapping
    - address resolution: name translated to address
    - either direction

Packet Switching vs. Circuit Switching
* circuit switching - DOS; fast
* packet switching - interception; reassemble

TCP is redundant? When every link is reliable (inorder and lossless)
* TCP gets everything in order and on time
* if it is already in a perfect channel
* TCP guarantees that you get data (reliable)
    - speed for TCP is something slow
* IP figure out where you need to go to get from one packet to the next
*   IPv4 - 4 bytes
*   IPv6 - 6 bytes

TDM - Time Division Multiplexing  
FDM - Frequency Division Multiplexing 
* total bandwidth available in a communication medium is divided into a series of non-overlapping frequency sub-bands 
* divide into time frames
* divide into freq. frames

#### OSI (Open System Interconnection) Model
Analogy: LETTERS
ATNLP
Application 
* complete package - everything sent together
* high level API
* HTTP, SSH
* data unit: data
* conspire against someone
* remote file acess, directory service
Transport  
* TCP, UDP
* data unit: segment
* 'it get there' ex. 
* transmission of segments of data
Network  
* data unit: packets
* send and receive addresses
* routing, traffic control, addressing
Link  
* data unit: frame
* written letter (whole message)
* bridges the hardware
Physical  
* decide voltage level 
* what means 1 and 0
* data unit: bit
* paper + pen

Code Division Multiple Access
* channel access method 

Localization
* nearby IP address
* technique used by proxying 
* quality of service better at shorter distance

Resolution
* translates a name in one context into a name in a different context
* fixed 
    - link broadcast; specific groups
    - pro: always works
    - con: use only for a very small set of names
* local 
    - filename internal to machine
    - cheap to solve easy to implement
    - con: hard to manage, doesn't scale, difficult to keep consistent
* central
    - single server at known address
    - server can be implemented various ways
    - pro: easy to coordinate
    - con: doesn't scale eventually
* distributed
    - in-band 
        + manages locally through the network itself, using telnet
        + RPC, TCPMUX ability to go to a location and say: translate something for me and send it to a service
        + pro: easy to deploy independently
        + lightweight (efficient)
        + con: replication of effort; difficult to scale
    - out-of-band
        + if there is problem with device such as server or router, need alternate path to reach the network nodes even when the network is down. Management using independent dedicated channels is called OBM.
        + heirarchical: using structure in name space
* Hierarchical: ordered - specific name structure\
* DNS - distributed
    - Iterative
        + at each step: querier asks DNS servers in turn
    - Recursive: querier asks the root server
        + easier for user; faster, more efficient
        + each recursive call adds another layer
    - pros: local control over subsets of the name space
    - con: start at root creates vulnerability
    - search approaches
* ARP
    - arp poisoning when users lie about your own address
    - lost and found
    - translates network address to physical address
* Broadcast
    - pro: easy to configure
    - con: doesn't scale
* Distributed Hash Table (DHT)
    - structured search using DNShandshake
    - DNS Domain Name System
    - Cache: locality of reference
        + timeout: how long to keep a copy
        + what to do when copy expires

TCP vs. UDP
* TCP: always expect to get your message
    - World Wide Web
* UDP: faster, more efficient, but unreliable
    - video streaming - faster
* 3 Way Handshake
    - SYN: client send SYN to server
    - SYN-ACK: server sends back to client
    - ACK: client sends back to confirm

Networking vs. Communication
* comm: method of exchanging info between a fixed set; directly connected parties; a single protocol
* networking: varying, indirectly connected, don't share a single set of rules; many protocols

Complication of Simple Communication/ States
1. Imperfect Channel
2. Sharing complex states
 * leap of faith: assume seq. of blocks: each block has a checksum, if each block is correct; checksum can be the same, but still be corrupted
 * first, three way handshake
 * checksum and seq
 * finish 

In a protocol
* states
* symbols
* transition tables
* events

Shannon Channel
* same protocol
* one direction
* predetermined sender and receiver
* channel is literally linked to the nodes

Socket vs. Port
* socket is the channel: door between you and the transportation layer
    - port number, IP address; interface to communicate with a port
* port is the abstraction of the socket
    - part of the endpoint; you can have different ports for different tasks

Broadcast: send to everyone  
Multicast: send the limited people  

Coordination:  
* A-priori - pre-assigned
* central - manager (master and slave)
* explicit - very efficient
    - potentially very efficient
        + polling everyone
        + atomicity - if it fails it fails for everyone
    - probably central
* hierarchical coordination
    - relieves load on single manager