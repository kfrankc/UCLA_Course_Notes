let rec sumLst =
	function lst ->
		match lst with
			[]   -> 0
		  | h::t -> h + sumLst t;;