# CS 131: Programming Languages: Week 8 Monday 05/16/2016

## Parallel Computing

### Why we need parallel computing

1. we can no longer use Moore's Law to speed up sequential programming
	* we are using Moore's Law to double our number of computational elements (no. of CPUs/processors) roughly every two years
	* we haven't been increasing the clock speed, but we've been increasing the parallelism
2. Big Data - no way to fit on single machine, but you want to fit it on a cluster of machines
	* not just a parallel program, but a distributed program

### What is 'embarrasingly parallel'?

* example: `List.map`, `reduce`, `filter`, `sort`

The dream would be authomatic parallelization!

Big Data: Google MapReduce, Hadoop, Spark Apache, Java Stream

In fact, Java Stream provides similar capability for a single machine

Example:

```java
import java.utils.Arrays;

// a seq of elements supporting sequential and parallel aggregate operations
class Sum {
	public static void main(String[] args) {
		int size = Integer.parseInt(args[0]);
		int[] arr = new int[size];
		for (int i = 0; i < size; i++)
			arr[i] = i;

		// now i want to sum it
		int sum =
			Arrays.stream(arr)
				.parallel() // now this is parallel
				.reduce(0, (i1, i2) -> i1+i2);
		System.out.println(sum);
	}
}
```

Another Example:

```java
class Sort {
	public static void main(String[] args) {
		int size = Integer.parseInt(args[0]);
		double[] arr = new double[size];
		for (int i = 0; i < size; i++)
			arr[i] = Math.random() * size;

		// now i want to sum it
		double[] out = 
			Arrays.stream(arr)
				.parallel() // without parallel (7.8 sec), with parallel(4 sec)
				.sorted()
				.toArray();
		for(int i = 0; i < 10; i++)
			System.out.println(out[i]);
	}
}
```

On a 2 core machine, you can get at most 2x speedup

If you get a 8 core machine, you can get at most 8x speedup

We will be talking about fork/join parallelism. On the next hw, you will get fork/join or stream parallelism.

Difference between parallelism and concurrency

* parallelism: use extra resources to get things done faster
* concurrency: correctly and efficiently manage access to shared resources

Sequential Program:

* stack, program counter, objects in the heap (shared globally)
* so called shared memory
* OS is scheduling how these threads execute
* you can control by using synchronization on threads

Parallel Programs

* first approach
	* have 4 threads simultaneously sum 1/4 of an array
	* run each thread, wait for them to finish, then add together fhoir 4 awerd
	* **problem**: if you have 3 processors and using 3 threads would take time x, then creating 4 threads could take time 1.5 min,
	* potential solutions: crease a bunch of little pieces.
		* build a tree (recursively divide)
	* one thing we will have issues (deal with failure on different machines)

### Java's fork/join Library

* meet the divide and conquor fork-join algoritm. 

* map, fold,reduce

How Java's ForkJoinTask library works

```java
void fork() {
	// spawn a new thread;
	// invoke this.compute() in the new thread
}

V join() {
	// wait for the new thread to finish
	// return its result
}
```

Here is an example of fork() and join() in action

```java
import java.util.concurrent.*;

class SumTask extends RecursiveAction<Long> {
	// constants are final - assigned once
	private final int SEQUENTIAL_CUTOFF = 10000;

	private int[] arr;
	private int low, high;

	public SumTask(int[] a), int low, int high) {
		this.arr = a;
		this.low = low;
		this.high = high;
	}

	public Long compute() {
		if (high - low > SEQUENTIAL_CUTOFF) {
			int mid = (low + high) / 2;
			SumTask left = 
				new SumTask(arr, low, mid);
			SumTask right = 
				new SumTask(arr, mid, high);
			left.fork(); // fork them both
			right.fork();
			long l1 = left.join(); // join is synchronization
			long l2 = right.join();
			return l1+l2;
		} else {
			long sum = 0;
			for (int i = low; i < hi; i++)
				sum += arr[i];
			return sum;
		}
	}
}

class SumFJ {
	public static void main(String[] args) {
		int size = Integer.parseInt(args[0]);
		int[] arr = new int[size];
		for (int i = 0; i < size; i++)
			arr[i] = i;
		int sum = 
			new SumTask(arr, 0, size).compute();
		System.out.println(sum);
	}
}
```

Notes to keep in mind:

This is a very idea / implementation. Gives you everything you need to make it happen. All you need are forks and joins. You are just trying to get speedups. The only thing you need are joins. The parent is waiting for child processes to finish. That is it.