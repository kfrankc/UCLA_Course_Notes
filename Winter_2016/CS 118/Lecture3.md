# CS 118 Lec. 3

### SNR Example  

[**ADSL**](https://en.wikipedia.org/wiki/Asymmetric_digital_subscriber_line): Asymmetric Digital Subscriber Line
```
C = B*log_2(1 + S/N) // where S/N = 10000
```  
We find that `C = 13 Mbps`, and it cannot go any faster.  

### Shannon's Theorem
Given desired information rate `R`, channel capacity `C`:  
if `R < C`, there exists code such that:  
* for `e > 0`, there exists a long encoding such that it is possible to transmit information without error. 
* if `R > C`, such transmission is not possible
* as long as `R < C` and `e > 0`, given large enough `M`, there exists code of length `M` such that probability of each block error is `<= e`

### Different ways to encode a block

**Parity**
* detect any **ODD** number of bit errors in the block.
* cost: 1 extra bit per block
* limitations: won't detect any **EVEN** number of errors, cannot correct the errors.

**Majority**
* sender uses repetition code  
01011 --> 0_00_1_11_0__
* receiver uses majority voting
* limitaions: big overhead

**Hamming**

**Read-Solomon**

