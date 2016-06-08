# Office Hour Notes

### WEP vs. WPA

* 802.11 did not do any cryptography
* WEP was ineffective:
	* still a standard, but it's crummy
	* easy to break the key exchange
	* link encryption - means you are trusting the wireless access point
* WPA is a better way of doing it
	* not likely to have difficulty with adversaries

### Honeypot: not used to deceive a person

* catching attempts of automated infection
* hydra or john the ripper

### Snort and Bro

* intrusion detection system - Snort: open source
	* widely used; signature based intrusion detection system
	* run snort on computer for intrusion detection
	* anti-virus: look for signatures on files
	* snort used for network packets
* why we care about intrusion detection
* basic appraoches people have built for detecting these intrusions, and what their shortcomings are

### C / C++

* language very flexible and highly efficient
* Java runs on top of its own Virtual Machine
	* byte code run by virtual machine
	* balance checking on arrays
	* you cannot write a buffer overlow in Java

### TOCTOU 

* security race condition - security problem to occur due to race condition; less room for there to be something bad that happens. Locking primitives to prevent issues

### Cross-Site Scripting

* chat system: send to server, get from server
* you put script in your message; receiver downloaded script
* "I'm putting this picture online, wait for someone to download"

### Orange Book

* slow and expensive to use
* year or two behind after qualified by orange book
* spend a bunch of money; too much overhead
* put together by the US military
* rating of Operating Systems
* Common Criteria was much more flexible

### STRIDE

* looking at the design of the system
* spoofing
* tampering

### DREAD

* okay, we have risks, some are really dangerous
* methodology that ppl can use to attach some numbers to it
* deciding which is the most important bug to fix

### Fuzz Testing

* input comes from remote source
* program is written in such a way that no matter what input you give it, you are good.
* test all 12 if there are only 12 inputs.
* use fuzz testing to generate a reasonable number of test cases that are spread out of the range of maybe a billion. 
* basically a sampling program 
