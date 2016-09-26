# CS 131: Programming Languages: Week 6 Monday 05/02/2016

## Python

What is a scripting language?

_def_: any dynamically typed programming language (Python, Javascript, Perl, PHP)

#### Features:

* easy manipulation of text data (regular expression matching)
* easy interaction with the system (files, processes, etc.)
* convenient syntax for lots of common operations

#### Disadvantages

* dynamically typed
* kitchen sink approach
	* functional core
	* objects
	* imperative features

#### Key Point

* best part of python is mocaml
* tuple vs. list
	* list is mutable
	* tuple is immutable

```python
l = [3,2,1]
l.reverse()
len(l)
```

#### Conversions

Python is great for converting different data types

```python
s = '34'
list(s)
tuple(s)
list(s)
```

#### Memory?

No pointers in Python; same like OCaml

```python
l = [1,2,3]
```

What is `l`? It's a local variable. The stack is holding local variables, and it is holding stuff to the linked list that links 1, 2, and 3 together

When you do `l2 = l`, it could be copying l, or it is copying the pointer of l

When you modify `l2`, you are also modifying `l1`

Shallow copy: simply copying a pointer 

Deep copy: copy the entire thing into a new allocation for that variable

Workaround:

```python
l2 = list(l) # make a copy of l for l2
# now if you modify l2, l will not be changed
```

More example:

```python
def prodList(l):
	result = 1
	for i in l:
		result *= i;
	return result

# to use this, do the following:
import <filename>
```

Here's something that is strange:

```python
prodList([1,2,3,"hello"])
# print out multiple copies of "hello"
```
### First Class Functions

```python
f = (lambda x: x+1)
map(f, [1,2,3,4,5])
map(lambda x: x+1, [1,2,3,4,5])
```

This does not mutate the list; this is purely functional

```python
l = [[1,2],[3,4],[5]]
l2 = map(lambda lst: lst.reverse(), l)
# reverse.() mutates the list, producted a garbage list because reverse doesn't return anything
```

Pattern Matching:

```python
l = [(1,2),(3,4),(5,6)]
for (x,y) in l:
	print (x+y)
```

Reduce:

```python
reduce(lambda x,y: x+y, [1, 2, 3, 4, 5])
map(lambda x: x+1, [1, 2, 3, 4, 5])
l = [1, 2, 3, 4, 5]
map(lambda x:x+1, l)
[x+1 for x in l] #shorthand to write map
map(lambda x: x+1, filter(lambda x: x>3, l))
[x+1 for x in l if x>3]
```

Cross Product

```python
l1 = [1,2,3]
l2 = [4,5,6]
[(x,y) for x in l1 for y in l2]
```

### Dictionary

```python
r = {"name" : "myrect", "width" :, 3.1, "height" : 2.4}
r.["name"]
r["color"] = "green"
```

OCaml has something similar:

```ocaml
type rect = {name: string; width: float, height: float};;
{name="myrect"; width=3.14; height=2.0};;
```

Exercise:

```python
# given a list of ints, make a dictionary mapping each element to its frequency
def frequency(l):
	d = {}
	for i in l:
		if i in d:
			d[i] += 1
		else:
			d[i] = 1
	return d
```

## 

