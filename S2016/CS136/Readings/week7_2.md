## Week 7 Thursday - Chapter 22: Malicious Logic (613-641)

### Trojan Horses

Malicious logic: the system canot determine whether the instructions being executed byt a process are known to the user or are a set of instructions what the user does not intend to execute. The next definition makes this distinction explicit.

_def:_ a trojan horse is a program with an overt effect and a covert effect.

Properties of Trojan Horses

* make copies of themselves

_def:_ a propagating Trojan Horse is a Trojan Horse that creates a copy of itself.

### Computer Viruses

_def:_ a computer virus is a program that inserts itself into one or more files and then performs some action.

Phases of virus:

1. Insertion Phase
    * present but not always executed
    * ex. Lehigh virus check for uninfected boot file and if one was found, it would infect that file. 
2. Execution Phase

Key: Computer Viruses are different from Trojan Horses because they have no covert purpose. It's overt purpose is to infect and execute. 

### Boot Sector Infectors

_def:_ boot sector is the part of hte disk used to bootstrap the system or mount a disk. Code in that sector is executed when the system sees the disk for the first time. 

_def:_ boot sector infector is a virus that iserts itself into the boot sector of a disk.

### Executable Infectors

_def:_ executable infector is a virus that infects executable programs.

### Multipartite Viruses

_def:_ infect either boot sectors or applications

### TSR Viruses

_def:_ terminate and stay resident (TSR) virus is one that stays active in memory after the application has terminated.

### Stealth Viruses

_def:_ viruses that conceal the infection of files.

### Encrypted Viruses

_def:_ enciphers all of the virus code except for a small decryption routine.

### Polymorphic Viruses

_def:_ virus that changes its form each time it inserts itself into another program.

* change the instructions in the virus to something equivalent but different. The deciphering code is the segment of the virus that is changed. In some sense, they are successors to the encrypting viruses and are often used in conjunction with them.

### Macro Viruses

_def:_ virus composed of a sequence of instructions that is interpreted, rather than executed directly. 

* infect either executables or data files
* must be arranged to be interpreted at some point if it infects executable files.
* not bound by machine architecture. They use specific programs, and so a macro virus targetd at Microsoft Word will work on any system running Microsoft Word.

### Computer Worms

_def_: a computer worm is a program that copies itself from one computer to another. 

### Other forms

#### Rabbits and Bacteria

_def_: bacterium or rabbit is a program that absorbs all of some class or resource.

#### Logic Bombs

_def:_ program that performs an action that violates the security policy when some external event occurs.

### Theory of Malicious Logic

* is there a universal detector that can be written to detect malicious logic? We consider the narrower question of whether there is an algorithm that can determine if an arbitrary program contains replicating code. 

#### Theory of Computer Viruses

* Virus detection problem, like the safety problem, is undecidable
* It is undecidable whether an arbitrary program contains a computer virus.
* It is undecidable whether an arbitrary program contains malicious logic.

### Defenses

* takes advantage of several different characteristic
* some malicious logic acts as both data and instructions
* limit objects accessible to a given process run by the user is protection technique.

### Information Flow Metric

* define the flow distance metric for some information x as follows. Initially, all information has fd(x) = 0. Whenever x is shared, fd(x) increases by 1. Whenever x is used as input to a computation, the flow distance of the output is the maximum of the flow distance of the input. 
* I kinda didn't understand this section, but I don't think it will be tested.

### Sandboxing

* VMs implicity restrict process rights.
* restrict the program by modifying it

### Malicious Logic Crossing Protection Domain Boundaries by Sharing

* inhibit users in different protections domains from sharing programs or data will inhibit malicious logic from spreading among those domains. This takes advantage of the separation implicit in integrity policies.

### Malicious Logic Altering Files

* Manipulation Detection Codes (MDCs) apply some function to a file to obtain a set of bits called the signature block and then protect that block. If, after recomputing the signature block, the result differs from the stored signature block, the file has changed, result of malicious logic latering the file.
* Assume signed file does not contain malicious logic before it was signed. 

### Malicious Logic Performing Actions Beyond Specification

* break programs into seq of nonbranching instructions and checksums each seq, storing the result in encryption form. When program is run, processor recomputes checksums. 

### Proof Carrying Code

* proof-carrying code, requires a code consumer (user) to specify a safety requirement. The code producer generates a proof that the code meets the desired safety property and integrates that proof with the executable code. 

### The Notion of Trust

* secure like trust is relative notion, and design of any mechanism for enhacing computer security must attempt ot balance the cost of hte mechanism against the level of security desired. 


