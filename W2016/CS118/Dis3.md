# CS 118: Discussion 3

### UDP: (User Datagram Protocol)
* no connection establishment
* no connection state
* small packet (8 bytes) overhead
* How to calculate checksum:
    - pseudo header + UDP header + data
    - also applicable to TCP
    - why pseudo header?
* Check both src and dest IP address to make sure everything is going to the right place

### Applications that use UDP
* multimedia streaming
* speed is important
* simple query protocols like Domain Name System
    - overhead of connection establishment is overkill
    - easier to have app retransmit if needed

### Principles of Reliable Data Transfer
* How to deal with bit errors?
    - error detection
    - receiver feedback
    - retransmission
* How to deal with duplicate packets due to retransmission?
    - sequence number
* How can the sender detect that ACK or data is lost?