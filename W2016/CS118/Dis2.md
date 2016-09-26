# CS 118: Discussion 1

### Project 1
* Individual project
* 10 % of actual grading  

### Project 2
* Group project: 2 members form a group
* 20 % of total grading
* extra credits if additional features are implemented
* demo will be scheduled for grading  

### More details about project 1
**Goal**: concurrent web server using BSD sockets
* develop a web server using C/C++  

**Lab Working Environment**  
* Use Linux OS to finish the project
* NOT recommended to use Windows  

**Instructions**  
* Read Chapter 2 of textbook carefully. Understand HTTP protocols
* program in C/C++ ONLY. 
* Pick port numbers that are NOT from 0-1024
* Project has 2 parts:
 * **part A**: impelement a web server that dumps request messages to the console.
  * start a brower, connect your server, record the request message
  * find out what the fields in the message mean
   * look up RFC 1945
 * **part B**: add one more function to the 'web server'
  * web server parses the HTTP request from browser, creates HTTP response message
  * send response to client
* Pay attention to following issues:
 * if browser and server are on same machine, use localhost or 127.0.0.1
 * make sure content-type function recognize html files FOR NOW
* After completing A and B: test server
 * put html file in directory of server
 * connect to your server from browser with URL: `http://<machine  name>:<port number>/<html file name>`
 * Sanity check
  * for part A, see the HTTP request format in the console of server machine
  * for part B, browser should be able ot show the content of the requested html file

**Materials to turn in**:  
* source code files (webserver.c)
* report of your project (pdf or word) should not exceed 6 pages
 * high level description of server design
 * what difficulties did you face?
 * how to compile and run your code (write a manual)
 * include some outputs of your server
* The submission files
 * put in folder called "project1204256656"
 * include:
  * web server code
  * report
  * Makefile
  * README - contain student name and UID

**Sample Code**  
* run `./server 7890`
* run `./client localhost 7890`  

### Socket Programming Functions

**TCP Socket**  
* create a service
* establish a TCP connection
* send and receive data  

**TCP Client**  
 * `socket()` 
 * `connect()`
 * `write()`
 * `read()`
 * `close()`

**TCP Server**  
* run this first: `socket()`
 * creates a socket in the server, which called `bind()`
 * after binding, calls `listen()`
 * `accept()` blocked until connection from client
 * `read()` data request
 * `write()`
 * `read()`
 * `close()`  

**Functions**  
* socket
```
int socket(int domain, int type, int protocol);
// create a socket
// return the socket descriptor or -1 (failure)
// domain: protocol family: 
//		PF_INET (IPv4), PF_INET6 (IPv6), PF_UNIX or PF_LOCAL (unix), PF_ROUTE (routing)
// type: communication style
// 		SOCKET_STREAM for TCP (PF_INET)
// 		SOCKET_DGRAM for UDP (PF_INET)
// protocol: typically set to 0; protocol within family
```  
* bind
```
int bind(int sockefd, struct sockaddr* myaddr, int addrlen);
// bind a socket to local IP address and port number
// return 0 on success, -1 on failure
// sockfd: socket file descriptor returned by socket()
// myaddr: include IP address and port number
// NOT: sockaddr and sockaddr_in are of same size, use sockaddr_in and convert it to socketaddr
// addrlen (sizeof(struct sockaddr* myaddr))
```  
* port numbers  
```
1-512 
513-1023
1024-49151	 
49152-65535: private/ephemeral ports
```  
* listen
```
int listen(int socketfd, int backlog)
// put socket in passive state
// return 0 on success, -1 for failure
// sockfd: socket file descriptor returned by socket()
//backlog: max. number of connections this program can server simultaneously
```  
* accept  
```
int accept (int sockfd, struct sockaddr* client_addr, int& addrlen);
// accept a new connection
// return client's socket file descriptor or -1
// sockfd: socket file descriptor for server 
// client_addr: IP address and port number of client
// addrlen: length of address structure = pointer to int set of sizeof(struct sockaddr_in)
// NOTE: client_addr and addrlen are result arguments (get them after calling function)
More about accept:
// makes a new socket from listening socket
// if there are no incoming connections to accept:
// non-blocking mode: accept9) returns -1
// blocking mode: accept operation was added to wait queue
```  
* write
```
int write(int sockfd, char* buf, size_t nbytes)
// write data to TCP
// return number of sent bytes or -1
// nbytes number of bytes wanna send
```  
* read
```
int read(int sockfd, char* buf, size_t nbytes);
``` 
* close()
* byte ordering
```
Little Endian: least sig byte of words stored in lowest address
Big Endian: mot sig byte of words stored in lowest address
Network Byte Order: Big Endian
int m, n;
short in t s, t
m = ntohl (n) net to host long (32 bit) translation
s = ntohs (t) net to host short (16 bit) translation
n = htonl (m) host to net long (32 bit) translation
t = htons (s) host to net short (16 bit) translation
```  
* address access
```
int_addr_t inet 
```
**Serve Multiple TCP Connection Simultaneously**  
* blocking mode by default
* unless a new connection arrive, accept() will not return
* listen() allows TCP connection
* 3 approaches
 * fork() - expensive
 * POSIX - hard to maintain
 * select()  

**What is select()**  
```
int select (int numfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds, struct timeval *timeout);
// numfds: highest file descriptor + 1
// readfds, writefds, exceptfds: set of sockets
// timeout: timer for select to eit without any changes
// return when some sockets are ready or timeout
// return value: the number of sockets that are ready
```  
**What is fd_set?**  
* a set of sockets that will be monitored by select()
* macros:
```
FD_SET
FD_CLR
FD_ISSET
FD_ZERO
```  

**How to use select**  
```
assume server created socket named sock, which bounds with server's IP address and port number
fd_set active_fd_set;
FD_ZERO(&active_fd_set)
FD_SET(sock, &active_fd_set, 0);
while(1) {
	if (select (sock + 1, &active_fd_set, NULL, NULL, NULL) < 0)
		exit(-1);
	if (FD_ISSET(sock, &active_fd_set)) {
		recv(sock, buffer, sizeof buffer, 0)
	}
}
```  
**HTTP**  
* HTTP: stateless protocol on top of TCP
* HTTP based on pull model
* persistent HTTP vs. Non-persistent HTTP
* method: GET, HEAD, POST, PUT, DELETE, Conditional GET