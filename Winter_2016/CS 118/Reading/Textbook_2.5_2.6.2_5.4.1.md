# Kurose and Ross: Sec 2.5, 2.6.2, 5.4.1

### 2.5: DNS - The Internet's Directory Service
* hostname: cis.poly.edu
    - hosts are actually identified by IP addresses
    - IP address consist of 4 bytes and has a rigid hierarchical structure.
    - ex: `127.7.106.83`
    - scan address from left to right

#### 2.5.1: Services Provided by DNS
* two ways to identify a host: hostname or IP address
* need a directory service that translates hostnames to IP addresses
* Domain Name System (DNS) does exactly what we need
    - distributed database implemented in DNS servers
    - application layer protocol that allows hosts to query the distributed database.
    - UNIX machines running the BIND software
* In order for host HTTP request sent to web server, must obtain IP address
    - same user machine runs the client side of DNS
    - browser extracts hostname from URL
    - DNS client sends a query containing the hostname 
    - DNS client receives a reply, including the IP address
    - browser receives IP address from DNS, initiate a TCP connection to the HTTP server process at port 80 at that IP address
* More DNS services:
    - host aliasing
    - mail server aliasin
    - load distribution

#### 2.5.2: Overview of how DNS works
* Application runnin in user's host need to translate hostname to IP address
    - invoke client side of DNS (`gethostbyname()` is the function called)
    - DNS in the user's host then takes over
        + send query message into the network
    - All DNS query and reply messages are sent within UDP datagrams to port 53
* Simple design for DNS
    - one server that contains all mappings
    - problems with centralized design:
        + single point of failure
        + traffic volume
        + distant centralized database
        + maintenance
* A distributed hierarchical database
    - no single DNS holds all mappings for all hosts in the Internet
    - distributed across DNS servers
    - example: connect to `amazon.com`
        + first contact root server: return IP address for TLD server
            * 13 root DNS servers (A through M)
        + contact TLD server, return IP adress of authoritative server
            * (Top Level Domain) server: com, org, net, edu, gov etc.
        + contact authoritative server, return IP address for hostname amazon.com
            * every org with publicly accessible hosts have this
    - local DNS server - doesn't strictly belong to hierarchy of servers
    - central to DNS architecture
        + each ISP has local DNS srver
    - recursive queries and iterative queries
* DNS Caching
    - in a query chain, when DNS server received a DNS reply, it can cache the mapping in its local memory. 

#### 2.5.3: DNS Records and Messages
* Resource Records (RRs)
    - `(Name, Value, Type, TTL)`
    - TTL is the time to live of the resource record
    - Type:
        + A: Name is a hostname and Value is the IP address
        + NS: name is a domain, value is the hostname of an authoritative DNS srver
        + CNAME: value is canonical hostname for alias hostname Name
        + MX: Value is the canonical name of a mail server that has an alias hostname Name
* DNS Messages
    - two kinds of DNS messages
        + first 12 bytes is the header section
            * has number of fields
            * first field: 16 bit number that identifies the query
            * number of flags in the flag field
                - 1 bit query/reply indicates whether message is a query or reply
                - 1 bit authoritative flag is set in a reply message when DNS server is an authoritative server for queried name
                - 1 bit recursion desired flag is set when a cliet desires taht the DNS server perform recursion
                - 1 bit recursion available field is set if the DNS server supports recursion
                - question section - information about query that is being made
                - answer section - resource records for the name that was originally queried
                - authority section contains records of other authoritative servers
                - additional section contains other helpful records
    - how to send DNS query directly from host:
        + nslookup program can do that
* Inserting Records into the DNS database
    - registrar: commercial entity that verifies the uniqueness of the domain name, enters into databse, and collects a small fee from you for its services

#### 2.6.2: Distributed Hash Tables (DHTs)
* Popular indexing and searching technique

### 5.4 Link Layer Addressing

#### 5.4.1 MAC Addresses
* LAN address or MAC Address: a link layer address within a node's adapter
* 
