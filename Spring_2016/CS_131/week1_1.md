# CS 131: Programming Languages: Week 1 Monday 03/28/2016

## Languages Today
* memory safe
* no dangeling pointers
* no buffer overflow
* no seg faults
* the purpose of functional programming is to get rid of **race conditions** 
    - no mutations
    - ex. Hadoop, Spark, MapReduce

#### C and C++ Assumptions
* memory scarcity
* computers are slow
* programs in trusted environment
* low level, unsafe
* makes more sense in the 1970s!

#### Languages need to be **HIGH LEVEL** & **SAFE**
* read abstractions
* safety properties
* no more C/C++ please

## OCAML

#### What is it?
* dialect of ML
* purest functional ideas
* ex. of companies that use OCaml: Jane St, Facebook

#### What is Functional Programming?
* variables are not updated after initialization
* no mutation! 

```OCaml
3+5;;
- : int = 8 (*type inference*)

let x = 3+5;;
val x : int = 8

x + 34;;
- : int = 42

let y = x*x;;
val y : int=64

let double = (function x -> x*2);;
val double : int->int=<fun>

double = "Hello";;
error: not an 'int'

double 34;; (*or double(34), doesn't matter*)

let quadruple = (function v -> 2*(double v));;
(*NOTE: any old code will not change behavior because of new code declaration; so if we have:*)
double = (function x->x+3);; (*this does not change quadruple*)
```

#### Recursion in OCaml
```OCaml
let rec factorial =
    function n->
        if n=0 then 1 else n*factorial(n-1);;

let rec fact =
    function n->
        match n with 
            0->1
          | _->n*fact(n-1);;

let rec isEven = (function n->
                    match n with
                        0->true
                      | 1->false
                      | _->if n>0 then isEven(n-2) else isEven(n+2));;

(*OR, you can use the 'when' syntax*)
let rec isEven2 = (function n->
                    match n with
                        0->true
                      | 1->false
                      | _ when n>0->isEven2(n-2)
                      | _->isEven2(n+2));;
```

#### Data Structures

##### List

```OCaml
[1; 2; 3];;
- : int list = [1; 2; 3]
1::(2::(3::[])) (*same as above; '::' acts like 'cons' in Lisp*)
(*recursion is the natural way to decompose a list; a list can be decomposed as 'h': first element of list, and 't', rest of the elements in the list*)
let rec sumLst = function lst ->
        match lst with
            []-> 0
          | h::t-> h + sumLst t;;
(*P1::P2 means non-empty patterns; P1::P2::t means pattern for a list of at least 2 elements*)

let rec everyOther =
    function lst ->
        match lst with
            [] -> []
          | [h] -> [h](*handle for when you have only one element*)
          | h1::_::t -> h1::everyOther(t);; (*in OCaml, '_' means don't care*)
```
