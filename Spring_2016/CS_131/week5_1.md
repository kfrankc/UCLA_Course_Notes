# CS 131: Programming Languages: Week 5 Monday 04/25/2016

## Tail Recursion

```ocaml
let rec fact n =
    match n with
        0 -> 1
      | _ -> n * fact(n-1)
;;
```

What if you call `(fact 3)`?

You will have some environment, like following:
```ocaml
(*
(fact 3)                        ==> 6
    [(n, 3)]
    n * fact(n-1)               ==> 6
        [(n, 2)]    
        n * factor(n-1)         ==> 2
            [(n,1)]
            n * fact(n-1)       ==> 1
                [(n, 0)]
*)
```

Factorial in C:
```c
int fact(int n) {
    int res = 1;
    while (n > 0) {
        res *= n;
        n--;
    }
    return res;
}
```

Implement the above in OCaml (this is tail recursion):
```ocaml
let fact n =
    let rec helper n res =
        match n with
            0 -> res
          | _ -> helper (n-1) (res * n)
    in helper n 1
;;
```
Trace this:
```ocaml
(*
(fact 3)                ==> 6
    helper 3 1
    [(n,3);(res,1)]     ==> 6
    helper 2 3
    [(n,2);(res,3)]     ==> 6
    helper 1 6
    [(n,1);(res,6)]     ==> 6
    helper 0 6
    [(n,1);(res,6)]     ==> 6
*)
```

The stack will not grow, but just stay the same.

This guarantees that you are getting constant space allocation

## Tail Call Optimization

A **tail call** is a function call that is the last operation done dynamically inside some function body.

A function is **tail recursive** if it has a tail call.

If your function is tail recursive, it means that you have constant stack space. Saves time and space.

More examples:

```ocaml
let rec sumLst l =
    match l with
        [] -> 0
      | h::t -> h + sumLst t
;;
```
The above version is **not** tail recursive.

Make it tail recursive:
```ocaml
let sumLstTR l =
    let rec helper lst acc =
        match lst with
            [] -> acc
          | h::t -> helper t (h+acc)
    in helper l 0
;;
```

## `fold_left` and `fold_right`

```ocaml
let rec fold_right f l b =
    match l with
        [] -> b
      | h::t -> f h (fold_right f t b)
```
Fold right is **not** tail recursive, you have to recursively call fold_right and wait for an answer in the recursive case

Fold left is naturally tail recursive:

```ocaml
let foldTR f l b =
    let rec helper lst acc =
        match lst with
            [] -> acc
          | h::t -> helper t (f acc h)
    in helper l b
;;

let foldTR2 f l b =
    match l with
        [] -> b
      | h::t -> foldTR2 f t (f b h)
;;
```

## Extra: Continuation Passing Style

In general, pass in extra argument that is a function (continuation) you want to be executed after you get the recursive result

## Midterm Topics

closed book, closed notes 

**OCaml/functional programming**

---

* recursion
* pattern matching
* higher order functions
    * matp, filter, fold_right/left
* exceptions
* data types
* modules, module types, structures

**Concepts**

---

* static vs. dynamic scoping
* static vs. dynamic typechecking
* strong vs. weak typechecking
* parametric polymorphism vs. static overloading

## Review

### Parametric Polymorphism

the type of a function includes one or more **type variables**

* the caller gets to choose what types to instantiate the type variables with
* allows more code to typecheck
    * one piece of code that can be passed arguments of all possible types

```ocaml
let id = (function x -> x)
val id: 'a -> 'a
```

(id 3) : int
(id false) : bool

Static Overloading:

many different functions that all have the same name
+ for ints, + for floats, + for string concatenation

3+4 (compiler figures out that you want + for integers)

"hi" + "bye" (compiler figures out that you want + for strings)

### Modules
* signature: tells you everything you need to know about the module

### Scoping

Static (or lexical) scoping:

* you can determine the variable declaration with each variable use at compile time
* every variable use is referring to the nearest lexically enclosing declaration of that variable

```ocaml
let x = 3 in
let y = 4 in
    y + (let x = 5 in x) + x

let f = (let x = 3 in function y -> y+x) in
let x = 0 in
f 2
```

### Strong vs. Weak Typechecking

* strongly typed means that a program **never** gets into an undefined state
    * either rejected at compile time
    * or get a run-time exception before something bad happens

* weakly typed means that a program can get into an undefined state
    * key issue: memory safety / memory errors
    * mostlanguages prevent memory errors