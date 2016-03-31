let rec unzip =
	(function lst ->
		match lst with
			[] -> ([], [])
		  | (h1,h2)::t ->
		  		let (l1, l2) = unzip t in
		  			(h1::l1, h2::l2)
	);;