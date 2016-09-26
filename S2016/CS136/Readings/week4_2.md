## Week 4 Thursday: Chapter 17: Confinement Problem
Ch.17 Sec 17.1 - 17.2.2 (439-446), introduction to 17.3 (446-448), 17.3.3 (467-470)

### 17.1 The Confinement Problem

Access control affects the function of servers in two ways:

1. server must ensure resrc it accesses on behalf of client includes only those resources that client is authorized to access
2. server msut ensure that it does not reveal the client's data to any other entity not authorized to see the client's data

_def_: a covert channel is a path of communication that was not designed to be used for communciation

_def_: the rule of transititve confinement states that if a confined process invokes a second process, the second process must be as confined as the caller

* confinement used for enforcing principle of least privilege
    - confined process cannot transmit data to a second process unless transmission is needed to complete their task

### 17.2 Isolation

systems isolate process is two ways:
1. process presented with environment that appears to be computer running only that process or those proecsses to be isolated
2. environment provided in which process actions are analyzed to determine if they leak info.

* virtual machines
    - _def_: a program that simulates hardware of computer system
    - channels can be controlled or severed
* sandboxes
    - _def_: safe environment for programs to execute in, they are restricted according to a security policy

### 17.3 Covert Channels

_def_: a covert storage channel uses an attribute of the sahred resource. A covert timing channel uses a temporal or ordering relationship among accesses to a shared resource

_def_: a noiseless covert channel is a covert channel that uses a resource available to the sender and receiver only. A noisy covert channel is a covert channel that uses a resource available to subjects other than the sender and receiver, as well as to the sender and receiver 

* Mitigation of Covert Channels
    - 
