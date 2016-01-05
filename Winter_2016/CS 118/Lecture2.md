# CS 118 Lec. 2: Communication and Info. Sharing

**Shared Info**
* Technical 
* Semantics
* Effectiveness  

**Syntax**
* Symbol
* Sequence  

**Semantics**
* meaning?  

**Analog vs. Digital
* analog - ambiguous
* digital - mapped to **_ONE_** meaning  

[**Discretization**](https://en.wikipedia.org/wiki/Discretization_of_continuous_features)
* convert to discrete values  

**Effectiveness** 
* precision (would two receivers interpret at the same state?)
* accuracy (state the transmitter intended?)

> **Famous [Natural Language Processing](https://en.wikipedia.org/wiki/Natural_language_processing) Question:**  
> Fruit flies **like** a banana; Time flies **like** an arrow.

### What is communication?
* Communication vs. [Entropy](https://en.wikipedia.org/wiki/Entropy_(information_theory))  
H_i = -p_i * log(p_i)
* Source Entropy  
H = - Sigma(p_i * log(p_i))
* Example: if sender **always** sends YES, or **always** sends NO, the entropy is at minimum
 * else, if YES or NO is both 50/50, then entropy is at max  
* Source has entropy H
* Channel has capacity C
> C/H - e symbols transmitted per second  
> *for small e