## Week 5 Thursday: Chapter 10: Authentication (309 - 335)

## Chapter 10:

### Key Management

* distribution of cryptographic keys
* key generation and binding of identity to key using certificates
* key storage and revocation
* digital signatures

### Session and Interchange Keys

_def_: an interchange key is a cryptographic key associated with a principal to a communication. A session key is a cryptographic key associated with the communication itself. 

_def_: forward search: attacker enciphers all plaintexts using target's public key. When ciphertext is intercepted, it is compared with precomputed texts. 

### Key Exchange

enable Alice to communicate secretly to Bob, and vice versa, using a shared cryptographic key. 

1. key cannot be transmitted in the clear. 
2. alice and bob may decide to trust a third party
3. the cryptosystems and protocols are publicly known. The only secret data is to be the cryptographic keys invovled. 

#### Classical Cryptographic Key Exchange and Authentication

* rely on trusted third party
* Needham-Schroeder Protocol: nonces generated randomly 
	* assumes all cryptographic keys are secure

### Kerberos

* requires a client to use two servers to obtain a credential that will authenticate her to S.
* ticket credential: 

### Public Key Cryptography

* man in the middle attack: when Eve has session key and read traffic between Alice and Bob
* man in the middle works because there's no binding of identity to a public key. When presented with a public key belonging to Bob, Alice has no way to verify that public key in fact belongs to Bob. 

## Chapter 11: Cipher Techniques

### Stream & Block Ciphers

_def_: let E be a encipherment algorithm, and let E_k(b) be the encipherment of message b with key k. Let a message m = b1b2..., where each b1 is of a fixed length. Then a block cipher is a cipher for which Ek(m) = Ek(b1)Ek(b2)...

Other ciphers use a nonrepeating stream of key elements to encipher characters of a message

_def_: one time pad is a cipher that can be proven secure. 

### Block Ciphers

_def_: block cipher multiple bits at once, rather than one bit at a time.

_def_: cipher block chaining does not require the extra information to occupy bit spaces, so every bit in the block is part of the message. 

_def_: multiple encryption: using two keys k and k' to encipher a message. 

### 11.3: Networks and Cryptography

ISO/OSI model provides abstract representation of networks suitable for our purposes. 

* Application Layer
* Presentation Layer
* Session Layer
* Transport Layer
* Network Layer
* Data Link Layer
* Physical Layer

### 11.4: Example Protocols

* secure electronic mail: PEM
* design principles
	* compatibility
	* related protocls should not be changed
	* independence
	* comm without prearrangement
* More about PEM
	* defines two types of keys
	* enciphered with data encipherment key (DEK)
* provide cryptography for email
	* I want to be sure that the email has integrity, that nobody has fiddled with the text of the email
	* you want a fresh key for every key you are sending
	* session key is symmetric key, the email itself is the only interaction I had with you.
* through out of band mechanism, you know my public key
* you create a session key, encrypt with my public key, then encrypt the body with the session key
* when I get the mail, I can decrypt the session key, and use the private key 
* problem: how do I know your public key.

### Summary

* confidentiality
* integrity
* authentication
* nonrepudiation


