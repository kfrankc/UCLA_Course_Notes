# CS 131: Week 4 Discussion

## Exceptions

* `exception` keyword is used to create new exceptions
* `exception <NAME> of <PARAM>` PARAM can be a tuple
* No polymorphism in `PARAM`
* `raise` has signature `exn -> 'a`
	- matches any type, for exception raising functions to be correctly type-checked
	- still doesn't break strong-typing because exceptions halt execution anyway
* Exception catching syntax:

```ocaml
try
	dirty_code
with
	Exception_1 -> Handle_1
  | Exception_2 -> Handle_2
  ...
  | Exception_N -> Handle_N
```

* higher order library functions exit earlier on raising an exception within the argument function
	- could be used to terminate `fold_left`, `map` etc earlier
* OCaml has a built-in Exception: `Exit` which you can use. No library functions throw exit.

## Sample Practice Problems

### Lists

```ocaml
(* product of a list using fold, exiting early on a zero *)
let productf (l :int list) :int =
	try
		List.fold_left (fun p x -> if x = 0 then raise Exit else p * x) 1 l
	with Exit -> 0
;;

(* product of a list using recursion, inefficient *)
let rec product1 (l :int list) :int =
	match l with
		[] -> 1
	  | 0::_ -> 0
	  | h::t -> h * (product1 t)
;;

(* product of a list using recursion, efficient *)
let product4 (l :int list) :int =
	let rec product4h (r :int list) :int =
		match r with 
			[] -> 1
		  | 0::_ -> raise Exit
		  | h::t -> h * (product4h t)
	in try product4h l with Exit -> 0
;;
```

### Sets

```ocaml
(* a comparator module for ordering *)
module type Comparator =
	sig
		type e
		val lte: e -> e -> bool
end
;;

(* a comparator module for ordering integers *)
module IntComparator : (Comparator with type e = int) =
	struct
		type e = int
		let lte x y = (x <= y)
end
;;

(* a Comparator module for ordering strings *)
module StringComparator : (Comparator with type e = string) =
	struct
		type e = string
		let lte x y = (x <= y)
		let gte x y = (x <= y)
end
;;

(* an abstract SET module *)
module type SET =
	functor (C :Comparator) ->
		sig
			type set
			val emptyset: unit -> set
			val contains: set -> C.e -> bool
			val add: set -> C.e -> set
			val to_list: set -> C.e list
end
;;

(* An unordered set module *)
module UnorderedSet :SET =
	functor (C :Comparator) ->
		struct
			type set = Empty | NonEmpty of (C.e * set)

			let emptyset() = Empty

			let rec contains s e =
				match s with
					Empty -> false
				  | NonEmpty(x, t) -> if C.lte x e && C.lte e x then true else contains t e

			let add s e =
				if contains s e then s else NonEmpty(e, s)

			let rec to_list s =
				match s with
					Empty -> []
				  | NonEmpty(x, t) -> x::(to_list t)
end
;;


```

