# CS 131: Programming Languages: Week 4 Monday 04/18/2016

## Types

Anything you type into OCaml, you have a type returned
```ocaml
# 34;;
- : int = 34

# (3, true);;
- : int * bool = (3, true)
```

* a type is a set of values, along with associated operations on those values
* ex. `int: +, -, >`, `bool: =, !=, &&, ||, if...`, `int -> bool : set of all functions that, given an arg of type int, produce a result of type bool`

### Design Choices for Types in a Programming Language

#### Static vs. Dynamic typechecking

+ static typechecking: every program expression is given a type at compile time (C/C++, Java)
	* before you run any line of code, you get a very strong guarantee
+ dynamic typechecking: types are not explicit in the program. At run-time, during evaluation, all arguments to primitive operations are checked to be of the right type on demand.
	* ex of lang: Python, Javascript, PHP, Lisp/Scheme, 
	+ ex. 1 + "hi"
	+ Python: error at run time: '+' gave error
	+ OCaml: error at compile type if there are different types

**Side Note**: companies are building tools that create typer inference for dynamic typechecking languages
* typescript (Microsoft)
* flo (Facebook)

* Advantages of static typechecking
	* type errors are caught at compile time
		* invoking an operation with args of the wrong type
		* these errors cannot occur at run time
	* program documentation
		- types are a checked form of comments
	* enforce user-defined abstractions
		- classes/data types in OCaml
	* efficiency
		- dynamic checking checks every single primitive operation
		- static typechecking checks only once
* Disadvantages of static typechecking
	- some loss of flexibility 
		+ your code has to be checkable by the static type system
		+ no heterogeneous lists: all elements have to have the same type

**Side Note**: what if you want a list with `int` and `size`

You can have a list of tuples
```ocaml
type intorstring = I of int | S of string
# [I 1; I 2; I 3; S "hi"];;
# match l with
	h::t -> 
		match h with
			I i -> i +1;
		  | S s -> 0
```

```ocaml
# [1;2;3;"hi"];; (* this will be rejected *)
```

whereas

```python
>>> [1;2;3;"hi"] # this is correct lol
```

#### Strong vs. Weak Typechecking (sound vs. unsound)

* strongly typed: the typechecker is correct
	- there is no possibility of type errors at run time
	- you can never get into an undefined state at run time
* weakly typed: the language is broken
	- program can typecheck but still have type errors at run time
	- at which point, you are in an undefined state
* ex. C and C++ are the **only** weakly typed languages
	- unchecked typecast
	- memory errors 
		* buffer overflow (out of bound array access))
		* dangling pointers
		* uninitialized variables

#### How to get Memory Safety

* all other languages are memory safe through run-time checking
	- arrays carry around their length
		+ every array access is preceded by a bounds check
	- no manual access to pointers
		+ allocation is implicit 
		+ deallocation is done by the garbage collector
* [Just In Time Compilation](https://en.wikipedia.org/wiki/Just-in-time_compilation)
* Static/Strong: Java, OCaml, C#
* Dynamic/Strong: Python, JavaScript, PHP, Lisp
* Static/Weak: C/C++
* Dynamic/Weak: ???

#### Static Typechecking vs. Static Type Inference

* Typechecking requires program annotations on all variables
	- formal parameters, local variables
* Type Inference infers types with no annotations

## Homework 3: OCaml Interpreter
* write an interpreter which evaluates programs
* mocaml();;
* dynamically typed
* run-time checking
* ex. `34 + 5;;`
* ex. `let f = function x -> function y -> x + y;;`
* `Node(Leaf, 1, Node(Leaf, 2, Leaf));;`
* you can start using uppercase identifiers
* `[1;2;3;4];;`

### What happens inside an Interpreter
* wrote the parser for you
* takes a moexpr -> produce a moevalue
* sample implementation to do `Negate`

```ocaml
IntConst(i) -> IntVal(i)
BoolConst(b) -> BoolVal(b)
Negate(e0) ->
	let v0 = EvalExpr e0 env in
	(match v0 with
		IntVal i -> IntVal (-i)
	| _ -> raise (DynamicTypeError "can only negate integers"))
```