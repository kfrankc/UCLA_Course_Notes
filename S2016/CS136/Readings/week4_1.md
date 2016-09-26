## Week 4 Tuesday: Chapter 12: Authentication (309 - 335)

### 12.1 Authentication Basics

_Definition_: Authentication is the binding of an identity to a subject

Information from external entity to enable confirmation of identity:

1. What the entity knows (password)
2. What the entity has (badge or card)
3. What the entity is (fingerprints, retinal)
4. Where the entity is (such as in front of a particular terminal)

The authentication system (5 components):

1. set A: _authentication information_ - set of info with which entities prove their identities
2. set C: _complementary information_ - set of info that system stores and uses to validate the authentication info
3. set F: _complementation functions_ - generate information from auth info
4. set L: _authentication functions_ - verify identity
5. set S: _selection function_ - enable entity to create or alter auth and complementary information

### 12.2 Passwords

_Definition_: info associated with entity that confirms entity's id

* one way hash - turn passwd into complement

2 ways to protect password, used at the same time:

1. hide info so one of a, c, or f cannot be found
2. prevent access to the authentication functions L

Types of passwd attacks

1. dictionary attack
	* counter: $P \geq \frac{TG}{N}$
	* random selection of passwd: let expected time required to guess password be T. Then T is a max when selection of any of a set of possbile passwd is equi-probable
	* transformation algorithm
	* pronounceable passwords
	* user selection of passwd (proactive passwd selection)
		- must always be invoked
		- reject any passwd in a set of easily guessed passwd
		- discriminate on a per-user basis, per-site basis

Guessing through authentication functions

* counter: backoff - wait x amt of time after failed auth
* disconnection - shuts you out after x no of trys
* disabling - disabled until sys admin reenable
* jailing - honeypot --> bogus 

Aging of Passwd

* force users to change to a different password 
	- record n prev passwd, no duplicates

### 12.3 Challenge Response

_def_: user U want to auth to system S. U and S have secret function f. S sends random msg m to U, U replies with r=f(m) the response. S validates r

* pass algorithms
	- f itself is secret
* one time passwords
	- invalidated as soon as it is used
* hardware supported challenge response procedures
	- general purpose
	- temporally based: changes every x time frame

### 12.4 Biometrics

* fingerprints - scanned optically; approx. match
* voices - speaker dependent
* eyes - only used for most secure place
* faces - 
* keystrokes
* combinations
* caution - replay attack

### 12.5 Location

* GPS track to where you are 
* restrict where you are to access the material
