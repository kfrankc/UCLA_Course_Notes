### 1.3 The Network Core

#### 1.3.1 Packet Switching
* packet switches: channels where packet travels through
 * _L/R_: time to transmit packet
* Store and Forward Transmission
 * packet switch must receive the entire packet before it can begin to transmit the first bit of the packet onto outbound link
 * end-to-end delay: `d_end2end = N*L/R`
* Queuing delay and packet loss
 * wait in output buffer because link is busy with transmission of another packet
 * packet loss: arriving packet find buffer to be full
* Forwarding Tables
 * each router has one; maps destination address to router's outbound links
 * analogous to car driver who do not use maps but ask for directions
 * routing protocols: 
  * used to set forwarding tables 
  * ex. determine the shortest path from each router to each destination

#### 1.3.2 Circuit Switching
Overview
* resource needed along a path are reserved for the duration of communication session between end systems.
 * packet switch: resources **not** reserved
 * analogy: circuit switch is when restaurants need reservation
 * packet switch is when they don't but may have to wait
 * traditional telephone - circuit switch
     - end to end connection
* Multiplexing in Circuit Switched Networks
    - FDM: freqyency spectrum of a link is divided up among the connections established across the link
        + link dedicates a freq. band to each connection
        + width of the band is called **bandwidth**
        + relaying; no overhead, more fair
            * split it up like cars on the highway
            * parallel is better here
    - TDM: time is divided into frames of fixed duration
        + when connection established, network dedicates one time slot in every frame to this connection
        + guaranteed high quality of service
            * send one signal at a time; isolated
* Packet Switching vs. Circuit Switching
    - packet switching not suitable for real time services
        + end to end delays are unpredictable
    - Pro for packet switching:
        + better sharing of transmission capacity than circuit switching
        + simpler + more efficient, and less costly to implement than circuit switching
            * FDM
            * packet switching is more efficient: 
    - Circuit Switching preallocates use of transmission link regardless of demand. 
        + TDM
    - Packet switching - allocates link use _on demand_
        + tel. lines use packet switching for expensive overseas call

#### 1.3.3 Network of Networks
ISP (Internet Service Provider)
* provide service for accessing or participating on the internet
* Network of Networks: Interconnect the access ISPs so that all end systems can send packets to each other
    - access ISP: customer
    - global transit ISP: provider
    - regional ISP: access ISP in region connect
    - tier-1 ISP: no presence in every city in the world
        + there are a dozen tier-1 ISPs
* Network Structure 5: Internet of 2012. 
    - add content provider networks
    - Google: 30 - 50 data centers distributed around the world
    - All interconnected in Google's private TCP/IP network 
    - connect directly to lower ISPs where possible