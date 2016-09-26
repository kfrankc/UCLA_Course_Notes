# CS 170A: Discussion 1

### Luis Angel 
OH 11:30 - 12:30 Tuesday, Wednesday  
BH 2432  
langel@cs.ucla.edu  
[cs.ucla.edu/~langel](cs.ucla.edu/~langel) 

### Project
* detecting some trend in the data
* finding some patterns in the data

### Review of MATLAB

Declare a scalar in MATLAB: `x = 7;`  
Create matrix: `A = [1 2 3; 4 5 6];`  
Create matrix with only ones inside (first arg: number of rows, second arg: number of col): `A = ones(2,3);`  
Create random numbers: `R = rand(4, 5);`  
Create random number of normal distribution: `Rn = randn(4,5);`  
Create identity matrix: `I = eye(4,2);`  
Find the diagonals in a matrix: `diag(R);`  
```
R = rand(4);
R = 1 + round(R*5); 
R = 1 + ceil(R*5);
R = 1 + floor(R*5);
R = 1 + int8(R*5); // casting value in between [0, 255];
```
Find square root of each element in matrix: `sqrt(R);`  
Find the sine or cosine of each element: `sin(R), cos(R);`  
`R^4` means mutliplying R by 4 times  
`R.^4` means taking each element to the 4th power  
Clear the command line: `clc`  
Comute the determinant of matrix: `A = det(A)`  
Compute the inverse of matrix: `A = inv(A)`  
How to computer inverse:  
```
Given matrix A = [a b; c d]
1. Computer determinant det = ad - bc
2. inverse of matrix A = 1 / det [d -b; -c a]
```
`sum(A, 1)` means we sum the elements through the col and we get a row of values  

### More Notes
To compute the sum of a matrix: `A*[1...1]'`  
To compute the mean: `A = [a b; c d; e f];`  
`A - m`, where m is a scalar, means all elements of A will subtract m.  

```
(([1...1]*(A - m)).^2*[1...1])/(n-1)' //compute sum of all elements in the matrix
```
Sum gives the sum of the elements in the vector
```
s = sum( sum( A));
m = s / 12;
D = A - m;
D = D.^2;
([1 1 1] * D) * [1 1 1 1]'; // sum of all elements
v = ans / 11 // compute the variance of the whole matrix
a = reshape( A, 12, 1) // make A into col vector
var(a); // same as above 
mean(mean(A)); // same as above
```
Magic function (sum of rows is the same as sum of diagonals): `A = magic(4);`  
`A( A>10 ) = 100` assign all 1 to 100
`B(index) = 100`  
`B(B ~= 100) = 0`  

### Plotting

Example 1. Generating a coordinates of a circle  
```
r_i = 3;
t = linspace(0, 2*pi, 100);
x = cos(t)*r_i;
y = sin(t)*r_i;
plot(x, y, 'b-', 'LineWidth', 2, 'Marker', '^', 'MarkerFaceColor', [1 0 1], 'MarkerSize', 10);
axis equal;
xlabel('x axis')
ylabel('y axis')
title( sprintf('%f is a number', pi))
legend('circle')
hold on
plot(t, x);
legend('first', 'second')
hold off
```

### How to create a function

To create a function in MATLAB:  
```
% function format
function [out1, out2, ...] = myFunction();
% each function needs to be in its own file
```
To define a function in its own line, do this:  
```
myfunc = @(a,b) a' * b
```