# Homework 1 Notes: Matrix and Linear Algebra Review

### 1. Kinds of Matrices
1. Invertible Matrix  
```
an n by n square matrix A is invertible if there exists n by n square matrix B such that AB = BA = I_n 
an n by n square matrix A is called singular if it is not invertible. This can be tested by seeing that the det(A) = 0
```
2. Hermitian Matrix
```
square matrix with complex entries that is equal to its own conjugate transpose
A = conjugate(A_transpose)
```
3. Unitary Matrix
```
square matrix where its conjugate transpose is also its inverse
U * U_transpose = I
```
4. Orthogonal
```
a matrix is orthogonal when the dot product of any vector in the n x n matrix is 0. Orthogonal matrix length is always 1
```