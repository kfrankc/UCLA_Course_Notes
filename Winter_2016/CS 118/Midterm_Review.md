# Midterm Review

Aliasing vs. Proxying  
* aliasing - multiple names for one
* proxying - one name for multiple parties
    - load distribution --> google has too much traffic, they distribute it

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
        + RPC, TCPMUX ability to go to a location and say: translate something for me and send it to a service
        + pro: easy to deploy independently
        + lightweight (efficient)
        + con: replication of effort; difficult to scale
    - out-of-band
        + heirarchical: using structure in name space
* Hierarchical: ordered - specific name structure\
* DNS - distributed
    - starts with .ROOT
    - 

