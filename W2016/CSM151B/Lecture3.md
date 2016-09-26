# CS M151B Lecture 3: Arithmetic for Computers

### Overview
* Operations on integers
 * addition, subtraction, multiplication, division, overflow
* Floating point real numbers
 * representation and operation

### Integer Addition
Example: 7 + 6  
* Overflow if result out of range
* adding +ve and -ve operands, no overflow
* adding two +ve operands - overflow if result sign is 1
* adding two -ve operands - overflow if result sign is 0  

### Integer Subtraction
Add negation of second operand  
Example 7 - 6 = 7 + (-6)  
* Overflow if result out of range
* Subtracting two +ve or two -ve operands, no overflow
* Subtracting +ve from -ve operand: overflow if resut sign is 0
* Subtracting -ve from +ve operand: overflow if result sign is 1  

### Dealing with Overflow
* Some languages (C) ignore overflow (use MIPS addu, addui, subu)
* Other language (Ada, Fortran) need raising exception
 * Use MIPS: add, addi, sub instructions
 * On overflow, invoke exception handler
  * save PC in exception program counter (EPC)
  * jump to predefined handler address
  * mfc0 instruction can retrieve EPC value to return after corrective action  

### ALU (Arithmetic Logic Unit Design)
1. One bit ALU
 * Performs AND, OR, ADD
 * 1-bit operands
 * AND gate
 * OR gate
 * 1-bit adder
  * 1-bit full adder
   * also known as (3,2) adder
   * Carryout Logic Eq: `CarryOut = (!a & b & CarryIn) | (a & b !b & CarryIn) | (a & b & ! CarryIn) | (a & b & CarryIn)`
   * Carryout: `(b & CarryIn) | (a & CarryIn) | (a & b)`
   * Sum Logic Eq: `Sum = (!a & !b & CarryIn) | (!a & !b & !CarryIn) | (a & !b & !CarryIn) | (a & b & CarryIn)`
 * Multiplexor 

2. 32-bit ALU  
 * Ripple Carry ALU
  * Each ALU has a CarryIn and a CarryOut 
 * Subtraction? 
  * Expand our 1-bit ALU to include an inverter
  * 2's complement: take inverse of every bit and add 1
 * Overflow
  * For N-bit ALU: `Overflow = CarryIn[N-1] XOR CarryOut[N-1]`
 * Zero Detection
  * Conditional Branches
  * One big NOR gate
  * `Zero = (Result_N-1 + Result_N-2 + ... + Result_1 + Result_0`
  * Any non-zero result will cause zero detection output to be zero

3. Set On Less Than (SLT)
 * R type instruction
 * produce 1 if rs < rt, 0 otherwise
  * 31 0s, followed by 1 or 0
 * rs - rt < 0 
  * set the least significant bit to the sign-bit of (rs - rt)
  * NEW INPUT: LESS
  * NEW OUTPUT: SET

### Can we make a Faster Adder?
* Will discuss Ripple Carry



