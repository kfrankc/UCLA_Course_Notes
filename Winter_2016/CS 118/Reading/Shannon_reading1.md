# Mathematical Theory of Communication, 1963

## 1. Introductory Note on the General Setting of the Analytical Communication Studies

### 1.1 Communication
* Communication - one mechanism _affects_ another mechanism
### 1.2 Three Levels of Communication Problems
1. Level A - How accurately can the symbols of communication be transmitted? (technical)
2. Level B - How precisely do the transmitted symbols convey the desired meaning? (semantics)
3. Level C - How effectively does the receiving meaning affect conduct in a desired way? (effectiveness)  

* _Technical_ : accuracy of transference from sender --> receiver 
 * symbols: finite set of discrete symbols
 * signal: continuous function of time
 * 2D patterns: many continuous functions of time  

* _Semantic_ : identity, or satisfactorily close approx. in interp. of meaning by receiver, compared with intended meaning of the sender.  

* _Effectiveness_ : success with which the meaning conveyed to receiver leads to desired conduct on his part. 

### 1.3 Comments
* Theory of Level A is also theory to Levels B and C.

## 2. Communication Problems at Level A

### 2.1 A Communication System and its Problems
The representation of a communication system:  
```
InfoSource --> Transmitter ------>      ------------>   Receiver ------->  Destination
           msg             signal   ^  received signal             msg
                                    |
                               noise source
```
* The information source selects desired message out of set of possible messages
* The transmitter change this message into a signal which is sent over communication channel to receiver
 * channel: wire in telephony
  * codes written words into sequences of interrupted currents of varying lengths
 * transmitter is set of devices
 * channel: brain is source for oral speech
* receiver: inverse transmitter
 * change signal back into message  

**Questions to ask about communication system:**
1. How does one measure amount of information?  
2. How does one measure the capacity of a communication channel? 
3. The action of transmitter in changing the message into the signal often invovles a _coding process_. 
 * what are characteristics of efficient coding process?
 * when the coding is as efficient as possible
 * at what rate can the channel convey information
4. What are general _characteristics of noise_?
 * how does noise affect the accuracy of the message finally received at the destination?
 * how can one minimize the undesirable effects of noise, and to what extent can they be eliminated?
5. If signal is _continuous_, rather than discrete, how does this affect the problem?

### 2.2 Information
* information is not what you _do_ say, but what you _could_ say
 * Amount of info: logarithm of the number of available choices
  * log 2 rather than log 10.
  * this is called a 'bit'
   * suggested by John W. Tukey
   * short for binary digit
   * 0 and 1 are the only two digits
* Interesting: dictionary contains no words where the initial letter 'j' is followed by b,c,d,f,g,j,k,l,q,r,t,v,w,x, or z.
* _stochastic process_: a system which produces a sequence of symbols 
 * _Markoff process_: probabilities of sequence depends on previous events 
  * _ergodic processes_: produces a sequence of symbols which would be representative of the sequence as a whole. 
   * safe and comforting sort of stat regularity  

**Entropy**  
* set up of all the probabilities involved to get information.
* formula involves log of probability
* entropy - measure of degree of randomness  
* relative entropy - ratio of the actual to the max. entropy
 * 1 - relative entropy is the redundancy
* Expression for information is as follows:
```
H = -[p_1*log(p_1) + p_2*log(p_2) + ... + p_n*log(p_n)]
H = -SUM(p_i*log(p_i))
```
* H is largest when 2 probabilities are equal
* reduce to zero when one's freedom of choice is gone
* to increase H, we need to increase the number of cases

### 2.3 Capacity of Communication Channel
* capacity of channel: in terms of number of symbols it transmits
 * expression for capacity of channel involves the log of numbers of symbols of a certain time duration. 
 * also involves the no. of such symbols handled

### 2.4 Coding
* transmitter - encode 
* receiver - decode
* transmit symbols over the channel at an average rate, which is nearly C/H, but never C/H

### 2.5 Noise
* Information (once again), is a measure of one's freedom of choice in selecting a message
* Noise lead to:
 * distortions
 * errors
 * extraneous material

### 2.6 Continuous Messages
* A continuous signal, T seconds in duration and band-limited in frequency to range from 0 to W
 * completely specified by stating 2TW numbers
* The rate of trasmitting binary digits is the following:
```
W*log_2((P + N) / N)
// W - frequency bandwidth
// P - average power used in transmission
// N - noise of power N
```
* the above equation has low frequency of error  

## 3. The Interrelationship of the Three Levels of Communication Problems

### 3.2 Generality of the Theory at Level A
* Mathematical Theory is exceedingly general in its scope
* important contribution - consideration of communication on levels B and C will require addition to diagram (above).
* error and confusion arise and fidelity decreases when one tries to crowd too much over one channel
* Language should deal with its task statistically
* _meaning_: entropy not only speaks the language of the arithmetic; it also speaks the language of language