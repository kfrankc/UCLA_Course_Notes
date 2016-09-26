# CS 118: Discussion 1

### Email procedure
prepend [CS 118] in the subject line

### Course Project 
Two projects, web server, reliable data transfer
* use C, C++ only  
 
**Test Environment**  
* preconfigured VM 
* password CS 118
* VirtualBox is needed  
* policy for late submissions: TBA

1. **Web server** 
 * web browser 
 * web server
 * send test file
 * file should be shown in the browser
 * 2 - 3 weeks  

2. **Reliable Data Transfer** (group project)
 * TCP/IP
 * implement reliable data transfer protocols
 * selective repeat on UDP
 * congestion control
 * require a **demonstration**

### Three questions to answer
* What is the model for network programming?
 * **client-server model**
  * **client**: request data
  * **server/daemon**: response data
   * not disjoint
   * client can be server of another client
   * server can be client of another sever
  * server's service model
   * concurrent: server processes multiple clients' request at the same time
   * sequential: server processes clients' request one by one
   * hybrid: server maintains multiple connections, but responses sequentially  
* Where are we programming?
 * Clients and servers are at the **Application layer**
 * **Transport layer** is responsible for providing communication services for application layers.
 * [TCP](https://en.wikipedia.org/wiki/Transmission_Control_Protocol) / [UDP](https://en.wikipedia.org/wiki/User_Datagram_Protocol) are basic transportation protocols
 * TCP is more reliable, and UDP is not as reliable
 * for second project, need to implement a reliable protocol on the UDP

### TCP: Transmission Control Protocol

* a **connection** would be set up between client and server
* **reliable** data transfer
 * guarantee deliveries of all data
 * no duplicate
* **ordered** data transfer
 * if A sends data M1 followed by M2 to B, B will also receive M1 before M2.
* Data transmission, full-duplex **byte stream** (data goes both ways)
 * NOTE: TCP is oblivious to application data, so it is application's role to properly reassemble data
* regulated data flow: flow control, and congestion control

### UDP: User Datagram Protocol

* Basic data transmission service
 * unit of data transfer: datagram (in variable length)
* No reliability guarantee
* no ordered delivery guarantee

### Last question: Which API to use?

1. [Socket Programming](http://www.linuxhowtos.org/C_C++/socket.htm)
 * network socket is endpoint of an inter-process communication flow across a computer network
 * in simple words, socket is the API between applications and transport/network service

2. TCP Socket:
 * create service
 * establish TCP connection
 * send and receive data
 * close a TCP connection

### TODO: check the code posted on CCLE, and use the code for the project, as well as get the [VM](http://metro.cs.ucla.edu/cs118/) for the project (CS118.rar)