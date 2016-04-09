# CS 131: Week 2 Discussion

## Constructors

```ocaml
match k with K(_, _, k3, _) -> k3;;
- : int = 3

let top_left (m : fibmat) : int = match m with (k1,_,_,_) -> k1;;
top_left [1, 2, 3, 4];;

let top_left ((k1, _, _, _) : fibmat) : int = k1;;
(*tuples are fixed length, so you can pattern match like this*)
```

#### Multiplications for `fibmat`

```ocaml

(*matrix multiplcation*)
(*
| a1 b1 |	| a2 b2 |
|       | * |       |
| c1 d1 |   | c2 d2 |
*)

let mmult ((tl1, tr1, bl1, br1): fibmat) ((tl2, tr2, bl2, br2 ) : fibmat) : fibmat = 
((tl1 * tl2 + tr1 * bl2), (tl1 * tr2 + tr1 * br2), (bl1 * tl2 + br1 * bl2), (bl1 * tr2 + br1 * br2));;

```

#### Exponents for `fibmat`
```ocaml
let rec mexp (m : fibmat) (n : int) : fibmat = if n = 0 then (1, 0, 0, 1) else if (n mod 2 = 1) then (mmult m (mexp m (n-1))) else (msg (mexp m (n / 2)));;

(*type for big numbers*)
Big_int;;
```

#### `fold_left` and `fold_right`
```ocaml
List.fold_left;;
- : ('a -> 'b -> 'a') -> 'a -> 'b list -> 'a = <fun>

List.fold_right;;
- : ('a -> 'b -> 'b) -> 'a list -> 'b -> 'b = <fun>

(*Operate the same as List.map, fold_right or fold_left gives something of type 'a*)

let rec map (f : 'a -> 'b) (l : 'a list) : 'b list = 
	let helper (acc : 'b list) (t : 'a list) = 
		match t with 
			[] -> cc 
		  | hh::tt -> helper ((f hh)::acc) tt 
	in helper [] l
;;

let rec rev (l : 'a list) : 'a list =
	let rec helper (acc : 'a list) (t : 'a list) = 
		match t with 
			[] -> acc 
		  | hh::tt -> helper (hh::acc) tt 
  	in helper [] l
 ;;

let map f l = rev (revmap f l);;

List.fold_right (-) [1; 2; 3; 4] 0
- : int = -2 

(*tail recursive due to acc*)
let rec range i j acc = if i = j then i::acc else range ((i + 1) j (1::acc));;

let huge = range 1 100000000 [] ; ();;
```

#### Peano Numbers
* `0 = 0`
* `1 = 00`
* `2 = 000`
* any peano number P is either 0 or successor of some other peano number: `P = 0 | S(P)`

```ocaml
type peano = Zero | Succ(peano)

let rec peanoToInt (p : peano) : int = match p with Zero > 0 | Succ(p2) -> 1 + peanoToInt(p2);;

let rec intToPeano (i : int) : peano = if i = 0 then Zero else Succ(intToPeano (i - 1));;

let rec addPeano (p1 : peano) (p2 : peano) : peano = match p1 with Zero -> p2 | Succ(p3) -> Succ(addPeano p3 p2);;
```
