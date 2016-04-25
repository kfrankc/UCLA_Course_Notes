# CS 131: Week 3 Discussion

### Homework 1

A much more comprehensive solution for `setify`:
```ocaml
let (setify : 'a list -> 'a list) =
	fun l -> union l []
```

Same for the function `pow`:
```ocaml
let rec (pow : int -> ('a -> 'a) -> ('a -> 'a)) =
	fun n f x -> if n = 0 then x else pow (n-1) f (f x)
;;
```

### Tail Recursion

```ocaml
(* non tail recursive version *)
f (pow 2 f x)
f (pow 1 f x)
f (pow 0 f x)
(* f is waiting at each iteration *)

(* tail recursive version *)
f (f (f pow 2 f x))
```

### Homework 2

```ocaml
type 'a tree = Node of 'a tree * 'a * 'a tree;;

(*the following exp gives error: the type abbreviation of tree is cyclic*)
type 'a tree = 'a tree * 'a * 'a tree;; 

let rec i = Node(i, 0, )
```

Exercise: implement List.map using List.fold_left
```ocaml
let map (f : 'a -> 'b) (l : 'a list)=
	fun f l ->
		List.fold_left (fun acc e -> acc::(f e)) [] l
;;

(*TA's implementation*)
let map (f : 'a -> 'b) (l : 'a list) =
	List.fold_left (fun v e -> (f e)::v) [] (List.rev l)
;;
(*if reverse once, is it tail recursive*)

let map (f : 'a -> 'b) (l : 'a list) =
	List.fold_left (fun v e -> v@(f e)) [] l
;;
```

### Polymorphic Functions

* functions hwich can accept arguments of different (any) types
* the type signature of the function has one or more type variable (like 'a), for the arguments
* the type of return type is usually dependent on the argument type or is fixed.
* can return type be polymorphic, with the argument type is fixed?
	- no, it would violate strong typing, so you will have a run time error
	- `raise exn -> 'a` which is run-time exception anyway

#### Identifying Polymorphic Functions

```ocaml
let f x = x + 1
(*
 * x: int
 * f: int -> int
 * Not polymorphic
 *)

let f x = 1
(*
 * x: 'a (anything)
 * f: 'a -> int
 * Polymorphic
 *)

let f x y = x
(* 
 + x: 'a (anything)
 + y: 'b (anything)
 + f: 'a -> 'b -> 'a
 + Polymorphic
*)

let f (x,y) = x +. y
(*
 * x: float
 * y: float
 * f: (float * float) -> float
 * Not Polymorphic
 *) 

let f x = match x with [] -> 0 | _::t -> 1 + (f t)
(* 
 * x: 'a list
 * f: 'a list -> int
 * Polymorphic
 *)
```