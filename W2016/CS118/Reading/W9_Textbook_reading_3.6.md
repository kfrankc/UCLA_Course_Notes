# W9: Layer Optimization: Congestion Control

## 3.6 Principles of Congestion Control

### 3.6.1 The Causes and Costs of Congestion
* Scenerio 1: Two Senders, a Router with Infinite Buffers
    - simplest congestion scenario: two hosts (A & B) each have a connection that shares a single hop between src and dest. 
    - **per-connection throughput**: number of bytes per second at the receiver as a function of the connection-sending rate
    - large queuing delays are experienced as the packet-arrival rate nears the link capacity
* Scenario 2: Two Senders and a Router with Finite Buffers
    - packets will be dropped when arriving to an already full buffer.
    - assume that each connection is reliable. 
    - **offered load**: rate at which the transport layer sends segments
    - performance depends on how retransmission works
    - cost: uneeded retransmissions by the sender in the face of large delays may cause a router to use link bandwidth to forward unneeded copies of a packet.
* Scenario 3: Four Senders, Routers with Finite Buffers, and Multihop Paths
    - cost of dropping a packet due to congestion - when a packet is dropped along a path, transmission cap that was used at each upstream links to forward that packet to the point at which it is dropped ends up having been wasted.

### 3.6.2 Approaches to Congestion Control
* end-to-end congestion control
    - network layer provides _no explicit support_ to the transport layer for congestion-control purposes.
* network-assisted congestion control
    - routers provide explicit feedback to the sender regarding the congestion state in the network
    - more sophisticated network feedback is also possible.
* **choke packet**: congestion info fed back from network to senders. AKA a packet that says 'im congested'

### 3.6.3 Network-Assisted Congestion-Control Example: ATM ABR Congestion Control
*  ATM ABR: a protocl that takes a network-assisted approach toward congestion control.
*  ATM takes a virtual-circuit (VC) oriented approach towards packet switching. Recall from our discussion in Chapter 1; this means that each switch on the source-to-destination path will maintain state about the source-to-destination VC. This per-VC state allows a switch to track the behavior of individual senders
*  ABR - elastic data transfer service in a manner reminiscent of TCP. When the network is underloaded, ABR service should be able to mtake advantage of the spare available bandwidth.
*  **Resource Management Cells (RM)**: used to covey congestion related information among the hosts and switches. When an RM cell arrives at a destination, it will be turned around and sent back to the sender.
*  REMEMBER: it is a rate bested approach - sender explicity computes a max rate at which it can send and regulate itself accordingly. 
*  3 mechanisms for signaling congestion-related information from the switches to the receiver: 
    -  EFCI bits: explicit forward congestion indication bit. 
        +  1 to signal congestion to the destination host.
        +  RM cell arrives at destination, if most recently received data cell had EFCI bit set to 1, then destination sets CI to 1, and sends back to sender.
    -  CI and NI bits: congestion indication and no increase;
        +  a switch can set the NI bit in a passing RM cell to 1 under mild congestion and set CI bit to 1 under sever congestion conditions.
    -  ER setting: two bit explicit rate field. A congested switch may lower the value contained in the ER field in a passing RM cell.
