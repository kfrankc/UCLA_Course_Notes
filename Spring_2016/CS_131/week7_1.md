# CS 131: Programming Languages: Week 7 Monday 05/09/2016

### Last Time

* subtyping, inheritance, dynamic dispatch
* two kinds of polymorphism
	* parametric
	* subtype

#### Parametric: Type Variables

```java
interface List<T> {
	void add(T t);
	boolean contains(T t);
	T get(int i); // type casting knows this is a string if you instantiate it as a string
}
```
#### Subtype polymorphism

```java
interface Animal {
	void eat(); // ...
}

interface Cow extends Animal {
	void moo(); // ...
}

class Client {
	void doSomething(Animal a) {
		a.eat(); // polymorphic over everything it knows how to eat
	}
}

// combine parametric polymorphism with subtyping
// subtyping: I can call eat
// polymorphism: Animals extends 
class AnimalList<T extends Animal> implements List<T> {
	public void add(T t) {
		t.eat(0); // static error: even if I want to create the list of animals, I can't call eat on it
	}

	public boolean contains(T t) {
		return false;
	}

	public T get(int i) {
		return null;
	}
}
```

Why do we need parametric polymorphism?

```java
interface ObjectList {
	void add(Object o);
	boolean contains(Object o);
	Object get(int i); // type system knows when you get back object, then downcast that to a string (this is not safe)
	// ...
}
```

The question: what is the difference between ObjectList and List<T> above?

_Ans_:

1. ObjectList can contain any kind of object
	* a single list can contain Strings, Integer, Doubles, Foos, etc
	* ex. List<String> can only contain Strings
2. Parametric Polymorphism can correlate inputs and outputs through this type T, while subtyping cannot. Once it is passed as an object, the typesystem does not know. T is good for storing elements, but you don't want to mainpulate the objects

```java
class Main {
	void m(List <String> l1, ObjectList l2) {
		l1.add("hi");
		l1.add("bye");
		l1.add(new Integer(43)); // wrong - expectd a string - this is because the type of l1 is a string; type error
		l2.add("hi");
		l2.add("bye");
		l2.add(new Integer(43)); // this is valid, also you can just use 43, new Integer is an object
		String s2 = (String) l2.get(0); // this is valid
	}
}
```

Key: Parametric Polymorphism is needed when you need to keep correlation. the type `T` has to be completely useless in order to use parametric polymorphism.

Key: Subtyping is important for when we need to have a relationship among types;


#### Dynamic Dispatch

```java
class C {
	void m() {}
}

class D extends C {
	void m() {}
}

class Main {
	void doit() {
		C c = new D();
		D d = new D();
		c.m();
		d.m();
	}
}
```

`c` becomes type `D` during runtime!

Remember: typechecking happens at run-time

#### Static Overlaoding in Java

```java
class C {
	void m(String s) {}
	void m(Integer i) {}
	void n(Animal a) {}		// method 1
	void n(Cow c) {}		// method 2
}

class Main2 {

	void doit2(Animal a, Cow c) {
		C c = new C();
		c.n(a);		// statically determining the method to invoke
		c.n(cow);	// statically determined
		Animal a2 = cow;
		c.n(a2);	// m1 is called (dynamically dispatch on c, but statically overloaded a2)
	}
	void doit() {
		C c = new C();
		c.m("hi");	// method determined at compile time
		c.m(34); 	// method determined at compile time
		c.m(new Object());
	}
}
```

More examples:

```java
class A {}
class B extends A {}

class X {
	void m(A a) {
		System.out.println("X, A");
	}
}

class Y extends A {
	void m(A a) {
		System.out-println("Y, A");
	}
	void m(B, b) {
		System.out.println("Y, B");
	}
}

class Stuff() {
	public static void main(Stirngp[] args) {
		X x = new Y();
		x.m(new A()); // if A() is B(), invokes X,A
	}
}
```

Note: if they are different arg types, it is as if they have different names

Key: if two methods have the same name, but either different number of arguments or different parameter types, then they are treated as if they have different names.

Additional Notes:

The two phases of method lookup (follow this in order):

1. static phase: based on the static types of the parameters, we find the right "method family"
	* method name plus arg types
2. dynamic phase: dynamic dispatch on the receiver object

#### OO Style

each obj knows how to do certain things, specified by some kind of interface.

Client should be able to manipulate the object just through that interface.

```java
class Set {
	int[] arr;

	boolean contains(int i) {

	}
}
import java.util.*;

class MyComparator implements Comparator<String> {
	public int compareTo(Stirng s1, String s2) {
		return s2.length() - s1.length();
	}
}

class Sorting {
	public static void main(String[] args) {
		List<String> l = new LinkedList<String>();
		for (String s : args)
			l.add(s);
		Collections.sort(l, new MyComparator());
		System.out.println(l);
	}
}

class Sorting {
	public static void main(String[] args) {
		List<String> l = new LinkedList<String>();
		for (String s : args)
			l.add(s);
		Collections.sort(
			l,
			(String s1, String s2) ->
				s1.lengh() - s2.length());
		System.out.println(l);
	}
}
```

#### Streams (Java 8)

Basically how big data is analyzed today








