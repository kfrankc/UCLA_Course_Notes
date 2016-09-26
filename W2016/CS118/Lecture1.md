# CS 118: Computer Network Fundamentals

### Peter Reiher
Email: reiher@cs.ucla.edu  
OH: Tuesday, Thursday, 2-3 PM, 3532F Boelter Hall

### TA: Seungbae Kim 
Email: ksb2043@gmail.com

### Textbooks
Shannon/Weaver "The Mathematical Theory of Communication"  
Corose/Ross "Computer Networks: A Top Down Approach"

### Grading
2 projects - 30 %
1 Midterm  - 30 %
1 Final    - 40 %

### Computer Networks: Exchange of Information
**Course Outline**  
1. Bits
2. Communication
3. Networking  

**Communication** - exchange info. between:  
1. fixed set
2. directly connected parties
3. using a shared, single set of pre-agreed rules (protocol)  

**What is networking?**  
* communication between varying set of indirectly connected parties  

**International Standards Organization (ISO)**  
* Open system interconnect (OSI)
* 7 layers
* not very applicable  

**Internet**  
* 4 layers 
* app --> transport --> internet --> link  

**More fundamental ideas**  
1. Abstraction
 * A model
2. Recursion
 * converse of induction
 * Minimum Atomic Element  

### A little history of computer networking
1950s, 1960s  
* [Packet Switching](https://en.wikipedia.org/wiki/Packet_switching) (1960s)
* [ARPANET](https://en.wikipedia.org/wiki/ARPANET) (1969)
* Internet (1981)
* [World Wide Web](https://en.wikipedia.org/wiki/World_Wide_Web) (1991)

### Communication / Network Measures
* Frequency 
 * bandwidth
 * processing
* Speed
 * propagation speed
* Delay
 * propagation latency
 * access delay
* Loss Rate

### Rate vs. Frequency
* Rate
 * events per unit time
* Frequency 
 * time between events
 * TTC (time to complete an event)

[**Latency**](http://compnetworking.about.com/od/speedtests/a/network_latency.htm) - Fundamental Metrics  
* latency required to perform task (**performance**)
> What is **Latency**?  
> The time between creating info at a source and receiving it at a destination
* THe time between X and Y, **OR**  
* The time between server and client transaction
* the time to receive info at the destination
>What is **Cumulative Effect**?  
> Effect based on several things 

### Costs
1. Cost #1: Generation
2. Cost #2: Transmission
 * constrained by the speed of light
3. Cost #3: Processing 
 * computational translation of frequency and information
4. Cost #4: Multiplexing 
 * sharing a resource
5. Cost #5: Grouping cost
 * reduce amount of control information and overhead