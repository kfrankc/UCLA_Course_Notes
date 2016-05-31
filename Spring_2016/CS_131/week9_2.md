# CS 131: Programming Languages: Week 9 Wednesday 05/25/2016

### Pattern Match

In prolog, `=` is the unification operator

```prolog
a = b.
f(X) = f(a)
f(X, b) = f(a, Y). /* yes */
f(X, b) = f(a, X). /* no */
```

#### One idea underlying Prolog: Unification

Unification is generalization of pattern matching

```prolog
t ::= c | X | x(term1, ..., termN)
```

`term1 = term2` produces an environment E from variables to terms such that `E(term1) is syntatically identical to 
`E(term2)`

Cases:

```
c = c --> {} // produces empyy environment
X = t --> {X: t}
t = X --> {X: t}
```

Specialize to binary function

```
c(t1, t2) = c(t3, t4) --> 
	t1 = t3 --> E1
	t2 = t4 --> E2
	[if either returns "no", then "no"]
	return E1 U E2

else
	"no"

```

The `U` (union) operator is a bit more complicated:

1. It has to merge E1 and E2: whenever E1(X) is t1 and E2(X) is some term t2, then the union should map X to result of unifying t1 and t2. 
2. The result of the union should be in *solved form*: if a varialbe is in the domain of E then it should not appear in the range

#### Examples

We are going to walk down the list, unify with each rule, and check. First solution is gonna be whatever X match with first.

```prolog
prereq(cs32, X). 
```

What happens when you use this rule:

```prolog
prereq(cs32, U) :- prereq(X, Z), prereq(Z, Y).
```

You would try to unify the statement with the head of this rule that you have. 

`[prereq2(cs32, Z), rereq(Zs] Y`

X = cs32, Y = U
sub goals: [prereq(cs32, Z), prereq(Z, Y)]
[
unify first subgoal with prereq facts Z = cs33
[prereq(cs33, U), now we habt sap
unify first subgoal wihith prereq(cs 33, cs111)

Pitfall: consider the query `prereq(cs32, X)`; this X is a different X than the one in the prereq2 rule.

Every rule has its own scope.

#### More examples

```prolog
prereq3(X, Y) :- prereq2(X, Z)m prereq(Z, Y)
```

Search Strategy:

1. depth first, left to right

Let's draw the left-most successful path in the tree...

`1 child: [prereq2(cs32, Z), prereq(Z, U)]`

`1 child: [prereq(cs32, Z'), prereq(Z', Z), prereq(Z,U)]`

`17 children: line 5 child: Z' = cs33 [prereq(cs33, Z), prereq(Z,U)]`

`17 children: line 8 child: Z' - cs111 [prereq(cs111, U)]`

`17 children: line 13 child: U = cs118 [] -- SOLUTION U = 118`


### More examples to illustrate parsing (IMPORTANT)

```prolog
isANumber(zero).
isANumber(succ(N)) :- isANumber(N).
```

```
		[isAnNumber(N)]
		/			\
	[] N=zero		[isANumber(N0)] N=succ(N0)
					/				\
				[] N0=zero			[isANumber(N0') N0=succ(N0')]
```

If you do the second statement before the first one, it will go into stack overflow, because infinite solution.

### Tail Recursion

```prolog
len([], Accum, Accum).
len([_|T], Accum, Result) :- Accum1 is Accum+1 :- Result = Accum+1, len(T, Accum, Result).
```