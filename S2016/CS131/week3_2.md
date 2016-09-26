# CS 131: Programming Languages: Week 3 Monday 04/11/2016

## Binary Trees
```ocaml
(*binary tree*)
type btree = Leaf | Node of btree * int * btree
# Leaf;;
- : btree = Leaf
```

Example:
```ocaml
Node(Leaf, 34, Leaf);;
```

More Example:
```ocaml
# let t1 = Node(Leaf, 34, Leaf)
val t1 = btree = Node (Leaf, 34, Leaf)
```
Exercise 1:
```ocaml
let rec height t =
	match t with
	    Leaf -> 1
	  | Node(left, _, right) ->
	  		if (height left) > (height right)
	  		then 1 + (height left)
	  		else 1 + (height right)
;;
```

Optimization to Exercise 1: Local Variables
```ocaml
let rec height t =
	match t with
	    Leaf -> 1
	  | Node(left, _, right) ->
	  		let hl = height left in
	  		let hr = height right in
	  		if hl > hr
	  		then 1 + hl
	  		else 1 + hr
;;
```
**NOTE**: memoization is built into the compiler

Example: inserting into a binary tree
```ocaml
let rec insert n t = 
	match t with
		Leaf -> Node(Leaf, n, Leaf) (*need to do the insertion here*)
	  | Node(left, v, right) -> if n > v
	  							then Node(left, v, insert n right)
	  							else if n = v then t
	  							else Node(insert n left, v, right)
```
This is really good for parallelism and persistent data structure

## Variable Scoping

How can we declare variables?
* top-level let: `let x = 5;;`
 * scope: rest of the program
* let expression: `let x = 5 in x + 2` OR `let x = e1 in e2`
 * scope: just `e2`
 * pop quiz; what if it was `let rec x = e1 in e2`?
  * ANS: scope is `e1` and `e2`
* pattern matching:
 * scope of `h` and `t`: `e1`
```ocaml
match [1;2;3] with
	h::t -> ...
```
* function parameters: `function x -> x + 1`
 * `function x -> e`
 * scope of x: `e`

### Static Scoping
* at compile time, you can determine for each variable usage, which variable declaration it refers to.
* nearest enclosing definition in the program text

Example:
```ocaml
let x = 45;;
let f = function y -> x + y
f 3;; (*get 48*)
let x = 12;;
```

What is a closure

* maintains an environment telling you where the variable is stored at
* an environment is a representation of the scope: a map from variables to values
```ocaml
{}
let x = 45;;
(*{x:45}*)
let f = function y -> x + y;;
(*{x:45, f:((function y -> x + y), {x:45})}
   key: everytime you invoke a function, you are actually grabbing the static environment of that function's scope, not the global scope
*)

f 3
(*
- look up f in the environment
  (function y -> x + y) 3
- substitute actual args for formal parameters
{x:45, f:(function y -> x + y), x:3}
  x + y
  returns 48
*)
```

**NOTE**: there's a garbage collector in OCaml

Environment for `addTwo`
```ocaml
let add = fun x y -> x + y
(*
	{add: (fun x y -> x + y, {})}
*)

let addTwo = add 2
(*
	what happens?
		1. Look up add in the environment
			(function x -> function y -> x + y) 2
		2. execute it in add's static environment {}
			bind x to 2: {x:2}
			execute function body: function y -> x + y
	{add: ..., addTwo: (function y -> x + y, {x:2})}
*)
```

**KEY**: a variable's _lifetime_ is different from its scope: a variable can be lie, because others code refers to it, even if it's out of scope.



