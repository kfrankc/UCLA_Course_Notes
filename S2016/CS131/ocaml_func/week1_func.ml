let rec everyOther = 
	function lst ->
		match lst with
			[] -> []
		  | [h] -> [h]
		  | h1::_::t -> h1::everyOther(t)
;;

let rec fact =
	function n->
		match n with
			0 -> 1
		  | _ -> n*fact(n-1)
;;

let rec isEven =
	(function n ->
		match n with
			0 -> true
		  | 1 -> false
		  | _ -> when n>0 -> isEven(n-2)
		  | _ -> isEven(n+2)
	)
;;

let rec sumLst =
	function lst ->
		match lst with
			[]   -> 0
		  | h::t -> h + sumLst t
;;

let rec unzip =
	(function lst ->
		match lst with
			[] -> ([], [])
		  | (h1,h2)::t ->
		  		let (l1, l2) = unzip t in
		  			(h1::l1, h2::l2)
	)
;;