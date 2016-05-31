# Prolog Exercises

### List Manipulation

#### Reverse

```prolog
reverse( [H|T], R) :- reverse(T, Z), append(Z, [H], R).
reverse(List, Reversed) :- reverse(List, [], Reversed).
reverse([], Reversed, Reversed).
reverse([Head|Tail], SoFar, Reversed) :- reverse(Tail, [Head|SoFar], Reversed).
```

#### Shift Left

```prolog
shift_left([], []). /* base case */
shift_left([_|T], [T]).
```

#### Shift Right

```prolog
shift_right([_],[]).
shift_right([H|T],[H|T2]) :- shift_right(T, T2).
```

#### Shift Left Circular

```prolog
shift_left_circular([H|T], R) :- append(T, [H], R).
```

#### Shift Right Circular

```prolog
shift_right_circular(L,R) :- shift_left_circular(R, L).
```

#### Unzip

```prolog
unzip([], [], []).
unzip([H|T], Y, Z) :- H = [H1|H2], Y = [H1|Ys], Z = [H2|Zs], unzip(T, Ys, Zs).
```

### Finite Domain Solver

```prolog
add(X, Y, Z) :- Z is X + Y.
add(X, Y, Z) :- Z #= X + Y.
```

```prolog

```