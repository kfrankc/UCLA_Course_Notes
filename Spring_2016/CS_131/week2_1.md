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





