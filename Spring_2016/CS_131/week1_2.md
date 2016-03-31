# CS 131: Programming Languages: Week 1 Wednesday 03/30/2016

## More OCaml

#### Software for Ocaml

##### `utop` download instructions
1. `brew install ocaml`
2. `brew install opam`
3. `opam install utop`

#### Local Variables
* `let X = E1 in E2`
```ocaml
let quad = function n ->
                let d = double n
                    in d + d;;
(*for creating more local variables:*)
let x = 3 in
    let y = 4 in
        x + y;;
```

#### Tuples vs. List
* Tuples: bounded data structure
    - you can have different types of variables in your tuple
* Lists: unbounded data structure
    - when we don't know how big our list is, we can't keep track
    - therefore, the type **HAS** to be the same

#### More about _void_ functions
* because we don't have mutations, we don't need a function that doesn't return anything

#### Quick Test of Knowledge
```ocaml
(* ex. zip([1;2;3], [4,5,6]) returns [(1,4);(2,5);(3,6)] *)
let rec zip = 
    (function (l1, l2) -> 
                match (l1, l2) with
                    ([],[]) -> []
                  | (h1::t1, h2::t2) -> (h1,h2)::zip(t1,t2))
(*you can use this as a script by doing the following:
  #use "test.ml", where test.ml is a file you save this in*)

let rec unzip =
    (function lst ->
            match lst with
                [] -> ([],[]) 
              | (h1,h2)::t ->
                    match unzip t with
                        (l1, l2) -> (h1::l1, h2::l2))

let rec unzip =
    (function lst ->
            match lst with
                [] -> ([],[]) 
              | (h1,h2)::t ->
                    let (l1, l2) = unzip t in
                        (h1::l1, h2::l2))
```

#### More about functions
```ocaml
let twice = 
    function (f,x) -> f(f,x);;

twice((function x -> x*x), 3);;
(*we can also do twice twice :P more to come later*)

let compose = function(f,g,x) -> g(f(x));;

(*takes empty tuple, then returns the add function*)
let returnsAdd () = 
    let add = function (x,y) -> x + y
    in add;;

(*the following all do the same thing*)
let g = returnsAdd();; g(3,4);;
(returnsAdd()) (3,4);;
returnsAdd () (3,4);; 
```

#### The benefits of defining a function within another
```ocaml
let add = 
    function x -> 
        (function y -> x + y)

(*instead of doing add (3,4), you can do:*)
add 3 4
let addToThree = add 3;;
addToThree 4
- : int = 7

List.map;;
- : ('a -> 'b) -> 'a list -> 'b list = <fun>
List.map (function x -> x+1) [1;2;3];;
List.map (function x -> x>2) [1;2;3];;
let incLst = List.map(function x -> x+1);; (*trivially parallelizable*)
```