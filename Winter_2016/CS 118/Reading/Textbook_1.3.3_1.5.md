# Kurose and Ross: Sec 1.3.3 - 1.5

## Chapter 1: 

#### 1.3.3 ISPs and Internet Backbones
* end systems connect to Internet using local ISP
* tier-1-ISPs: links and routers and connected to other networks
    - special because:
    - links are 622 Mbps or higher
    - routers forward packets at extremely high rates
    - international in coverage
    - also called **Internet Backbone Networks**
* tier-2-ISP: **customer** of tier-1-ISP (**provider**)
* **peer**: when 2 ISPs are directly connected to each other at the same tier
* **Points of Presense (POPs)**: within an ISP network, the points at which ISP connects to other ISPs
* POP is simply a group of one or more routers in ISP's network
* SUMMARY: topology of Internet is complex

### 1.4 Delay, Loss, and Throughput in Packet-Switched Networks
* **throughput**: amount of data per second that can be transferred between end systems

#### 1.4.1 Overview of Delay in Packet-Switched Networks
* packet starts in a host (the source) and passes through a series of routers
* types of delays
    - nodal processing delay
    - queuing delay
    - transmission delay
    - propagation delay
    - in total: toal nodal delay
* Processing Delay
    - time required to examine the packet's header and determine to direct the packet
* Queuing Delay
    - packet waits to be transmitted onto the link
* Transmission Delay
    - L/R, where L = length of packet in bits, and R = transmission rate of hte link from router A to router B
    - amount of time required to push all of the packet's bits into the link
* Propagation Delay
    - time required to propagate from the beinning of the link to router B
* Difference between transmission delay and propagation delay
    - transmission delay: amount of time required to push packet
        + function of the packet's length and transmission rate
        + nothing to do with the distance between two routers
    - propagation delay
        + time it takes a bit to propagate from one router to the next
        + function of the distance between two routers
        + nothin to do with packet length or transmission rate of the link
* total nodal delay:
    - `d_nodal = d_proc + d_queue + d_trans + d_prop`

#### 1.4.2 Queuing Delay and Packet Loss
* let _a_ be average rate at which packets arrive at the queue
* _R_ is the transmission rate
* all packets consist of _L_ bits/s
* Traffic Intensity: _La/R_: important for estimating the extent of the queuing delay
    - if this is > 1, then the average rate at which bits arrive at the queue exceeds the rate at which the bits can be transmitted from the queue.
    - when this is <= 1, nature of arriving traffic impacts the queuing delay
        + first packet no delay; second has delay _l/R_
**Packet Loss**  
* When there's no place to store a packet, a router will drop the packet
    - packet will be lost

#### 1.4.3 End to End Delay
`d_end2end = N*(d_proc + d_trans + d_prop)`  
**Traceroute**
    - simple program that can run any Internet host
**end systems, application, and other delays**
* modulation delay in dial-up modems
* media packetization delay - present in voice over IP applications

#### 1.4.4 Throughput in Computer Networks
* **instantaneous throughput**: rate at which host B is receiving the file
* **average throughput**: _F/T_ bits/sec, where _F_ is total bits to receive, and _T_ is the seconds it takes for host B to receive the bits.
* **bottleneck link**: throughout is `min(R_c, R_s)`
    - therefore, time to transfer: `F/min(R_c, R_s)`
* many examples on page 45-49, so do them