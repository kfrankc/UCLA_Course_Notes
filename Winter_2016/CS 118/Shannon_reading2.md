# Mathematical Theory of Communication, 1963

## Introduction
* natural choice for information produced when one message is chosen from the set is _logarithmic function_.  
**Log measure is convenient for the following reasons:**
1. practically more useful - parameters of engineering (time, bandwidth, number of relays) vary linearly with the logarithm of no. of possibilities
2. nearer to our intuitive feelings as to the proper measure
3. mathematically more suitable - limiting ops are simple in terms of the logarithms
 * choice of log base --> corresponds to choice of unit for measuring information
 * base 2 - binary digits, or bits
 * base 10 - decimal digits, 3.3333 bits
 * using base e - natural units (change from base a to base b requires multiplication by log_b(a))  

**Communication System**  
1. information source 
 * sequence of letters 
 * function of time
 * function of time and other variables as in black and white TV
 * two or more functions of time
 * several functions of several variables
 * various combinations also occur
2. transmitter 
3. channel - medium used to transmit signal from transmitter to receiver
4. receiver - perform inverse op of transmitter
5. destination - person or (thing) for whom the message is intended  

**Communication Systems in 3 categories**: 
1. discrete - sequence of letters, dots, or dashes
2. continuous - radio or TV
3. mixed - PCM transmission of speech

## Discrete Noiseless Systems

### 1. Discrete Noiseless Channel
* ex. teletype and telegraphy
>**Definition:**  
> A system where a sequence of choices from a finite set of elementary symbols S_1...S_n can be transmitted from one point to another.  
* Each symbol S_i is assumed to have certain duration in time t_i seconds
* In telegraphy: 
 * dot (line closure for a unit of time, and a line open for a unit of time)
 * dash (three time units of closure and one unit open)
 * a letter (three units of line open)
 * a word (six units of line open)

General rule: the capcity _C_ of a discrete channel is given by
```
C = Limit as T --> infinity: log N(T) / T
// where N(T) is the no. of allowed signals of duration T

N(t) = N(t-T_1) + N(t-t_2) + ... + N(t-t_n)
// total number is equal to sum of numbers of sequences ending in S_1, S_2, ... , S_n
// which are N(t-t_1), N(t-t_2), ... , N(t-t_n)

// N(t) is asymptotic for large t to AX_0_t, where A is constant, and X_0 is largest real sol. of the equation: X^-t_1 + X^-t_2 + ... + X^-t_n = 1
// therefore, C = limit as T --> infinity: log (AX_0_T) / T
```
**Example**:  
```
N(t) = N(t-2) + N(t-4) +N(t-5) + N(t-7) + N(t-8) + N(t-10)
C = -log(u_0), where u_0 is the positive root of 1 = u^2 + u^4 + u^5 + u^7 + u^8 + u^10
Solving this, we et C = 0.539
```

>**Theorem 1:**  
> Let b_ij be the duration of the sth symbol which is allowable in state i and leads to stage j. Then, the channel capacity C is equal to log W, where W is the largest real root of the determinantal eq.

* note: review pae 45 and 46; I still don't understand them 

