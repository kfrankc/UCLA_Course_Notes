# CS 131: Programming Languages: Week 3 Monday 04/11/2016

## Review: higher-order functions

A _higher order_ function is one that takes another function (or two or many) as input(s). Its main virtue is letting us avoid boilerplate.

Example: `map`

It takes a function, a list, and outputs a list. This is evident from the type:
```ocaml
- : ('a -> 'b) -> 'a list -> 'b list = <fun>
```

We are converting an `'a` to a `'b` list.

Why is it called map? Because we are feeding one list of items into a function, which maps them (because it is a function!) to some other list of stuff.

Example: `filter`

It takes a predicate function, and returns the list of items within the input that satisfy that predicate:
```ocaml
- : ('a -> bool) -> 'a list -> 'a list = <fun>
```

It's also possible to define a version that removes from the original those that satisfy the predicate, i.e. an inverse filter. It would too have this filter.

Example: `fold_right`
```ocaml
- : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b = <fun>
```

What does this do again? It accumulates values (rightward for `fold_right`)

`'a list` is the input list over which we want to accumulate. `'b` is the base case value to use for an empty list. `('a -> 'b -> 'b)` is the accumulator function, which takes _two arguments_. The `'a` is one of the list items. The `'b` is the accumulator variable, to which we are accumulating, which is why it's of a different type, in case we are folding to a different type.

// Matt originally had one that was one type to the same type only.

Example:
```ocaml
List.fold_right (+) [1; 2; 3; 4] 0;;
- : int = 10
```

Another one:
```ocaml
List.fold_right
(fun s oldCount -< oldCount + String.length s)
["hello"; "there"; "goodbyte"]
0;;
```
First arg is some item; second arg is recursive result of everything so far, and the function just needs to accumulate the current item into the running total.

The point of these functions is to let us easily think at a higher-level.

### Example: `reverse`

Is `map` usable for this? No, because it is local to each element of the list (unless we know more about the list).

Is `filter` usable for this? No, because it is also local, but more importantly, it only removes elements; it cannot rearrange them.

But `fold_right` is usable for this; it's very powerful and can do almost anything.

### The `append` operator

This takes two lists `l1` and `l2`, and tacks on the elements of `l2` to `l1`:
```ocaml
(@);;
- : 'a list -> 'a list -> 'a list = <fun>

[1; 2] @ [1];;
- : int list = [1; 2; 1]
```

Back to `reverse`:
```ocaml
let reverse l = 
	List.fold_right
		(fun elem reversedRest -> reversedRest @ [elem]) l [];;

val reverse : 'a list -> 'a list = <fun>
```

Remember: we know the list we're working on (`l`, which is the input list), the base case `[]`. The key thing is that accumulator fnuction, which takes an element and an accumulator result variables (sort of to-date, running count/sum/total/etc).

Example:
```ocaml
reverse [1; 2; 3; 4];;
- : int list = [4;3;2;1]
```

We can think through a concrete example. Within that accumulator function, if we're on `1`, then the `reversedRest` is (magically) `[4;3;2]`, then we can see what to do:
```ocaml
1
[4;3;2]
```

But, `reversedRest::elem` is incorrect. This treats `reversedRest` as an element and prepends. Only `@` lets us append a one-element list at the end.

### Example `contains`

`map` is not usable for this. Why? Because we want a boolean, not a list. Same thing for `filter`.
```ocaml
let contains x l =
	List.fold_right
		(*either current matches, or is in the rest*)
		(*Note: fold_right always walks over the whole list, so 
		  linear time no matter what. Could pop out with an exception.
		  This is inherent to fold_right EVEN though we DO short-circuit 
		  the logical OR here.*)
		(fun elem isInRestOfList -> (elem = x) || isInRestOfList)
		l
		(*empty list contains nothing; i.e., no 'x'*)
		false
;;

(*short version*)
let contains x l = 
	List.fold_right
		(fun elem isInRestOfList -> (elem = x) || isInRestOfList) l false
;;
```

### Example: `primes`

Return a sub-list of all elements within a list that are prime. Let's break this into pieces, then solve piece using a higher-order function.

At a high level, we'll do this:
```ocaml
	let primes l = 
		List.filter isPrime l;;
```

At a tope level, we'll filter using some `isPrime` function
```ocaml
(*return 2 to N*)
let twoToN n =
	match n with
	1 -> []
  | _ -> (twoToN (n-1) @ [n]);;

(*returns true if N is prime*)
(*notice that we take a number, but we want to check all numbers lesser than it. Previously, everything we did was with a list.*)
(*N is a prime if only 1 and itself divide N, which implies the following:*)
(*no number between 2 and N-1 cleanly divide N, so N mod (2 ... N-1) is 0*)

let isPrime n = 
	(*Some magic function that gives from 2 to N*)
	let l = twoToN (N-1) in
		List.fold_right
			(*nothingDividesN is true if nothing in the rest divides N*)
			(fun elem nothingDividesN -> (n mod elem != 0) && nothingDividesN)
			l true;; (*base case is true for no element; start true, possibly falsify*)

(*another way: check if filter to get composites is empty list*)
let isPrime n =
	let l = twoToN (n-1) in
		(List.filter (fun elem -> n mod elem = 0) l) = [];;
```

### `range` function

Use the `Batteries` library. It uses weird `To` function.

### Exercise: `forall`

Calling out that function:
```ocaml
(fun elem nothingDividesN -> (n mod elem != 0) && nothingDividesN)
```

This requires that everything in a list fulfills a predicate. We can write this recursively or with a higher-order function. 

```ocaml
let forall f l = 
	...
```

This is built into `List`, and there is also `exists`, the equivalent of `contains`:
```ocaml
List.for_all;;
- : ('a -> bool) -> 'a list -> bool = <fun>

List.exists;;
- : ('a -> bool) -> 'a list -> bool = <fun>
```

Now every language has higher-order functions.

## User-Defined Data Types

Having this lang construct just lets us define our own rich types to let us avoid having to do everything with primitives.

"How do I handle the error cases? The answer is that there are no error cases! You're all so brainwashed!"

### Example: `optInt`

The only time anything like C's `null` exists when we manually bring such a thing into existence. 
```ocaml
type optInt = Null | NonNull of int;;
```

The capitals are new constants. `Null` is of type `optInt`, but `NonNull` is a constructor. `Null` is also a constructor, but it takes no arguments.

This is called a **tagged union**, because we have an OR of several cases, and each case has a label/tag.
```ocaml
Null;;
- : optInt = Null

NonNull;; Error: The constructor NonNull expects 1 argument(s),
but is applied here to 0 argument(s)

NonNull 34;;
- : optInt = NonNull 34
```

The `NonNull` cases has an `int`, but is of a totally different type from `int`:
```ocaml
(NonNull 34) = 34;;
Error: This expression has type int but an expression was expected of type optInt
```

Equality is automatically extended, but all other operations on `NonNull` will not be defined at this point. 
```ocaml
(NonNull 34) + (NonNull 34);; Error: This expression has type optInt but an expression was expected of type int
```

The `+` is defined for `int`. 

In other languages, `null` is treated implicitly as a value of any type. But here, this new type cannot be treated as an `int`. We have to pattern-match explicity for every case, which prevents unintended behavior.

Note that we would need to annotate types, or else the type inferencer will think of everything as an `int`.
```ocaml
let addOptInt (oi1 : optInt) (oi2 : optInt) =
	match (oi1, oi2) with
	(*add contents, then stick that result into a new NonNull*)
	(NonNull i1, NonNull i2) -> NonNull (i1 + i2)
  | _ -> Null;;
```

We could generalize to any function on ints.

### Option Type

OCaml actually already has a polymorphic optional type (for optional ints, floats, etc). It's simply called `option`: 
```ocaml
(*standard library defines it similarly to this*)
type 'a option = None | Some of 'a
```

So we have nothing (`None`) or something (`Some`) of anything. Note that we could define a similar option type, as we did above for ints.

### Example: `find`

Where might we use this? Here's an example that finds an element, and (if it's present within a list) returns the index of its first occurenace (or `None` if the element is not present). 

"In other language, you might return a -1, which is a horrible idea." (Because we might forget to check for that return-value case and try to jump straight to the -1th element, oops)

```ocaml
(*solution: we know from getting an index back that it exists*)
let find x l =
	let rec aux index l =
		match l with
			[] -> None (*hit end-of-list but did not find element*)
		  | h::t -> (* Refers to the x in the outer scope; more powerful/expressive
		  			 * than function pointers in C. It's common in FP to define
		  			 * an inner function that refers to a variable in an outer scope.
		  			 *)
		  			 if h=x then
		  			 	(* Need to construct a Some value!
		  			 	 * OCaml would infer an 'int option'
		  			 	 *)
		  			 	 Some index
		  			 else
		  			 	aux (index + 1) t
	in
		aux 0 l;;
```

## Recursive Types

### A list of our own

For data structures like trees and list, we need to be able to have data types refer to themselves (jsut like a `Node* next` in a `Node` lass in C/C++).

Example: 
```ocaml
type mylist = Empty | Node of int * mylist
```

Each list is:
* empty

OR:
* has Nodes which an int and an associated rest-of-list

FP is restrictive, but it has the trade-off for very strong guarantees of program correctness and safety. Low-level languages still have a role to play for systems-level work that needs to be maximally performant.

Example:
```ocaml
Node(1, Node(2, Node(3, Empty)));;
- : mylist = Node (1, Node (2, Node (3, Empty)))
```

We can define our (higher-order if we'd like) functions atop this type.
```ocaml
let rec sumList =
	function l -> 
		match l with
			Empty -> 0
		  | Node(h,t) -> h + sumList t;;
```

Just don't forget the constructors!

#### Custom Polymorphism

To make something polymorphic (like templates in C++):
```ocaml
type 'a mylist = Empty | Node of 'a * 'a mylist
```

### Binary Trees

A a binary tree with integer data (which could be in leaves or in internal nodes etc)
```ocaml
(*Leaf, OR Node's int, plus two children*)
(* order of tuple elements irrelevant, but
 * using Records, we could name these fields "left", "right", etc
 *)
type btree = Leaf | Node of int * btree * btree;;
```

Here, we say `Leaf` instead of `Empty`, because a `leaf` has no children (and also happens to have no integer data).

One with data at leaves as well:
```ocaml
type btree = Empty | Leaf of int | Node of btree * btree * int;;
```

One with data at leaves only:
```ocaml
type btree2 = Leaf of int | Node of btree2 * btree2;;
```

We could insert one tree type into one Node of another tree type, etc.

Let's find the size of the tree:
```ocaml
let rec treeSize t = 
	match t with
		Leaf -> 0
	  | Node(left, right, d) -> 1 + treeSize left + treeSize right;;
```

Note that due to **variable shadowing**, the inner variable will take precedence for what the aliased name should refer to. So we'd have to rename any previous type definitions of `btree`.


