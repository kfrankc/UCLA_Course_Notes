# CS 131: Programming Languages: Week 9 Monday 05/23/2016

### Arithmetic in Prolog

Before, we had abstractions where order of evaluation was irrelevant. 
But arithmetic is not reversible in general. In fact, theory has found 
that *solving Diophantine equations is undecidable*: poly(x1, ..., xn) = 0. 
There's no way in principle to make that reversible. 

Solvable but intractable (not solvable in a practical amount of time): 

* Factoring large numbers 

Solvable efficiently: 

* Solving linear inequalities

Prolog punts on this by just implementing regular (non-reversible) arithmetic:

We can define terms like this: 

    X = 1+2*3.

Which is a shorthand: 

    X = +(1, *(2, 3)).

The equality is just doing pattern-matching. This is equivalent to: 

    X = foo(1, bar(2, 3)). 

In order to evaluate, use `is`: 

    X is 1 + 2 * 3

    X = 7 

    yes

Normal numeric comparisons exist: 

    3 < 4.

We can no longer freely intermix and search for solutions: 

    X < 4.

    exception: ...instantiation_error

We can have a side evaluate before we get a result: 

    4 < 4 * 5


#### Example: Temperature Converter

    temp(C, F) :- F is 1.8 * C + 32.0.

Because arithmetic is non-reversible, we can no longer use this predicate
both ways (unlike `select` could insert and remove, etc.). Which direction
does this go? Celsius to Fahrenheit. This rule takes a concrete value for C, 
then generates a value for F. If given a concrete value for F, it'll fail,
as it'll try a multiplication with C, some variable. 

To write F-to-C, we'd have to rewrite the formula. 

Because solving linear equations can be done efficiently, GNU Prolog 
does have a reversible version: 

    temp(C, F) :- F #= 1.8 * C + 32.0.

Except this doesn't work. 


#### Example: List Length 

Let's get a list's length. 

    /* Length of empty list is 0 */
    len([], 0).

    /* Non-empty list: suppose length of tail T is I2, 
     * then add 1 to that (the head) for length of list, which is I */
    len(.(H,T), I) :- len(T, I2), I is I2 + 1.

Use: 

    /* Search for binding of X that is correct */
    len([1, 2, 3], X).
    X = 3

This actually works to find a list of different lengths too. Pretty cool. 

But notice that we can't write `I2 is I - 1`. Because we don't know `I`
(we're trying to find it out), we'll crash. `I2` is known by the time we get
to it (because we recurse down to the base case of empty list (length 0)), 
then we add 1 to that we're back up to the original head and tail, returning
the overall length of the list. 

*When using arithmetic, keep in mind which variables will be bound when used*


### Prolog Practice 

#### Example: N-Queens Problem 

Queens attack each other in chess if they are in the same row, column, or
diagonal. We want to place N queens on an N x N chess board. Prolog can find placements for us. So to do this declaratively, we need to figure out how 
to represent each queen or board, then declare that they cannot be attacking, 
and say we want placements, etc. 

This is generalizable to boards arbitrary dimensions. 

    /* queen(R, C) is a row (1..8) and C is a column (1..8) */

    /* Could define as attacks or not-attacks */
    attacks(queen(R1, C1), queen(R2, C2)) :-
        C1=C2.

    /* Same spot is special case of these two rules */
    attacks(queen(R1, C1), queen(R2, C2)) :-
        R1=R2.

We could also write this as: 

    attacks(queen(R, _), queen(R, _)).
    attacks(queen(_, C), queen(_, C)).

So how do we check diagonal? Two things are in the same diagonal if
their slope is 1. Slope is delta Y / delta X. 

    attacks(queen(R1, C1), queen(R2, C2)) :-
        R1-R2 is C1-C2.

Issue: what if the slope is negative? We need to do absolute value. 

HOWEVER: `is` only evaluates the right-hand side. So rewrite as
and include the negated case:

    attacks(queen(R1, C1), queen(R2, C2)) :-
        RDiff is R1-R2, CDiff is C1-C2, 
        RDiff = CDiff.

    attacks(queen(R1, C1), queen(R2, C2)) :-
        RDiff is R2-R1, CDiff is C2-C1, 
        RDiff = CDiff

Now, let's write a checker ("Is this list a valid a solution?") and we get a
generator for free.

    /* Storage format: nqueens([queen(1,2), queen(4,5), ...]) */

    /* Empty set of queens is always a valid solution */
    nqueens([]).

    /* Non-empty set: check if tail is, then it's good so long as 
     * this queen Q is not attacking another of those queens. 
     * Lovely recursion! 
     */
    /* Check that no pair of queens attack each other */
    nqueens(.(Q, Qs) :- nqueens(Qs), noAttack(Q, Qs).

    /* Definine noAttack() base case then non-empty recursive case */
    noAttack(Q, []).
    noATtack(Q, .(Q1, QRest)) :- 
        /* \+ is negate. Q does not attack Q1. */
        noAttack(Q, QRest), \+(attacks(Q, Q1)).


##### N-Queens Overview

NOTE: watch our for singleton warnings below. That indicates an unused
variable. See Ch. 19/20 of the book. 

WARNING: we haven't bound the problem, so the below will loop infinitely. 

    /* queen(R, C) is a row (1..8) and C is a column (1..8) */

    /* Could define as attacks or not-attacks */
    attacks(queen(R1, C1), queen(R2, C2)) :-
        C1=C2.

    /* Same spot is special case of these two rules */
    attacks(queen(R1, C1), queen(R2, C2)) :-
        R1=R2.

    attacks(queen(R1, C1), queen(R2, C2)) :-
        RDiff is R1-R2, CDiff is C1-C2, 
        RDiff = CDiff.

    attacks(queen(R1, C1), queen(R2, C2)) :-
        RDiff is R2-R1, CDiff is C2-C1, 
        RDiff = CDiff

    /* Definine noAttack() base case then non-empty recursive case */
    noAttack(Q, []).

    /* \+ is negate. Q does not attack Q1. */
    noATtack(Q, .(Q1, QRest)) :- 
        noAttack(Q, QRest), \+(attacks(Q, Q1)).

    /* Storage format: nqueens([queen(1,2), queen(4,5), ...])
     * Empty set of queens is always a valid solution 
     */
    nqueens([]).

    /* Non-empty set: check if tail is, then it's good so long as 
     * this queen Q is not attacking another of those queens. 
     * Lovely recursion! 
     * Check that no pair of queens attack each other 
     */
    nqueens(.(Q, Qs) :- nqueens(Qs), noAttack(Q, Qs)).

How did we get a generator for free from the checker? Prolog will, 
under the hood, implement some search strategy. Because this search 
strategy is ultimately brute-force in one way or another, we 
need to bound the search space, as the above will loop infinitely: 

    nqueens(.(Q,Qs)) :- 
        nqueens(Qs),
        Q = queen(R,C),
        /* Every queen in rows/columns 1-8 */
        member(R, [1,2,3,4,5,6,7,8]), 
        member(C, [1,2,3,4,5,6,7,8]), 
        noAttack(Q,Qs).

We can ask for one of size 5:

    length(L, 5), nqueens(L)

It also did it for one of size 8. Faster: place one queen in each row
so that the solution comes back quickly. That exploits symmetry/structure
to avoid brute-force. 

    finall(C1, nqueens([queen(1, C1), queen(2, C2), ..., queen(8, C8)]))
    L = 92

In general: we approach problem-solving with Prolog by *writing down the rules of the problem*. Then it will search for a solution for us. 

NOTE: solutions listed may not be unique; it could be the same queen positions
listed in a different order. Prolog does a brute-force DFS over its search
space. The magic box that makes our rules all true is just a brute-force
search.


#### N-Queens Summary 

// Here's Millstein's clean version

    attacks(queen(R,_), queen(R,_)).

    attacks(queen(_,C), queen(_,C)).

    attacks(queen(R1,C1), queen(R2,C2)) :-
        RDiff is R1-R2, CDiff is C1-C2, 
        RDiff = CDiff.

    attacks(queen(R1,C1), queen(R2,C2)) :-
        RDiff is R2-R1, CDiff is C1-C2, 
        RDiff = CDiff.

    noAttack(_, []).
    noAttack(Q, .(Q1,QRest)) :- 
        noAttack(Q, QRest), \+(attacks(Q, Q1)).

    /* nqueens([queen(1,2), queen(4,5), ...]) */
    nqueens([]).

    nqueens(.(Q,Qs)) :- 
        nqueens(Qs),
        Q = queen(R,C),
        member(R, [1,2,3,4,5,6,7,8]), 
        member(C, [1,2,3,4,5,6,7,8]), 
        noAttack(Q,Qs).


### findall in Prolog 

Let's say we have some query with multiple solutions: 

    append(X, Y, [1, 2, 3])

Find X and Y that append together to give this list [1, 2, 3].
Then, to get all of them: 

    findall(ValueSelection, query, Solutions)

So: 

    findall(X, append(X, Y, [1, 2, 3]), Solutions). 

Will find all X's and put that into Solutions. Or to get the pair:

    findall([X, Y], append(X, Y, [1, 2, 3]), Solutions). 

This is useful for testing. Another: `setof`. If duplicates, will only give
one of each. For our Prolog homework, it'll show everything, which means we'll 
see duplicates. The results also come out in the order they appear. 


### Traveling Salesperson Problem 

UC President Janet Napolitano is visiting all of the campuses. 

We first ahve the distances between the UC schools: 

    dist(ucla, ucsd, 124).
    ...
    dist(ucsb, ucb, 323).

Now, she'd like to visit all of these schools in a minimum-cost tour, 
where she starts somewhere, visits all of them, and returns to her
starting location, all at the minimum cost, meaning she minimizes the 
mileage of the trip. 

This is an NP-complete problem. There are heuristics, but we haven't found 
a polynomial-time solution. We have at best some improved exponential-time 
search. 

#### nth Predicate

    nth(index, list, solutionVariable)

    nth(4, [1, 2, 3], E)


#### Shorthands for List Patterns

Head and tail: 

    .(H, T)
    [H|T]

Match a list of two or more items: 

    [H1, H2| T]


#### sumDistances and symmetricDist

Let's compute the distance traveled by the tour: 

    /* Distance btween campuses */
    sumDistances([C1, C2], Length) :- 
        dist(C1, C2, Length).

    /* Longer lists */
    sumDistances([C1, C2|Rest], Length) :-
        symmetricDist(C1, C2, D1),
        sumDistances([C2|rest, D2),
        Length is D1 + D2  

NOTE: we're assuming symmetric travel distances between campuses, 
so we need to state that relationship: 

    symmetricDist(C1, C2, L) :- dist(C1, C2, L).
    symmetricDist(C1, C2, L) :- dist(C2, C1, L).


#### Finishing up TSP

So, here's our checker for whether this is a valid tour of the campuses: 

    /* Campuses is a list.
     * Tour is also a list but starts and ends at the same place, 
     * and visits every place once.
     */
    tsp(Campuses, Tour, Length) :-
        /* Require Tour to be non-empty, then check first and last element to
         * ensure round-trip. We're just pattern-matching. 
         * Use built-in predicate to get nth element */
        Tour = .(First, _), 
        length(Tour, L), nth(L, Tour, Last),
        First=Last,

Could also write that constraint as: get the last element and put First to
require that it be equal to the first of Tour by putting First in both places.
No functions, just relations, so pull out that length, find it, then use it

Now, how do we impose the visit every campus only once constraint? 

    tsp(Campuses, Tour, Length) :-
        Tour = .(First, _), 
        length(Tour, L), nth(L, Tour, Last),
        First=Last,
        length(Campuses, R), L is R + 1,

This isn't enough. We could be bouncing back and forth. 
Instead, we say that Rest is a permutation of Campuses. 
which implies the visit-once constraint. 

    tsp(Campuses, Tour, Length) :-
        Tour = .(First, _), 
        length(Tour, L), nth(L, Tour, Last),
        /* Tour must end where it starts */
        First=Last,
        /* Tour must visit every campus exactly once */
        permutation(Rest, Campuses),

Finally, we need to get the distance traveled, that Length parameter
in `tsp()`: 

    tsp(Campuses, Tour, Length) :-
        Tour = .(First, _), 
        length(Tour, L), nth(L, Tour, Last),
        /* Tour must end where it starts */
        First=Last,
        /* Tour must visit every campus exactly once */
        permutation(Rest, Campuses),
        /* Compute the length of the tour */
        sumDistancs(Tour, Length).

Notice that we have not imposed an optimality constraint, so the results 
returned are all of the possible tours, not necessarily the fastest ones. 
Some of the suggestions go up and down the state repeatedly. 


#### TSP Summary 

// Millstein's clean version

    dist(ucla, ucsd, 124).
    dist(ucla, uci, 45).
    dist(ucla, ucsb, 97).
    dist(ucla, ucb, 338).
    dist(ucla, ucd, 392).
    dist(ucla, ucsc, 346).
    dist(ucsd, uci, 72).
    dist(ucsd, ucsb, 203).
    dist(ucsd, ucb, 446).
    dist(ucsd, ucd, 505).
    dist(ucsd, ucsc, 460).
    dist(uci, ucsb, 148).
    dist(uci, ucb, 382).
    dist(uci, ucd, 440).
    dist(uci, ucsc, 395).
    dist(ucsb, ucb, 323).
    dist(ucsb, ucd, 378).
    dist(ucsb, ucsc, 260).
    dist(ucb, ucd, 64).
    dist(ucb, ucsc, 79).
    dist(ucd, ucsc, 135).

    /* shorthands for list patterns:
        .(H,T) gives you the head and tail of a list
        [H|T] is equivalent

        [H1,H2|T] matches a list of two or more items

    */

    symmetricDist(C1,C2,L) :- dist(C1,C2,L).
    symmetricDist(C1,C2,L) :- dist(C2,C1,L).

    sumDistances([C1,C2], Length) :-
        symmetricDist(C1,C2,Length).

    sumDistances([C1,C2|Rest], Length)  :-
        symmetricDist(C1,C2, D1),
        sumDistances([C2|Rest], D2),
        Length is D1+D2.

    tsp(Campuses, Tour, Length) :-
        Tour = .(First, Rest),
        length(Tour, L), nth(L, Tour, Last),
        /* a tour must end where it starts */
        First=Last,
        /* a tour must visit every campus once */
        permutation(Rest, Campuses),
        /* compute the length of the tour */
        sumDistances(Tour, Length).
