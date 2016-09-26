# CS 131: Programming Languages: Week 4 Wednesday 04/20/2016

## Exceptions

### What if we don't use Exception? We use `option`

To look up a key's value in list of key-value pairs

Ex. `lookup 3 [(1,2)l (3,4)]) returns 4`
```ocaml
let rec lookup k l =
	match l with
		[] -> None
	  | (k', v')::rest -> if k=k' then Some v' else lookup k rest
```

The issue: this style of error signaling doesn't compose well

Example: the error handling code is intermixed with the core logic of the code, so that is not good programming style
```ocaml
let lookupAndDouble k l =
	match (lookup k l) with
		None   -> None
	  | Some v -> Some (v*2)
```

More example:
```ocaml
let rec lookupAll ks l =
	match ks with
		[] -> Some []
	  | k::rest -> 
	  		match (lookupAll rest l) with
	  			None -> None
	  		  | Some resList -> 
	  		  		match (lookup k l) with
	  		  			None -> None
	  		  		  | Some v -> Some (v::resList)
```

Conclusion: this doesn't scale. You should be able to just do `List.map`, but you are limited by this error checking.

### How to use Exceptions

Exceptions are good because they simplify how we can code.

```ocaml
exception Not_found

let rec lookupE k l = 
	match l with
		[] -> raise Not_found
	  | ('k, 'v)::rest -> if k=k' then v' else lookupE k rest

lookupE 1 [(1,2);(3,4)];;

let lookupAndDoubleE k l =
	(lookup k l)*2

let rec lookupAllE ks l =
	List.map (fun k -> lookupE k l) ks
```

### 'Try with' Exception Example

```ocaml
(* try e with p1 -> e1 | ... | pn -> en *)
let safeLookupAllE ks l =
	try
		lookupAllE ks l
	with
		Not_found -> []
```

## Parametric Polymorphisms

It's like a parameter that you can pass in

```ocaml
let rec length l =
	match l with
		[] -> 0
	  | _::t -> 1 + length t
```

`type: 'a list -> int`

`'a` is a **type variable**

we can think of this as an extra parameter to the function

Example:
```ocaml
length <int> [1;2;3]
length <string> ["hi"; "bye"]
(* NOT actual syntax *)
```

Parametric Polymorphism makes the types more _expressive_

the type instantiation (passing the implicit type parameter happens at compile time)

```ocaml
let swap (x,y) = (y,x);;
swap(1, "hi");;

let maybeSwap (x, y) b =
	if b then (y,x)
	else (x,y);;
```

Keep in mind:
* all of these happen at compile time
* 1 piece of code, which can be safely passed arguments of different types

**NOTE**: don't confuse parametric polymorphism with static overloading

## Static Overloading

_DEF:_ many different pieces of code, all with the same name, one per type that you care about

Static Overloading is a _minor convenience_ and parametric polymorphism is very useful

ex. + for ints and + for floats (in C, Java...)

### Examples of static overloading in OCaml

```ocaml
(-);;
(=);;
- : 'a -> 'a -> bool = <fun>
(<);;
- : 'a -> 'a -> bool = <fun>
```

This is **not** polymorphic 
```ocaml
(function x -> x + 1) = (function x -> x + 1);;
```

## Modules in OCaml

From hw1, we are assuming that the list we pass in is already a set, but what if we pass in a list that is not a set? We don't have a checker for that.

Need a way to separate **interface** from **implementation**
* implementation: a list
* interface: a set
* ensure that sets can't have duplicates
* let me upgrade my internal implementation without breaking callers

the type of a module is a `sig` (signature)

module type allows us to be viewed as just having the type specified
```ocaml
module type SET = sig
	type 'a t
	val emptyset : 'a t
	val member : 'a -> 'a t -> bool 
	val add : 'a -> 'a t -> 'a t
	val union: 'a t -> 'a t -> 'a t
end

module Set : SET = struct
	type 'a t = 'a list

	let emptyset = []

	let rec member =
		fun x s -> 
			match s with
				[] -> false
			  | h::t when h=x -> true
			  | h::t -> member x t
	let add =
		fun x s ->
			if member x s then s else x::s

	let 
end
```