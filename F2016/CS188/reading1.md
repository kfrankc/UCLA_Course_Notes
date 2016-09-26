# High Performance Browser Networking

## Chapter 1: Speed is a Feature

**Web Performance Optimization (WPO)**: fast growth in industry

Key Points:

* Faster sites lead to better use engagement
* Faster sites lead to better user retention
* Faster sites lead to higher conversions

_Speed is a Feature, and there are 2 components that dictate the performance of all network traffic_

**Latency**: the time from the src sending a packet to the dest. receiving it

**Bandwidth**: max. throughput of a logical or physical communication path

> Hibernia Express: ensure lowest latency between NY and London by following the circle route between cities. $60M+ per millisecond saved!

### Components of Latency

* Propagation Delay: _amt. of time required for msg to travel from sender to receiver_
* Transmission Delay: _amt. of time required to push all packet's bits into the link_
* Processing Delay: _amt. of time required to process the packet header, check for bit-level errors, and determine packet's destination_
* Queuing Delay: _amt. of time the packet is waiting in queue until it can be processed._

> Network data rates: measured in bits per second (bps), non-network data rates are bytes per second (Bps).

> Bufferbloat: coined by Jim Gettys (2010). Routers think dropping packets should be avoided at all cost, but breaks TCP congestion avoidance.

### Speed of Light and Propagation Latency

> Fun Fact: it takes 160ms for light in fiber to travel from NY to Sydney round trip!

> A _lag_ is considered to be noticable once a delay of over 100-200 milliseconds is introduced. _Sluggish_ happens at 1000 milliseconds.

> CDN (Content Delivery Network) provide the benefit of reducing the distance that packets have to travel. Use CDNs!! (ex. Cloudflare)

### Last Mile Latency

Using `traceroute`, one can see that the last few mile takes the longest
```
$> traceroute google.com
```

> Latency, not bandwidth is the performance bottleneck for most websites! 

Visit [SpeedTest](https://speedtest.net) to check upstream and downstream tests against a nearby server.

### Delivering Higher Bandwidth & Lower Lantencies

Streaming videos are now responsible for over half of all Internet traffic. 

To improve bandwidth, we can add more fibers in fiber-optic links, deploy more links.

To improve latency, we can improve the quality of fiber links to allow us to get closer to the speed of light. Alternatively, we can make the distance travelled _shorter_. 

----

## Chapter 2: Building Blocks of TCP

Two protocols in the Internet: IP & TCP. 

* IP (Internet Protocol): provides the host-to-host routing and addressing.
* TCP (Transmission Control Protocol): provides the abstraction of reliable network running over an unreliable channel.
	* guarantee all bytes sent will be identitical; bytes will also arrive in the same order to the client. 

> The `v4` in IPv4 is heritage of its relationship to TCP. There's no `v5`, since it was used for Internet Stream Protocol (ST). So `v6` is used.

### Three-Way Handshake

* SYN: client picks random seq. number _X_ and sends a SYN packet
* SYN ACK: server increments _X_ by one, picks own random seq. number _Y_, dispatches the response.
* ACK: client increments both _X_ and _Y_ by one, completes the handshake by dispatching the last ACK packet in the handshake.

> Key: each new connection in TCP require a full roundtrip of latency before any application data can be transferred.

> TCP Fast Open (TFO) is a mechanism that aims to eliminate the latency penalty imposed on new TCP connections by allowing data transfers within the SYN packet. 

### Flow Control

> Advanced Research Projects Agency Network (ARPANET) was precursor to modern Internet. Officially launched in 1969!

Flow control prevents sender from overwhelming receiver with data that it may not be able to process. Each side has a window that represents the amt. of buffer space to hold incoming data.

### Slow Start

Flow control does not prevent either side from overwhelming the underlying network. Neither sender nor receiver knows the available bandwidth at the beginning of a new connection. 

**Slow start adapts speeds to the conditions of the network**

> slow-start restart (SSR): resets congestion window of connection after it has been idle for a defined period of time. 

### Congestion Avoidance

packet loss is a sign of network congestion. Adjsut window to avoid inducing more packet loss to avoid overwhelming the network.

### Bandwidth Delay Product

> definition: the product of data link's capacity and its end-to-end delay. The result is the max. amount of unacknowledged adata that can be in flight at any point in time.

### Head-of-Line Blocking

TCP is not the only method that is needed! There is also UDP. Sometimes, packet loss is OK. Here are some applications that can tolerate packet loss: audio, video, game state updates.

### Tuning Server Configuration for TCP

Here are some good practices for configuring servers:

* Increase TCP's initial congestion window
* Slow-start Restart
* Window Scaling (RFC 1323)
* TCP Fast Open (TFO)

### Tuning Application Behavior

*  no bit is faster than one that is not sent; send fewer bits
*  we can't make bits travel faster, but move bits closer
*  TCP connection reuse is critical to improve performance

### Performance Checklist (conclusion)

1. Upgrade server kernel to latest version
2. Ensure that cwnd size is set to 10
3. Ensure that window scaling is enabled
4. Disable slow-start after idle
5. Investigate enabling TCP Fast Open
6. Eliminate redundant data transfers
7. Compress transferred data
8. Position servers closer to the user to reduce roundtrip times.
9. Reuse TCP connections whenever possible