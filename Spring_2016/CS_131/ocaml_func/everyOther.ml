let rec everyOther = 
	function lst ->
		match lst with
			[] -> []
		  | [h] -> [h]
		  | h1::_::t -> h1::everyOther(t);;