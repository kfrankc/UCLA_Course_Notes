## Week 5 Tuesday: Chapter 26: Network Security (773-799)

### Data Classes

1. Public Data: available to anyone
2. Development data for existing products: available only internally
3. Development data for future products: available for dev only
4. Corporate data: legal information
5. Customer data: data customers supply 

### User Classes

1. Outsiders: access to some of Drib's data 
2. Developers: access to both classes of dev data
3. Corporation Execs
4. Employees: access to customer data only

### Firewall & Proxy

_def_: firewall is host that mediates access to a network

_def_: filtering firewall performs access control on the basis of attributes of packet headers, such as dest addr, src addr, options

_def_: proxy is intermediate agent or server that acts on behalf of an endpoint without allowing direct conn between the two endpoints

_def_: proxy (or app level) firewall uses proxies to perform access control. A proxy firewall can base access control on the contents of packets and messages, as well as on attributes of the packet headers.

### Outer Firewall Config

* restrict public access to corporate network
* DMZ concept: you need to have certain resrc for ppl not part of your website
* you have a log of machines that are critical for your environment
* machines that will hold the important data that you are working on to build your products and inventory
* those materials have to be carefully protected
* typically: firewall protect all of your valuable resources from the outside
* "I don't want anyone from the outside except ppl i trust"
* if that public webserver is not protected at all; you want an outer firewall that will provide degree of protection

### Inner Firewall Config

* if conn in sys does not originate from special system internal network (admin server), firewall disallow the connection
* drib trusts its system admin, so only trusted users will be allowed unrestricted access to the DMZ servers
* SSH protocols to connect to DMZ servers, all admin traffic is protected using SSH
* protect your most valuable resources

### Summary

* develop network infrastructure from security requirements.
* meeting availability policy requirements led to a discussion of defenses against attackers using SYN flood



