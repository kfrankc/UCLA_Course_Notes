# Kurose and Ross: Sec 4.1 - 4.3

## Chapter 4: The Network Layer

### Review
* transport layer: provide various forms of process-to-process communication
* transport layer does not have knowledge about how network layer actually implements service
* **forwarding**: transfer of packet from incoming link to outgoing link
    - router must move packet to appropriate output link when packet arrives at router's input link
* **routing**: all of network's routers, collective interactions determine the path that packet takes
    - routing algorithms: calculate the route taken by packets as they flow from sender to receiver. 

### 4.1 Introduction
Example: network hosts H1 and H2, and several routers
* H1 is sending info to H2
* network layer in H1 take segments from transport layer in H1
    - encapsulates each segment into datagram
    - send datagram to nearby router R1
* At receiving host: H2
    - network layer receives datagram from router R2
    - extracts the segment, delivers segment to transport layer in H2. 

#### 4.1.1 Forwarding and Routing
* every router has a **forwarding table**.
    - result from forwarding table indicates to which of the router's outoing link interfaces the packet is to be forwarded.
* Configurations of forwarding tables
    - routing alg. determines values that are inserted into the router's forwarding tables
        + routing alg could be centralized (with alg. executing on central site).
        + it could also be decentralized (with a piece of routing alg. running in each router)
* Case: all forwarding tables configured by human network operators.
    - no routing protocols required!
    - but, this has high error due to human
    - great that we have both forwarding and routing function
* **packet switch**: general packet switching device that transfers a packet from input link to output link
    - **link-layer switches**: base forwarding decision on value in the link layer field
    - **routers**: base forwarding decision on value in the network layer field
* **connection setup**: the third important network layer function
    - TCP: recall 3 way handshake

#### 4.1.2 Network Service Models
definition: defines characteristics of end-to-end transport of packets between sending and reeiving end systems.  
**Examples of some characteristics:**  
* guaranteed delivery - packets eventually arrive at destination
* guaranteed delivery with bounded delay - delivery within specified delay bound
* _for a flow of packets_:
    - in-order packet delivery
    - guaranteed minimal bandwidth
        + emulates behavior of transmission link of specified bit rate between sending and host
    - guaranteed maximum jitter
        + guarantees amount of time between transmission of 2 successive packets at sender is equal to the amount of time between receipt at destination
    - security services
        + encrypt payloads using secret session key
* **best-effort service**
    - a network that delivered no packets to the destination
* ATM service models:
    - constant bit rate (CBR) ATM network service
        + provide flow of packets with virtual pipe
        + flow of ATM cells carried so that the fraction of cells lost or late are guaranteed to be less than specified values
    - available bit rate (ABR) ATM network service
        + slightly better than best effort service.
        + cells cannot be reordered (but can be lost)

### 4.2 Virtual Circuit and Datagram Networks
Differences between network layer connection vs. transport layer connection
* network layer
    - host to host
    - from network to transport
    - provides either host to host connection (Virtual Circuit Network) or host to host connectionless (datagram network), but not both
    - implemented in router in network core as well as end system
* transport layer
    - process to process 
    - from transport to application
    - implement connection service at edge of network in end system

#### 4.2.1 Virtual Circuit Network
basically network layer connections.  
Consist of:
1. path between source and dest. host
2. VC numbers, one for each link along the path
3. entries in the forwarding table in each router along the path  

* A packet belonging to the virtual circuit will carry VC number in its header
* The new VC number is obtained from the forwarding table
* When new VC is established across a router, an entry is added to the forwarding table
    - when VC terminates, the appropriate entries in each table along its path are removed
* Why packet doesn't keep same VC number on each of hte links along its route
    - replacing the number from link to link reduce length of VC field 
    - VC setup is considerably simplified by permitting different VC number at each link along the path of VC
* **connection state information**: a new connection entry must be added to the router's forwarding table
* 3 phases in a virtual circuit:
    - VC setup: contacts the network layer, specifies the receiver's address, and waits for the network to set up the VC. network layer determines the path between sender and receiver
    - data transfer
    - VC teardown
* Transport Layer Connection Setup
    - two end systems determine the parameters
    - **signaling messages**: initiate or terminate a VC
    - **signaling protocols**: protocols needed to do the above

#### 4.2.2 Datagram Networks
* each time end system want to send packet, stamps the packet with the address of the destination end system, pop the packet into the network
    - packet passes through series of routers
        + each router use packet's dest. addr. to forward packet
        + use forwarding table: map destination address to link interface
* **prefix**: match with entries in the table
* **longest prefix matching rule**: find longest matching entry in the table and forwards the packet to the link interface associated with the longest prefix match.

#### 4.2.3 Origins of VC and Datagram Networks
* Telephone Networks: VC network more complex than data network
* Internet as datagram network: connect more computers together
    - minimal service guarantees
    - email web or network-layer-centric service such as DNS

### 4.3 What's Inside a Router?
**forwarding function**: actual transfer of packets from a router incoming links to the outgoing links  
4 components of the router
* Input ports: performs physical layer function
    - data link layer function
    - lookup and forwarding function
    - multiple ports are gathered together on a single line card
* switching fabric: connects router's input to output
* output ports: stores the packet that have been forwarded to it through switching fabric; 
* routing processor: executes the routing protocols, maintains the routing information and forwarding tables, and performs network management functions

#### 4.3.1 Input Ports
* input port: forward packet to centralized routing processor
    - perform forwarding table lookup  and forward the packet to the appropriate output port.
    - table lookup given existence of forwarding port
        + search for longest prefix
* Complicating factor:
    - backbone routers must operate at high speeds
    - line speed: lookup less than time needed to receive a packet at the input port
    - reasonable technique: tree data structure
        + start at root node
        + if first address is 0, then left subtree contain the forwarding table entry
        + otherwise, it will be in the right subtree
        + Lookup is in N steps: N is number of bits in the address
* **Content Addressable Memories (CAMs)**
    - allow 32 bit IP address to be presented to the CAM, which returns content of forwarding table entry for the address in _constant time_. 

#### 4.3.2 Switching Fabric
heart of the router - where packets are actually switched (forwarded) from an input port to an output port.  
Ways to switch:
* switching via memory: switch between input and output ports under direct control of the CPU
* switching via a bus: input ports transfer packets directly to output ports over a shared bus
    - switching badnwidth limited to bus speed 
* switching via interconnection network: 
    - crossbar switch: interconnection network consisting of 2n buses that connect n input ports to n output ports

#### 4.3.3 Output Ports
* takes the packet that have been stored in the output port memory and transmits them over outgoing link

#### 4.3.4 Where does queuing occur?
* **packet loss**: when queues grow large, router's buffer space will be exhausted
* **switching fabric speed**: rate at which the switchin fabric can move packets from input ports to output ports. 
    - if speed is at least n times as fast as input line speed
        + no queuing can occur at the input ports
* Output port queuing:
    - **packet scheduler**: choose one packet among those queued for transmission. 
    - FCFS scheduling (FCFS)
    - Weighted Fair Queuing (WFQ) scheduling
* CAUTION: if not enough memory to buffer incoming packet
    - drop-tall
    - remove one or more queued packets
    - active queue management (AQM) algorithms:
    - random early detection (RED) a type 
* if switch is not fast enough - packet queueing can also occur at input ports
* Consider crossbar switchin:
    - link speeds are identical
    - one packet can be transferred from any one input port
    - packets are moved from given input queue to their desired output queue
* **Head of the line Blockin (HOL Blocking)**: queued packet in an input queue must wait for transfer through the fabric even though its ouput port is free because it is blocked by another packet at the head of line.
