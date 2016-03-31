let rec zip = 
	(function (l1, l2) ->
		match (l1, l2) with
			([],[]) -> []
		  | (h1::t1, h2::t2) -> (h1,h2)::zip(t1,t2));;