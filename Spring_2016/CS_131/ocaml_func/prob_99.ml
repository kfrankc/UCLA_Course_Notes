(* 
	nullable is called option
	null is called None
	NonNull is called Some
*)

(* returns last element of a list *)
let rec (last : 'a list -> 'a option) =
	fun l ->
		match l with
		[] -> None
	  | [h] -> Some x
	  | _::t -> last t
;;

(* find the last but one element of a list *)
let rec (last_two : 'a list -> 'a list) =
	fun l ->
		match l with
		[] -> None
	  | [h; t] -> Some (x, y)
	  | _::t last_two t
;;

(* find the kth element of a list *)
let rec (at : 'a -> 'a list -> 'a option) =
	fun k l ->
		match l with
		[] -> None
	  | 
;;
