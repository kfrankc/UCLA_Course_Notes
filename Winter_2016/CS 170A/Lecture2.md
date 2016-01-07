# CS 170A 

### Some useful MATLAB code
```
A = eye(4) // create identity matrix 
inv(A)     // create inverse of A
A \ A      // multiply A by its inverse
A'         // Hermitian transpose
A.'        // transpose 
trace(A)   // sum of diagonal elements of A
```  
Kronecker Product / Tensor Product  
```
kron(A,B) = (a_ij * B) // used to build large matrices
linspace(a, b, n) // creates n linearly spaced values between a and b
blkdiag(A,B) // glue two matrices diagonal from each other
```  