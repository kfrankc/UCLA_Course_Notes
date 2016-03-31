let rec isEven =
	(function n ->
		match n with
			0 -> true
		  | 1 -> false
		  | _ -> when n>0 -> isEven(n-2)
		  | _ -> isEven(n+2)
	);;