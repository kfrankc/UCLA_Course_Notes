# CS 136: Man In THe Middle Attack

## Concepts

* network sniffing
* insertion attacks
* replay attacks
* Man in the Middle Attacks

## Reading

### Sniffing Ethernet

* Ethernet packets are addressed by a MAC (Media Access Control) address
* Shared Medium - ethernet hub is a physical layer that broadcasts every inbound packet out on everyt port but the one that received the packet. This means that logically, all computers connected via a hub are sharing a single network segment. 
* switched networks - switch keeps track of which MAC addresses are present on each of its ports. Security researchers have developed several attacks against switched networks.

### ARP Spoofing

* redirect traffic that can allow aribitrary interface on an otherwise unsecured switched network to receive traffic.
* Address Resolution Protocol: resolve network layer address
* relies on decentralized, unauthenticated, completely trusting nature of ARP
* ARP Spoofing slow down network traffic because of the additional hops and processing involved.

### Eavesdropping

* intentionally listening to a private conversation
* obvious when data is paassed in plain text
* tools like tcpdrump and wireshark are very powerful sniffing programs

### replay attacks

* capture packets sent on a wire between two hosts with the intent to reply the payloads
* direct packet reply attack 
* complicated payload reply attack

### MITM vs Encryption

* 