# CS 131: Programming Languages: Week 2 Wednesday 04/06/2016

## Follow-Up from prevous lecture:

```ocaml
let rec combineInts = 
	fun (f : 'int -> 'int -> 'int) (l : 'int list) (ifNil : 'int)->
		match l with
			[] -> ifNil
		  |	[x] -> x
		  | hd::tl -> f hd (combineInts f tl ifNil)
;;

let sumList = combineInts (+) l 0;;
let prodList = combineInts (*) l 1;;
```
#### Can we implement `length` using combineInts?

```ocaml
let length l = sumList (List.map (fun _ -> 1)) l);;
(*not a good way to do this, because you are traversing the list twice*)
```

#### How can we make subList, prodList work for empty lists?
* `sumList [] = ? `  0 // sum of empty list is always 0
* `prodList [] = ? ` 1 // we want these to be different

* We can now get rid of the 2nd base case:

```ocaml
let rec combineInts = 
	fun (f : 'int -> 'int -> 'int) (l : 'int list) (ifNil : 'int)->
		match l with
			[] -> ifNil
		  | hd::tl -> f hd (combineInts f tl ifNil)
;;
```

* Now, with this new definition, we can get `length` function to work

```ocaml
let length l = combineInts(fun _ lengthOfTail -> 1 + lengthOfTail) l 0;;
(*TODO: try to understand this*)
```

Another syntax change for this implementation:
```ocaml
let rec length = 
	fun (l : int list) ->
		match l with
			[] -> 0 (*ifNil*)
		  | hd::tl ->
		  	(fun _ x -> 1 + x) hd (length tl)
;;
```

##### Stepping through length

```ocaml
let length l = combineInts (fun _ x -> 1 + x) l 0;;

length [1;2] 
= (fun _ x -> 1 + x) 1 (combineInts (fun _ x -> 1 + x) [2] 0)
= 1 + (combineInts (fun _ x -> 1 + x) [2] 0)
= 1 + (length [2])
```

##### ...`combineInts` is actually called fold, fold_right (in OCaml)

**Exercise**
* define `fold_left`
* extend `combineIntsLeft` to work with []
* type should be polymorphic
* should be able to define length (and length should work on any list)

**Question**
* which of `map`, `filter`, and `fold_right` is the best?
 * which is any more powerful than the others?

#### define `map` and `filter` using List.fold_right

```ocaml
let map f l = List.fold_right (fun hd map_f_tl -> f hd :: map_f_tl) l [];;
(*exercise: create filter*)
```

## Data Types

User defined data types give us a way to define our own abstractions: a type with associated operations

* float `1.0;;`
* unary minus `-.1.0` -> `float = -1.`

What kinds of usr-defined data types in other languages?
* class / object
* C: struct, union, enum

Ocaml has these kinds of things, but they are specialized for: 
* pattern matching
* immutability

#### Enum in OCaml
```ocaml
type sign = Pos | Neg | Zero;;
(* defines a new tupe "sign", three values that have type "sign"
   Note:
   - type names must start with lower case letter
   - pos/neg/zero are called the constructors of sign
   - constructor names must start with an upper case letter
*)

let signToInt s = 
	match s with
		Pos  -> 1
	  | Neg  -> -1
	  | Zero -> 0
;;
```

#### Types like structs in C

```ocaml
type point = Point of (float * float);;
(* syntax: <constructor_name> of <type> *)
(* point is not a value, the types "point" and (float * float) 
   example: negate (both components of) a point *)

let negate p = 
	match p with
		Point(x, y) -> Pint (-.x, -.y)
;;

let negate (Point(x,y)) = Point(-.x, -.y);;

type point2 = float * float;;
```

**Note**: it's good that OCaml doesn't have any null pointers / references

```ocaml
type nullableInt = Null | NonNull of int;;
(* combines the ideas of two previous examples:
   - 2 ways of constructing a nullableInt
   - we have associated data/fields. *)

 let incNullableInt x = 
 	match x with
 		Null      -> Null 
 	  | NonNull i -> NonNull (i + 1);;

 let incNullableInt (NonNull x) = NonNull (x+1);;
```

* type checker checks that we consider both cases, Null and NonNull
* can't reuse constructor names for multiple types:
 * type nullableString = Null | NonNull of string
* now Null : nullableString, old defn is gone

```ocaml
type 'a nullable = Null | NonNull of 'a;;

let updNullable f n = 
	match n with
		Null -> Null
	  | NonNull x -> NonNull (f x)
;;
```

* nullable is widely used in fp
 * in Ocaml:
  * nullable is called option
  * null is called none
  * NonNull is called some

```ocaml
(*define a function get that returns the nth element of a list*)
let rec get n l =
	match n with
		0 -> {
			match l with
				[] -> None
		  	  | h::t -> h
		  }
	  | _ -> {
	  		match l with
	  			[] -> None
	  		  | h::t -> get (n-1) t
	}
;;

(*let's clean this up*)
let rec get n l = 
	match (n, l) with
		(0, h::_) -> h
	  | (_, _::t) -> get (n-1) t
	  | (_, [])   -> None
;;
```