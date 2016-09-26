# CS 136 Week 2 Discussion

## Dropping Privileges
* If your program must run `setuid` or `setgid`, make sure to use the privilege properly so that an attacker cannot exploit other possible vulnerabilities in your program and gain these additional privileges. 
* You should perform whatever work requires the additional privileges as early in the program as possible, and you should drop the extra privileges immediately after that work is done.

* The master process is run as root, then nginx will setuid()/setgid() to USER/GROUP

* Some daemons need root permissions to start. This happens for example when a daemon wants to bind to a low port <1024> for ex. 
* Serious risk if you run network based daemons with root permissions. 
* This is why software like nginx starts with a master process and forks non-privileged child processes. These child processes run under the context of non-privileged account like www-data. 

## Authenticated Encryption

#### Encrypt-then-MAC
* plaintext is first encrypted, then a MAC is produced based on the resulting ciphertext. The ciphertext and its MAC are sent together.
* using public-key authenticated encryption, Bob can encrypt a confidential message specifically for Alice, using Alice's public key.
* Using Bob's public key, Alice can verify that the encrypted message was actually created by Bob and was not tampered with, before eventually decrypting it.
* Alice only needs Bob's public key, the nonce and the ciphertext. Bob should never ever share his secret key, even with Alice.
* **AND** in order to send messages to Alice, Bob only needs Alice's public key. Alice should never ever share her secret key either, even with Bob.

#### Confusion
* One aim of confusion is to make it very hard to find the key even if one has a large number of plaintext-ciphertext pairs produced with the same key.

#### Diffusion
* Diffusion means that changing a single character of the input will change many characters of the input. Done well, every part of the input affects every part of the output, making analysis much harder.

## Supplement: One Way Functions
* a function that is significantly easier to compute in one direction (the forward direction)

A function $f$ is one-way function if
 1. The description of $f$ is publicly known and does not require any secret information for its operation
 2. Given $x$, it is easy to compute $f(x)$
 3. Given $y$, in range of $f$, it is hard to find $x$ such that $f(x) = y$. 

* existence of one-way functions imply $P = NP$

### Examples of one-way functions

1. Factoring problem: $f(p,q) = pq$, for randomly chosen primes p, q
2. Discrete logarithm problem
3. Discrete root extraction problem
4. Subset sum problem
5. Quadratic residue problem

The existance of a one-way function implies the existence of many other useful cryptographic primitives, including:
* pseudorandom number generators
* pseudorandom function families
* bit commitment schemes
* private key encryption schemes etc

## Types of One Way Functions

#### Strong One Way Function

**Definition**: a function $f : {0, 1}* -> {0, 1}*$ is called strongly one way if two condition hold:
1. $easy to compute:$ There exists a polynomial time algorithm, $A$, so that on input $x$ algorithm $A$ outputs $f(x)$
2. $hard to invert$


