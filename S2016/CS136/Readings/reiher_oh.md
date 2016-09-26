## OH Notes

* usually except social engineering, all are automated

### Clark Wilson Model

* characteristics of data that should maintain regardless of the system
* The ACID principle says you define your own transactions
	* if you have permissions to do this, assure you have capability to do this
* clark wilson says ACID does not maintain this
* "you are suppose to remove 500 and place 500 in shipping", but you didn't
* integrity constraints you have to follow
	* ACID says trust the transactions
	* Clark WIlson says no

### Full Disk Encryption vs File Name Encryption

* file encryption does not encrypt swap space
* issue: file encryption encrypts each file individually
* you don't encrypt the files; structure of the file system is going to be such that one of the files is a directory
* full disk encryption means you can't see anything like that, because it is encrypted.

### Security Enclaves

* security enclave in iPhone is specific to iPhones
* TPM is a security enclave
	* separate system that is responsible for some security operations

### Needham-Schroader

* uses ONLY symmetric cryptography
* Alice wants to share a key with Bob
	* they each share a symmetric key with Trent, Ka, Kb
	* Alice generates a nonce, sends to Trent: Hi I'm alice, I want to talk to Bob, here's my nonce
	* Trent gets the message, Alice would like to talk to Bob, generate a new session key, with nonce Ra
	* Trent encrypts a bunch of stuff with Alice's key
	* Trent sends Ra, Bob, Ks, and also sends Ks, Alice encrypted with Bob's key
* purpose of Ra is to prevent replay attack, when Alice reads the message, Ra, if it is the right nonce, then Alice knows that there's no replay attack
* the Ekb(Ks, Alice) is included in the encrypted by Alice; this makes sure that no one can chop it off
* Alice will send that to Bob, Bob gets this, Bob will see that Alice is in the encrypted message
* Bob will generate a nonce of his own, Rb, encrypts with his branch new session key, and he sends that to Alice. Alice will decrypt it, and checks that it is right
* Aice will subtract one from the random number, and encrypts using a session key to encrypt
* the encrypted version of Rb and Rb-1 should be totally different
	* this means someone in the middle COULD NOT have guessed this
* save from replay attacks

### Digital Signature
* you are providing proof that you created a certain document
* PDF sign: secure form the POV of oridinary use
* one example of public key 

### Certificates
* essentially a mechanism for securing distribution of information
* this is my public key (how do you know what my public key is?)
* certificates are used to solve that problem
* each of them might have their own public keys
* transitive trust

### Crossover Error Rate
* false positive and false negatives

### Locks and Keys - Mechanism of Access Control
* form of capabilities - use cryptographic techniques to tell you what you need to know

### Chinese Wall Policy
* a party who has access to one body of info should be prevented to access another body of conflicting info
* info from different accounts segregated into different ppl who work in another account
* segregating info to prevent accidential leakage

### Page Tables & RAM (read OS Protection)
* use hardware technique to prevent invalid reading from RAM

### DES
* symmetric key algorithm
* really easy to define a bad symmetric key algorithm
* defining a good one is hard to create
* 56 bit keys

### AES
* symmetric ciphers
* rules they use to encrypt is different from DES
* AES has much longer keys
* 128 or 256 bit keys

### RSA
* public key algorithm 
* based on mathematical problem - map that to the generation of public and private key pair

### Capabilities
* because Heidi is cleared for high info, she shouldn't get any capabilities to write to anything that is low
* if she can read a file that contains that data structure
* mere ability to read a data structure will give you abilities to do something or not
* access control list is different: whether you are on the list or you are not

### SYN Cookies
* SYN flood - you are not attacking volumn of packets; you see that site runs TCP, site has a table of open TCP sessions, SYN flood is intended to fill in the entire table
* cookie - assurance that someone really want to
* send SYN, you get ACK, then SYN-ACK
* anyone who wants to comm with me, gets some space in the table, MUST complete the 3-way handshake; 
* I get some information in the ACK that
* send back SYN-ACK, I will not remember you send me a SYN
	* you dont send me ACK, i didn't save in my table
	* send me an ACK, make sure send SYN and ACK
	* SYN cookie - gets put in SYN-ACK back to person, he will take the number I put in my SYN-ACK, add 1 to it, send me ACK that contains cookie+1, is that the number I sent to him + 1, 
	* I don't want to remember the number, it needs to be a number that I can reproduce, it must be that number + 1, therefore, I know whether it is a good response or not
	* I have to be able to determine that it does or does not match 
	* use info from SYN that I expect to see in ACK (IP address, port number, I know who I am, I know what port he tried to coomm with me on). SYN and ACK are matched
	* he could guess all of that information
	* add a timer, timer click every so often, use part of info from timer to create number
	* need a secret, private key
	* I'll take info from messages
		* take timer, get secret numebr
		* create a hash
		* use a seq in my SYN-ACK
		* in the ACK back
			* look timer, secret, IP addr, get a number, add 1, check if it is correct
* is this person using his open connections with multiple places,
	* if not, we won't give it to him; limit the number of entries he will use up


