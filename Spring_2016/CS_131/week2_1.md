# CS 131: Programming Languages: Week 2 Monday 04/04/2016

## First Class & High Order Functions
* Guest Instructor: Matt
* goal of today: wrestle with functional programming so we don't struggle with it on the job

### First Class Functions
* def: anything you can do with regular data/obj/values, you can do with functions.
* ex. passing function to another function
* when a function takes another function as input, the receiving function is called a **higher-order function**.
* ex. print out every item in a list

```ocaml
(*top-level declarations are rare in production OCaml code*)
let things = [1; 2; 3; 5];;
```

* Given a pair-tuple, add 1 to the first component of the pair:

```ocaml
let incFirst pair = 
	match pair with
		() -> ()
	  | (x, y) -> (x+1m y);;
(*could we have used _? We need to be able to name the second element though, rather than just ignore it, so we need to name it*)
```

### String Concatenation
* Now, let's assume that the first element of the tuple is a string, we want to add exclamation to the end of it. 
* To do this, we need to know the string concatenation operator:

```ocaml
"Hello" ^ "!";;

let exclaimFirst = 
	fun (p : string * 'a) ->
		(*still a pair!*)
		match p with
			(x, y) -> (x ^ "!", y);;
```

It is string only, which we can see by putting parentheses around it:
```ocaml
(^);;
- : bytes -> bytes -> bytes = <fun>
```

Sometimes seen as:
```ocaml
(^);;
- : string -> string -> string = <fun>
```

Now, here's a function that takes:
* a function
* a pair

And outputs:
* apply the function to the first component

Example:
```ocaml
applyToFirst (fun x -> x + 1) (1, "test");;

applyToFirst (fun x -> x + 1) p;;

(*same as the following:*)

incFirst p;;
```

**NOTE**: Declaring function via `fun` is recommended because:
* avoid multi-parameter errors
* we can explicitly annotate the function type

Always using `let rec` is fine too.

Two versions:

```ocaml
let applyToFirst =
	fun func pair -> 
		match pair with
			(first, second) -> (func first, second);;

let applyToFirst = fun f (a, b) -> (f a, b);;
```

Notice that the type inferences enforces that first argument to be something that the passed-in function can take, and vice versa:
```ocaml
val applyToFirst : ('a -> 'b) -> 'a * 'c -> 'b * 'c = <fun>
```

How about this? (it's weird)
```ocaml
(String.length);;
- : bytes -> int = <fun>
```

When we give this to our function, we're going to check the length of the first element, which must be a string, then return that length and the second element (which is anything):
```ocaml
applyToFirst (String.length);;
- : bytes * '_a -> int * '_a = <fun>
```

### Check Type of a Function

* We can check the type of any function the same way we would with any data
* We refer to the type by name, and parser will output the value and type

```ocaml
(+);;
- : int -> int -> int = <fun>

(/.);;
- : float -> float -> float = <fun>
```

* We are simply asking for the function's value; it is a first-class part of the language!
* Infix operators are prefix functions too:

```ocaml
applyToFirst (+) (1, 2);;
- : (int -> int) * int = (<fun>, 2)
```

* But note that the parentheses are needed to disambiguate trying to use the operator:

```ocaml
applyToFirst + (1, 2);;
Error: This expression has type ('a -> 'b) -> 'a * 'c -> 'b * 'c BUT an expression was expected of type int
```

How about implementing incList, adding 1 to the element of each list? We could use List.map (a higher-order function), or we could do the following:

```ocaml
let rec incList = 
	fun fun lst ->
		match lst with
			[] -> []
		  | h::t -> (func lst) :: (incList func t);;
		  (*don't forget to pass in the function again*)
```

### THe Map Function

* In fact, this is really `map` (for list), sometimes called `apply`!

```ocaml
let rec my_map = 
	fun func lst -> 
		match lst with
			[] -> []
		  | h::t -> (func h) :: (my_map func t);;
```

Note that `map` is built-in to the `List` map module.

How about incrementing everything with a list of lists:

```ocaml
(*here, parens needed to mark the function as a single argument*)
(*currying order: we return a function that adds 1 to each member of a list*)
(*then we map each member of our second argument (a list) through that returned function*)
map (map (function x -> x + 1)) [[1; 2; 3; 4]; [3; 5; 6]]
```

* Think of "map" as "apply to all", a function that applies a function to each element in a list. It is extensible to other data types as well

### Removing Negatives

* we want to remove negatives from a list of ints.

#### Comparing Functions

* Can we compare functions?
* No, because to check that would be to guarantee that all possible inputs produce the same outputs between the two functions.

```ocaml
(function x -> x) = (function x -> x);;
Exception: Invalid_argument: "equal: functional value".
```

##### If-then-else Types

Note that OCaml enforces that the `then-case` aand the `else-case` have the same type:

```ocaml
if true then thisIsSameAsMap else List.map;;
```

##### Example: `removeNegatives` and `removeEmpties`

Another example, removing negatives from a list. Don't forget to mark this as recursive!

```ocaml
let rec removeNegatives = 
	fun (lst : 'a list -> 'a list) ->
		match lst with
			[] -> []
		  | h::t -> if h > 0 then
		  		h :: removeNegatives tail
		  	else
		  		removeNegatives tail;;
```

To avoid repetition:

```ocaml
(*Good style to use a local variable*)
let rec removeNegatives =
	fun (lst : 'a list -> 'a list) ->
		match lst with
			[] -> []
		  | h::t -> 
		  	let t' = removeNegatives t in
		  		if h > 0 then
		  			h :: removeNegatives t'
		  		else
		  			removeNegatives t';;
```

How about taking out empty strings from a list of strings? Let's check if the length of the element we're on is 0. But we can do this faster below:

### The Filter Function

* Take a predicate (a boolean function that is true for inputs that meet some condition) and a list, and return the elements in the list which meet the condition:

```ocaml
let rec filter = fun pred lst ->
	match lst with
		[] -> []
	  | h::t -> 
	  	let t' = filter pred t in
	  		if (pred h) then
	  			h :: t'
	  		else 
	  			t';;
```

Example invocation:

```ocaml
let removeEmpties = filter (fun x -> String.length > 0) ["hey"; ""; "h"];;
```

Same as invoking it directly:

```ocaml
filter (fun x -> String.length x > 0) ["hey"; ""; "h"];;'
- : bytes list = ["hey'; "h"]
```

### The Collect Function

How can we get a sum of lists' items? We can't mutate a cumulative sum like we would in imperative/OO languages.

**SIMPLE**: we use the recursive idea of adding on to previous results.

```ocaml
let rec sum = fun lst ->
	match lst with
		[] -> 0
	  | [a] -> a (*singleton case: just return that element*)
	  | h::t -> h + sum t;;
```

```ocaml
let rec sum = fun lst ->
	match lst with
	| [] -> 0
	| [a] -> a
	| h::t -> h + sum t;;
```

Let's define a function that takes a binary option on `ints`:

Inputs:
* `(int -> int -> int)`
* `int list`

Outputs:
* Combined `int`

So: 
```ocaml
combineInts (+);; (*same as 'sum'*)
combineInts (*);; (*same as 'prod'*)
```

The prod would just be:
```ocaml
let rec prod = fun lst ->
	match lst with
	| [] -> 0
	| [a] -> a
	| h::t -> h * prod t;;
```

And compare with:
```ocaml
let rec sum = fun lst ->
	match lst with
	| [] -> 0
	| [a] -> a
	| h::t -> h + sum t;;
```

This naturally suggests another higher-order function:
```ocaml
let rec combineInts = 
	fun (f : int -> int -> int) (l : int list) ->
		match l with
		| [] -> 0
		| [a] -> a
		| h::t -> f h (combineInts f t);;
```

To invoke, we need space around `*`, or else it'll be seen as part of a comment:
```ocaml
combineInts (+) [1; 2; 3];;
combineInts (*) [1; 2; 3];;
```

Error case:
```ocaml
combineInts (*) [1; 3; 5];;
Characters 14-16:	Warning 2: this is not the end of a comment.
```

### Decomposing Recursions
What happens when we use subtraction?
```ocaml
combineInts (-) [1; 2; 3];;
- : int = 2
````

What does this translate to?
```ocaml
(*decompose the recursion, use Camlback!*)
= (-) 1 (combineInts (-) [2; 3])

(*rewrite prefix notation to be more intuitive*)
= 1 - (combineInts (-2) [2; 3])

= 1 - ((-) 2 (combineInts (-) [3]))
= 1 - (2 - (combineInts (-) [3]))

= 1 - (2 - 3)
= 1 - (-1)
= 2
```

What if we instead want a left-associated set of calls, getting us a running subtraction?

```ocaml
combineIntLeft (-) [1; 2; 3]
= (1 - 2) - 3
```

Note that we may not want to give `0` for the empty case to avoid giving output where we expect non-empty lists. Probably better to not give output for the empty list, as that's more flexible for someone else to use as they will.

```ocaml
let rec combineIntsLeft = fun f l ->
	match l with
	| [x] -> x
	| h1::h2::t -> combineIntsLeft f (f h1 h2 :: t);;
	(*translate from prefix to infix to see how this gives us (first arg - second arg - third arg*)
```







