# CS 131: Programming Languages: Week 6 Wednesday 06/04/2016

### Key Concetps & Ideas

1. Subtyping
2. Inheritance
3. Dynamic Dispatch

Everything is an object. Objects only communicate by sending messages to each other. Think of each object as a little computer; they all talk to each other by sending messaged to each other. 

We are using Java version 8 (latest version)

Separation of Interface and Implementation

### Interface

No implementations, but this is an interface. I can write code against this interface and compile it.

```java

import java.util

interface Set {
	boolean contains(String s);
	void add(String s);
}

// an implementation of methods described above
class ListSet implements Set {
	// protected: this class and subclasses can have access to it
	protected List<String> elems = 
		new LinkedList<String>();

	public boolean contains(String s) {
		return elems.contains(s);
	}

	public void add(String s) {
		if(this.contains(s))
			return;
		else
			elems.add(s);
	}
}

class Client {
	void m(Set s) {
		if (s.contains("hi"))
			s.add("bye");
	}
}
```

### SubTyping: 

Two types of polymorphisms

1. parametric polymorphism
	* some type is parametrized by one or more type variables
	* clients can choose how to instantiate type variables
2. subtype polymorphism
	* there's a **subtype** relation of types
	* if S is a subtype of T, then you can pass an object of type S where an object of type T is expected.

Example: PolySet:

```java
interface PolySet<T> {
	boolean contains(T t);
	void add(T t);
}
```

### Inheritance

_def_: a mechanism for code reuse in implementations

Example: RemovableSet is a subtype of Set (Inheritance)

```java
interface RemovableSet extends Set {
	void remove(String s);
}

class RemovableListSet extends ListSet
	implements RemovableSet {

	public void remove(String s) {
		elems.remove(s);
	}
}
```

#### More Examples

Goals: Squares should be able to be passed wherever rectangles are expected, but don't want Square to inherit from Rectangle

```java
interface Shape {
	double area();
	double perimeter();
	// ...
}

class Rectangle implements Shape{
	double width;
	double length;
}

class Square implements Shape{
	// ...
}

class MyClient {
	void m(Shape s) {
		// ...
	}
}
```

How do we have inheritance without subtyping?

Suppose we have the following:

```java
class ListSet {
	protected List<String> elems = 
		new LinkedList<String>();

	public boolean contains(String s) {
		return elems.contains(s);
	}

	public void add(String s) {
		if(this.contains(s))
			return;
		else
			elems.add(s);
	}
}

/* we want to implement bags
	- sets that can contain duplicates
*/

/* claim: we want ListBag to inherit code from ListSet,
	but ListBag should not be a subtype of ListSet */

// one option: forwarding

class ListBag {
	ListSet l;
	boolean contains(String s) {
		return l.contains(s);
	}
}

// another option: shared superclass
abstract class Collection {
	protected List<String> elems = 
		new LinkedList<String>();

	public boolean contains(String s) {
		return elems.contains(s);
	}
	// like a virtual function
	abstract void add(String s);

	void addAll(String[] a) {
		for (String s : a)
			this.add(s);
	}
}

class ListSet extends Collection {
	void add(String s) {...}
}

class ListBag extends Collection {
	void add(String s) {...}
}
```

### Dispatch

```java
class C {
	void n() { this.m(); }
	void m() { System.out.println("C");}
}

class D extends C {
	void m() { System.out.prnitln("D");}
}

class Main {
	public static void main(String[] args) {
		C c = new C();
		D d = new D();
		c.m();
		d.m();
	}
}
```

The above code should print C and then D.

Another example!

```java
C c2 = new D();
c2.m(); // this will print D
```

Why is it D? Because we have **dynamic dispatch** (runtime)

> Every single method call in Java is **dynamically dispatched**. 

What that means is that the static type is irrelevant. At runtime, what is actually matters is what is this object at that time. While `c2` has type C during compile time, during runtime it has type D.

Invoke the best method implementatin based on the class of the receiver object. 

What about this?

```java
D d2 = new C(); // this will give static type error because D extends from C
```

Another example! Keep 'em coming

```java
c.n(); //print C
d.n(); //print D
c2.n(); //print D
```

