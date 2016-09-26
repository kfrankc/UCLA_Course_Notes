# CS 131: Week 1 Discussion

### Time Complexity
```ocaml
(*cons takes linear time*)

(*function append*)
let rec append(l1: 'a list)(l2: 'a list) 'a list

let rec append l1 l2 = 
    match l1 with 
        [] -> l2
      | h::t -> h::(append t l2);;
```

### OCaml Syntax

Demystifying `List` syntax ... `::`, `;`, `[]`:
* `[1::2]::[[3; 4]]` not valid because `[1::2]` is nothing

Append (@) examples
* `[1; 2] @ [3; 4]` = `[1; 2; 3; 4]`

### Pattern Matching
* `h;t` is invalid syntax
* `[h;t]` matches 2 element list ONLY
* `[h::t]` matches a list of lists, which at least one element in outer list
* `h::t` matches a list with at least one element
* `h@t` is invalid syntax
* `_` matches anything
* `_::t` matches the top-most 
* `h::m::t` h and m are first two elements, t is the rest
* `(x,y)::t` first element matched to tuple directly

### The `List` object
* `List.mem 10 [1;2];;`

### Problem Sets
```ocaml
(*check if a list l contains an element e*)
let rec contains (e :'a) (l :'a list) : bool =
    match l with
        []    -> false
      | x::xs -> if x = e then true else contains e xs
;;

(*return second element in a list*)
let rec everyThird (l :'a list) :'a list =
    match l with
        []    -> []
      | [_]   -> []
      | [_;_] -> []
      | _::sec::third::rest -> third::(everySecond rest)

(*delte all occurances of an element from a list, if it exists*)
let rec deleteElement (l :'a list) (e :'a) :'a list =
    match l with
        [] -> []
      | x::xs when x = e -> deleteElement xs e
      | x::xs -> x::(deleteElement xs e);;

(*check if l1 is a prefix of l2*)
let rec prefixOf (l1 :'a list) (l2 :'a list) :bool =
    match l1 with
        [] -> true
      | x::xs -> match l2 with
                [] -> false
              | y::ys -> if x = y then prefixOf xs ys else false 
;;

(*check if a list contains all elements of another list*)
let rec containsList (l1 :'a list) (l2: 'a list) :bool=
    match l1 with
        [] -> true
      | y::ys -> (containsList y l2) && (containsList ys l2)
;;

(*convert a list to indexed tuples*)
let indexedList (l :'a list) :(int * 'a) list =
    let rec aux idx = function
        []    -> []
      | x::xs -> (idx, x) :: ( aux (idx + 1) xs )
    in (aux 1) l
;;

(*return second element of every tuple*)
let rec secondGet (pl :('a X 'b) list) :'b list =
    match pl with
        [] -> []
      | (_,y)::tail -> y::(secondGet tail)
;;

(*return a range of integers in steps*)
let rec range (from :int) (till :int) (step :int) :int list = 
    if from > till && step > 0 then []
    else if from < till && step < 0 then []
    else from::(range (from+step) till step);;

(*n-th Fibonacci number*)
let rec fib (n :int) :int =
    if n < 2 then n else (fib (n-1)) + (fib (n-2));;

(*tail-recursive for fib function*)
let fib2 (n :int) : int =
    let rec fib2_helper (k :int) (fk_1 :int) (fk :int) : int =
        if n < k then fk_1
        else if n = k then fk
        else fib2_helper (k + 1) fk (fk_1 + fk)
    in fib2_helper 1 0 1
;;
```

