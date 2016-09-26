# CS 131: Programming Languages: Week 7 Wednesday 06/11/2016

### Exceptions in java

```java
interface List {
	void add(String s);
	String get(int i) throws OutOfBoundsAccess;
}

class OutOfBoundsAccess extends Exception {}

class Exn2 extends Exception {}

class MyList implements List {
	public void add(String s) {}

	public String get(int i) throws OutOfBoundsAccess, Exn2 {
		if (i < 0)
			throw new OutOfBoundsAccess();
		else if (i > 20) 
			throw new Exn2();
		return "hi";
	}

	public String callsGet(int i) throws OutOfBoundsAccess {
		try {
			return this.get(i);
		} catch(Exn2 e) {
			return "exn2 error";
		} catch(OutOfBoundsAccess e) {
			return "negative number";
		}
	}
}

class Client {
	void m() {
		List l = new MyList();
		String s = l.get(i);
	}

	public static void main(String[] args)
		throws OutOfBoundsAccess {
			try {
				new Client().m();
			} catch (Exn2 e) {}
	}
}
```

Exception separates error handling from code. 

A possible error is unreported exception, so we need to add `throw OutOfBoundsAccess` as part of the function signature.

Another error is that we didn't declare it in the interface List.

Another problem: I call a function get(...), it throws an exception. How do I get back to a safe state of memory, in order to continue executing?

```java
class X {}
class Y {}

class XException extends Exception {}
class YException extends Exception {}

class Example {
	X x;
	Y y;

	void updateX() throws XException {
		// do some computation
		// update value this.x
	}

	void updateY() throws YException {
		// do some computation
		// update value this.y
	}

	void updateBoth() throws XException, YException {
		X oldx = this.x;
		updateX();
		try {
			updateY();
		} catch (YException ye) {
			this.x = oldx;
			throw ye;
		}
	}

	void readFileAndCompute(File f) {
		String s = f.read();
		try {
			compute(s);
		} finally { // definitely execute before function returns
			f.close();
		}
	}
}
```

### Memory Safety

Memory safety in C is very poor.

```java
Set s = new ListSet();
// s is on the stack, the new object is on the heap; s is a pointer to the new object
s.add("hi");
// dereferencing s and updating the object o to contain the "hi" value
Set s2 = s;
// s2 now points to o
// s and s2 are **aliases**
s2.remove("hi");
// now o no longer contains "hi"
```

Parameter passing? In Java, parameter passing is always by value

> The value of the actual parameter is copied into the formal parameter.

But the values are always pointers.

**KEY property**: the vlaue of the actual parameter cannot be changed by the function call.

```java
int plus(int a, int b) {
	a += b;
	return a;
}

void f() {
	int x = 3;
	int y = 4;
	int z = plus(x, y);
}
```

Another example:

```java
Integer plus(Integer a, Integer b) {
	a = new Integer(a.i + b.i);
	// a.i += b.i // this will change x to 7
	return a;
}

Integer x = new Integer(3);
Integer y = new Integer(4);
Integer z = plus(x, y);
// x still points to the original object that it pointed to, with value 3
```

Call by Reference in C++

```cpp
int plus(int& a, int& b) {
	a += b;
	return a;
}

void f() {
	int x = 3;
	int y = 4;
	int z = plus(x, y);
}
```




