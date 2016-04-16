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