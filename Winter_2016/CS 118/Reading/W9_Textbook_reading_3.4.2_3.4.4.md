# W9: Layer Optimization: Handeling Loss

# 3.4 Principles of Reliable Data Transfer

### 3.4.2 Pipelined Reliable Data Transfer Protocols
* a bunch of equations on page 217-218 

### 3.4.3 Go Back N
    - sender is allowed to transmit multiple packets when available without waiting for an ACK; constrained to have no more than some max allowable number N. 
    - sender responds to 3 types of events:
        + invocation from above - when send() is called, sender first checks to see if window is full. If window is not full, a packet is created and sent, and variables are appropriately updated. If the window is full, sender simply returns the data back to the upper layer. 
        + receipt of ACK - **cumulative ack** will be in place, indicating that all packets with a sequence number p to and including n have been correctly received. 
        + timeout event - timer used to recover from lost data or ACK packets; if timeout occurs, sender resends all packets that have been previously sent but that have not yet been ACK'ed. 
    - receiver's actions
        + if packet with seq number n is received correctly and in order
            * receiver sends an ACK for packet n and delivers the data portion of the packet to the upper layer
        + in all other case: receiver discards the packet and resends an ACK for most recently received in order packet. 

### 3.4.4 Selective Repeat
* avoids unnecessary retransmissions by having sender retransmit only those packets that it suspects were received in error. 
* Require the receiver individually ACK correctly received packets. 
* receiver will ACK correctly received ackets whether or not it is in order.
* Out of order packets are buffed until missing parts are received. 
* Sender events:
    - data received from above: when received, sender checks next available seq_number for the packet. If seq number is within the sender's window, data is packetized and sent. 
    - timeout: timers are used to protect against lost packets. Each packet have its own logical timer, since only a single packet will be transmitted on timeout. 
    - ACK received: if received ACK, sender marks the packet as having been received. 
* Receiver events:
    - packet with seq number is correctly received in [base, base+N+1]
    - packet with seq nummber is corrected received [base-N, base-1]
    - otherwise, ignore packet