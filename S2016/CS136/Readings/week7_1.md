## Week 7 Tuesday - Chapter 25: Intrusion Detection (723 - 767)

### Principles

1. actions of users conform to statistically predictable pattern
2. actions of users do not include seq of commands to subvert the security policy of the system.
3. actions of processes conform to set of sepcifications describing actions that the processes are allowed to do

### 25.2 Basic Intrusion Detection

_attack tool_: automated script designed to violate a security policy

_rootkit_: sniff passwords from the network; conceal presence; 

An attack involving rootkit:

* rootkit alters the program that interprets the data in those structures

#### The Intrusion Detection System (IDS)

1. detect wide variety of intrusions
2. detect intrusions in a timely fashion
3. present analysis in a simple easy to understand format
4. be accurate

### 25.3 Models

Model: classifies a seq of states or actions as good or bad (possible intrusions)

* adaptive: alter behavior on basis of system states or actions
* static: initialized from collected data

_anomaly detectin_: analyze set of characteristics of the system and compares their behavior with a set of expected values. 

3 different models:

1. threshold metric: min `m` and max `n` events are expected to occur
	* ex. log out after n log attempts
2. statistical metric: knows mean and std
	* sensitive to sudden changes in behavior
	* more flexibility than threshold model
	* also more complex than threshold model
3. markov metric: notion of 'states', or past history, can be used to detect anomalies
	* effectiveness of markov model depends on adequacy of data used to establish model

Statistical Modeling can detect outliers

_misuse detection_: determines whether a seq of instructions being executed is known to violate the site security policy being executed. 

_specification-based detection_: determines whether or not a seq of instructions violate a specification of how a program, or system, should execute. If so, it reports a potential intrusion.

_system trace_: seq of events during the execution of a system of processes

_subtrace of T_: is a seq of events where it is a subseq of T.

_merge_: a trace T is a merge of two traces

_filter p_ function that maps a trace T to a subtrace T' such that for all events t in T, p(t) is true

_execution trace_: seq of ops performed by processes making up the subject

### 25.4 Architecture

Intrusion Detection System is also automatic auditing mechanism.

* agent: logger
	* obtains info from data source
	* provide director with information so director can report possible violations of the security policy
* director: analyzer
	* reduce incoming log entries to eliminate unnecessary records
	* use analysis engine to determine if attack is underway
	* use many analysis technique
* notifier: determines whether to notify the entity
	* accepts information from director and takes appropriate action
	* GUI / electronic email

### 25.5 Organization of Intrusion Detection Systems

3 paradigms using research intrusion detection system. 

* network traffic ONLY
* combine network and host sources
* distributed the director among multiple systems

### 25.6 Intrusion Response

* Incident Prevention
	- closely monitering the system
	- multilevel secure systems are excellent 
	- place into security compartment isolated from other compartments
* Intrusion Handeling
	- preparation for an attack
	- identification of an attack
	- containment
	- eradication
	- recovery 
	- follow-up
* Containment Phase
	- approach 1: passively monitoring the attack
	- steps taken to constain the action of the attacker
* eradication phase
	- stopping the attack
	- ensure attack does not immediately resume
	- firewalls work
	- IDIP protocol runs on a set of computer systems
* Follow up Phase
	- system takes some actions extyernal to the system against the attacker
	- Thumbprinting: takes advantage of connections passing through several hosts (take as little space as possible)
* CounterAttacking
	- first form: legal mechanisms: filing criminal complaints
	- conseqenceis of counter attacks
		+ harm innocent party
		+ side effects
		+ antithetical to shared use of network
		+ legally actionable

### Conclusion

* Intrusion Detection - auditing that loks for break ins and attacks
* anomaly detection looks for unexpected behavior
* misuse detection looks for seq of events known to indicate attacks
* specification-based detection loks for actions outside the specification of key programs
* intrusion detection are auditing engines
