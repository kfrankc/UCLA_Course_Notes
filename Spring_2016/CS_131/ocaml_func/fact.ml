let rec fact =
	function n->
		match n with
			0 -> 1
		  | _ -> n*fact(n-1)