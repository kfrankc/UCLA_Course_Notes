# CS 131: Programming Languages: Week 8 Wednesday 05/18/2016

### What is the highest language?

Logic.

You program not by programming, but you program by specifying what you want, and you let the system go and find it for you.

Logic, unlike english, is unambiguous. Logic is a reasonable choice for a higher-level language that is still unambiguous

### Prolog

```prolog
/* GNU Prolog */

/* a set of facts about the CS department courses */

/* lowercase identifiers (cs31, cs32) are *atoms* 
   - like the Data values in MOCaml
   	- Leaf
   an atom is a kind of *term*

   - prereq is an atom that's used as a *predicate*
   	- an uninterpreted function that takes 0 or more terms as arguments and returns a boolean
*/
prereq(cs31, cs32).
prereq(cs32, cs33).
prereq(cs31, cs35L).
prereq(cs32, cs111).
prereq(cs33, cs111).
prereq(cs35L, cs111).
prereq(cs32, cs118).
prereq(cs33, cs118).
prereq(cs35L, cs118).
prereq(cs32, cs131).
prereq(cs33, cs131).
prereq(cs35L, cs131).
prereq(cs32, cs132).
prereq(cs33, cs132).
prereq(cs181, cs132).

/* Rules allow you to derive new facts */

/* X is a prereq of a prereq of Y */
prereq2(X, Y) :- prereq(X, Z), prereq(Z, Y).

/* X is required before you can take Y */
prereqTransitive(X, Y) :- prereq(X, Y).
prereqTransitive(X, Y) :- 
	prereqTransitive(X, Z), prereq(Z, Y).

/* So far we've seen two kinds of terms:
	- atoms (lowercase identifiers)
	- variables (uppercase identifiers) 
	- uninterpreted functions:
		atom(term1, term2, ... , termN)
	like Node(Leaf, 1, Leaf) */
```

### Queries in Prolog

```prolog
| ? - prereq(cs31, X), prereq(X, cs131).
/* find me an X that is a prereq for cs131, and postreq for cs31 */

| ? - prereq(X, cs111), prereq(X, cs118).
/* find me an X that is a prereq for both cs111 and cs118 */

| ? - prereq(X, Y), prereq(X, Z), Y \= Z.

| ? - prereq(X, Z), prereq(Z, Y).
/* prereq of prereq of Y */
```

Derive new facts from old facts

```prolog
prereq2(X, Y) :- prereq(X, Z), prereq(Z, Y).
```

### More about Prolog

Append in OCaml

```ocaml
let rec append l1 l2 =
	match l1 with
		[] -> l2
	  | h::t -> h::(append t l2)
```

Append in Prolog

```prolog
app([], L2, L2).
app(.(H,T), L2, .(H,L)) :- app(T, L2, L).
```

In Prolog, the . function symbol plays the role of :: in OCaml

the list [1, 2, 3] is really just this term:

`.(1, .(2, .(3, [])))`

```ocaml
let rec contains x l =
	match l with
		[] -> false
	  | h::t -> x=h || contains x t
```

```prolog
contains(X, .(X,T)).
contains(X, .(H,T) :- contains(X, T)).
```

Reversing a List:

```ocaml
let rec reverse l = 
	match l with
		[] -> []
	  | h::t -> (reverse t)@[h]
```

```prolog
rev([],[]).
rev(.(H,T), L) :- rev(T, L0), app(L0, [H], L).
```

### Constraint Solving

Declare your constraints, and the system will search a solution for you. Logic puzzles are good for this kind of stuff.

#### wolf, goat, cabbage problem

trying to get from west bank o the east bank of the river, with the following constraints.

1. your boat only fits one item at a time
2. you can't leave the wolf and goat alone together.
3. you can't leave the goat and cabbage alone together.

IDEA: keep a list of four things:

`[person, wolf,  goat,  cabbage]`

initial state: `[west, west, west, west]`

goal state: `[east, east, east, east]`

legal moves: person, wolf, goat, cabbage

```prolog
opposite(west, east).
opposite(east, west).

move([P, W, G, C], person, [Q, W, G, C]) :- 
	opposite(P, Q).
move([P, W, G, C], wolf, [Q, Q, G, C]) :- 
	P=W, opposite(G, C), opposite(P, Q).
move([P, W, G, C], goat, [Q, W, Q, C]) :- 
	P=G, opposite(P, Q).
move([P, W, G, C], cabbage, [Q, W, G, C]) :- 
	P=C, opposite(W, G), opposite(P, Q).

puzzle(End, End, []).
puzzle(Start, End, .(Moves, Moves)) :-
	move(Start, M, S), puzzle(S, End, Moves).
```



