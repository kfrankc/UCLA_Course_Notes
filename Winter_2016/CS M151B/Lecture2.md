# CS M151B Lecture 2

### Instruction Set

* Repertoire of instruction of acomputer
* Different computers have different ISAs  

**Some notes on stacks**
* stack is used for function calls
* malloc/dynamic calls are created on the heap
* TEXT: holds instructions for the ISA  

**_RISC vs. CISC_**  
**RISC**  
1. decoding is easier
2. small number of instr. types (simpler instr. in memory)
3. more burden on compiler
 * parallelism
 *pipelining
4. FL
5. large number of operand (varies)
6. simple addressing mode
7. load-store machine  

**CISC**  
1. decode is harder
2. large number of instruction type
3. More burden on machine because it has to decode
4. VL
5. small number of operand (varies)
6. complex addressing-mode
7. reg/memory machine

**Key ISA Decisions**  
* Operations
 * how many?
 * which ones
 * length?
* Operands
 * how many?
 * location
 * types
 * how to specify
* Instruction format
 * size
 * how many formats  

**Main ISA Classes**  
* CISC (complex instruction set computers)
 * digital's VAX (1977) and Intel's x86 (1978)
 * large number of instructions
 * many specialized complex instructions
* RISC (reduced instruction set computers)
 * almost all machines of 80s or 90s
 * relatively fewer instructions
 * pipelining and parallelism  

### MIPS Instruction Set

* [www.mips.com](https://imgtec.com/mips)
* Large share of embedded core market
* typical of many modern ISAs  

**Arithmetic Operations within ISA**  
* add and subtract, three operands
```
add a, b, c # a gets b + c //pseudocode
```
* all arithmetic operations have this form
>**Design Prinicple 1: Simplicity favors regularity**  
>* regularity makes implementation simpler
>* simplicity enables higher performance at lower cost  

**Example**  
```
addi R2 R0 8
// means add R[2], which is 32, and 8, which makes 40, and store that in R0; remember that R2 is not a literal

lw: data movement operation for MIPS
R[RT] = M[R[RS]+SE[Imm]] // reading from mem, writing to register files

sw: save/store data
M[R[RS]+SE[Imm]] = R[RT] // writes to mem, reads from RT 

jump j-type instr:
PC = PC + 4 + 5
4 Imm 0 0, for a total of 32 bits 
```

**More Examples**  
```
//C code
f = (g+h)-(i+j);

//compiled MIPS code
add t0, g, h  # temp t0 = g + h
add t1, i, j  # temp t1 = i + j
sub f, t0, t1 # temp f = t0 - t1
```  
**Register Operands**  
* Arithmentic instructions use register operands
* MIPS has a 32 x 32 bit register file
 * use for frequency accessed data
 * numbered 0 to 31
 * 32 bit data called a 'word'
* assembler names
 * $t0, $t1, ... , $t9 for temporary values
 * $s0, $s1, ... , $s7 for saved variables
>**Design Principle 2: Smaller is faster**
>* c.f. main memory: millions of locations  

**Example (using saved registers)**
```  
// C code
f = (g+h)-(i+j), where f ... j in $s0 ... $s4

// Compiled MIPS code
add $t0, $s1, $s2
add $t1, $s3, $s4
sub $s0, $t0, $t1
```  

### Memory Operands
* used for composite data
* how to apply arithmetic operands
 * load values from memory into registers
 * store result from register to memory
* Memory is byte addressed
 * each address identify an 8-bit byte
* Words are aligned in memory
 * address **must** be a multiple of 4
* MIPS is Big Endian
 * most sig byte at the _least_ address of a word
 * c.f. Little Endian: least sig byte at least address of word

**Memory Operand Example 1**  
```
// C code: 
g = h + A[8]; // g in $s1, h in $s2, base address of A in $s3

// Compiled MIPS code
// index 8 requires offset of 32, 4 bytes per word
lw  $t0, 32($s3)	# load word
add $s1, $s2, $t0
```

**Memory Operand Example 2**
```
// C code:
A[12] = h + A[8]; // h in $s2, base address of A in $s3

// Compiled MIPS code
// index 8 requires an offset of 32, 4 bytes per word
lw  $t0, 32($s3) # load word
add $t0, $s2, $t0
sw  $t0, 48($s3) # store word
```

### Registers vs. Memory
* Registers are much faster to access than memory
* Operating on memory data requires loads and stores
 * more instructions to be executed
* Compiler must use registers for variables as much as possible
 * only spill to memory for less frequently used variables
 * register optimization is important

### Immediate Operands
* constant data specified in an instruction
 * `addi $s3, $s3, 4`  
 * 16 bits
* No subtract immediate instruction
>**Design Principle 3: Make the common case fast**
>* small constants are common
>* immediate operand avoids a load instruction, which is faster  

**The constant zero**  
* MIPS register 0 ($zero) is the constant 0
 * _cannot_ be overwritten
* Useful for the common operations
 * `add $t2, $s1, $zero // move between two registers`  

**Unsigned Binary Integers**
* Given an n-bit number
 * `x = x_n-1*2^(n-1) + x_n-2*2^(n-2) + ... + x_1*2^1 + x_0*2^0`
* range: 0 to (+2^n - 1)
* **Example**
 * `0000 0000 0000 0000 0000 0000 0000 1011_2 = 11_10`
* Using 32 bits
 * `0 to +_4,294,967,295`

**2s-Complement Signed Integers**  
* Given an n-bit number: `x = -x_n-1*2^(n-1) + x_n-2^(n-2) + ... + x_1*2^1 + x_0*2^0`
* Range: -2^(n-1) to +2^(n-1)-1
* **Example**:
 * `1111 1111 1111 1111 1111 1111 1111 1100 = -4`
* Using 32 bits
 * `-2,147,483,648 to +2,147,483,647`
* Bit 31 is a sign bit
 * 1 means negative numbers
 * 0 means non-negative numbers
* -(-2^(n-1)) can't be represented
* **Examples**:
 * `0: 0000 0000 .... 0000`
 * `-1: 1111 1111 .... 1111`
 * most negative: `1000 0000 .... 0000`
 * most positive: `0111 1111 .... 1111`

**Signed Negation**  
* Complement and add 1
 * flip all the bits and add 1
**Example**
```
// negate +2
+2: 0000 0000 .... 0010
-2: 1111 1111 .... 1101 + 1101 + 1
```

**Sign Extension**
* Represent number using more bits
* in MIPS:
 * addi: extend immediate value
 * 1b, 1h: extend loaded byte/halfword
 * beq, bne: extend the displacement
* Replicate sign bit to the left
 * unsigned values: extend with 0s
**Example**
```
// 8 bit to 6 bit
+2: 0000 0010 --> 0000 0000 0000 0010
-2: 1111 1110 --> 1111 1111 1111 1110
```

### Representing Instructions
* Instructions ar encoded in binary (machine code)
* MIPS instructions
 * 32 bit instructions
 * smalle number of formats
 * regularity
* Register numbers:
 * $t0 - $t7 are register's 8-15
 * $t8 - $t9 are register's 24-25
 * $s0 - $s7 are register's 16-23

**MIPS R-format Instructions**
```
op rs rt rd shamt funct    instr.field
6  5  5  5  5     6        bits
```
* Instr. fields
 * op: operation code (opcode)
 * rs: first source register number
 * rt: second source register number
 * rd: destination register number
 * shamt: shift amount (0000 for now)
 * funct: function code (extends opcode)

**Example**
```
add $t0, $s1, $s2
special $s1   $s2   $t0   0     add 
0       17    18    8     8     32
000000  10001 10010 01000 00000 100000
00000010001100100100000000100000_2 = 02324020_16
```

**Hexadecimal**
* base 16
 * compact rep. of bit strings
 * 4 bits per hex digit
**Example**
```
eca8 6420 = 1110 1100 1010 1000 0110 0100 0010 0000
```

### MIPS I-format Instructions
```
op rs rt constant or address     instr.
6  5  5  16                      bits
```
* Immediate arithmetic and load/store instructions
 * rt: destination or source register number
 * constant: -2^15 to +2^15-1
 * address: offset added to base address in rs
>**Design Principle 4: Good design demands good compromises**
>* diff. formats complicate decoding, but allow 32-bit instr. uniformly
>* keep formats as similar as possible

### Stored Programs in Computers
* instructions rep. in binary, just like data
* instr. and data stored in memory
* programs can operate on programs
* binary compatibility allows compiled programs to work on diff. computers

### Logical Operations
```
Operation 		C 	Java	MIPS
shift left		<<	<<<		sll
shift right		>>	>>>		srl
bitwise AND 	&	&		and, andi
bitwise OR 		|	|		or, ori
bitwise NOT 	~`	~		nor
```

**Shift Op**
```
op rs rt rd shamt funct    instr.field
6  5  5  5  5     6        bits
```
* shamt: how many pos. to shift
* shift left logical:
 * shift left and fill with 0 bits
 * sll by i bits multiplies by 2^i
* shift right logical
 * shift right and fill with 0 bits
 * srl by i bits divides by 2^i (unsigned only)

**AND Op**
* useful for masking bits in a word
 * select some bits, clear others to 0
 * `and $t0, $t1, $t2`
```
$t2: 0000 0000 0000 0000 0000 1101 1100 0000
$t1: 0000 0000 0000 0000 0011 1100 0000 0000
$t0: 0000 0000 0000 0000 0000 1100 0000 0000
```

**OR op**
* useful to include bits in a word
 * set some bits to 1, leave other unchanged
 * `or $t0, $t1, $t2`
```
$t2: 0000 0000 0000 0000 0000 1101 1100 0000
$t1: 0000 0000 0000 0000 0011 1100 0000 0000
$t0: 0000 0000 0000 0000 0011 1101 1100 0000
```

**NOT op**
* useful to invert bits in a word
 * change 0 to 1, and 1 to 0
 * MIPS has NOR 3-operand instr.
  * a NOR b == NOT (a OR b)
 * `not $t0, $t1, $zero`
```
$t1: 0000 0000 0000 0000 0011 1100 0000 0000
$t0: 1111 1111 1111 1111 1100 0011 1111 1111	
```  

**Conditional Operations**  
```
beq, rs, rt, L1 
// if (rs == rt) branch to instruction labeled L1;
bne, rs, rt, L1
// if (rs != rt) branch to instruction labeled L1;
j L1
// unconditional jump to instruction labeled L1; kinda like a goto
```  
* there's a program counter, these instructions will write to PC  

**Compiling 'if' statements**  
```
// C code
if (i == j) 
  f = g+h;
else 
  f = g-h;

// Compiled MIPS code
	  bne $s3, $s4, Else
	  add $s0, $s1, $s2
	  j   Exit
Else: sub $s0, $s1, $s2
Exit: ...
```  

**Compiling Loop Statements**
```
// C code, i in $s3, k in $s5, address of save in $s6
while (save[i] == k)
  i += 1;

// Compiled MIPS code
Loop: sll  $t1, $s3, 2 		// array of 32 bit values, each integer stored in 4 mem locations, shift by 2, which means multiply by 4, $t1: address of content of save[i]
	  add  $t1, $t1, $s6
	  lw   $t0, 0($t1)
	  bne  $t0, $s5, Exit
	  addi $s3, $s3, 1
	  j    Loop
Exit: ...
```  

### Basic Blocks
* basic block is seq. of instructions, with:
 * no embedded branches 
 * no branch targets
 * compiler identifies basic blocks for optimization
 * advanced processor accelerate execution of basic blocks

**More Conditional Operations**  
* set result to 1 if condition is true, otherwise, set to 0
```
slt rd, rs, rt
// same as 
if (rs < rt) 
  rd = 1; 
else 
  rd = 0;

slti rt, rs, constant
// same as
if (rs < constant)
  rt = 1;
else
  rt = 0;

// use in combination with beq, bne
slt $t0, $s1, $s2  # if ($s1 < $s2)
bne $t0, $zero, L  # branch to L
```  

**Reason for Branch Instruction Design**  
* No blt, bge because hardware for <, >=, slower than =, != 
 * combining with branch involves more work
* Once again, make the common case fast  

**Signed and Unsigned**  
* signed comparison: slt, slti
* unsigned comparison: sltu, sltui
```
Ex.
$s0 = 1111 1111 1111 1111 1111 1111 1111 1111
$s1 = 0000 0000 0000 0000 0000 0000 0000 0000
slt  $t0, $s0, $s1 # signed
sltu $t0, $s0, $s1 # unsigned
```  

### Procedure Calling
1. Place params in registers
2. Transfer control to procedure
3. Acquire storage for procedure
4. Perform procedure's operation
5. Place result in register for caller
6. Return to place of call  

**Register Usage**
* $a0 - $a3: arguments (reg 4-7)
* $v0, $v1: result values (reg 2 and 3)
* $t0 - $t9: temporaries (written over by callee)
* $s0 - $s7: saved (saved by callee)
* $gp: global pointer for static data (reg 28)
* $sp: stack pointer (reg 29)
* $fp: frame pointer (reg 30)
* $ra: return address (reg 31)  

**Procedure Call Instr.**  
* jump and link: `jal ProcedureLabel`
 * address of following instr. put in $ra
 * jump to target address
* jump register: `jr $ra`
 * compies $ra to PC
 * can also be used for computed jumps (switch statements)  

**Leaf Procedure Example**
```
// C code
int leaf_example (int g, h, i, j) {
	int f;
	f = (g + h) - (i - j)
	return f;
}
* arguments g, ... , j in $a0 ... $a3
* f in $s0 (need to save $s0 on stack)
* result in $v0

// MIPS code
addi $sp, $sp, -4 	// decrement stack pointer for more space
sw $s0, 0($sp)
add $t0, $a0, $a1 	// procedure body
add $t1, $a2, $a3
sub $s0, $t0, $t1
add $v0, $s0, $zero // result
lw $s0, 0($sp)      // restore $s0
addi $sp, $sp, 4
jr $ra            	// return
```  

**Non-leaf Procedure Example**  
* procedure that call other procedures
* for nested: caller needs to save on stack:
 * return address
 * arg and temp needed after call
 * stack is restored after call
```
// C code
int fact(int n) {
	if (n < 1)
	  return f;
	else
	  return n * fact(n-1);
}
* arg n in $a0
* result in $v0

// MIPS code (try to understand this, very important)
fact:
	addi $sp, $sp, -8 		# adjust stack for 2 items
	sw 	 $ra, 4($sp)		# save return address
	sw 	 $a0, 0($sp)		# save argument
	slti $t0, $a0, 1 		# test for n < 1
	beq  $t0, $zero, L1 	
	addi $v0, $zero, 1 		# if so, result is 1
	addi $sp, $sp, 8 		# 	pop 2 items from stack
	jr   $ra  				# 	and return
L1:
	addi $a0, $a0, -1 		# else, decrement n
	jal  fact 				# recursive call
	lw   $a0, 0($sp) 		# restore original n
	lw   $ra, 4($sp)  		# 	and return address
	addi $sp, $sp, 8  		# pop 2 items from stack
	mul  $v0, $a0, $v0 		# multiply to get result
	jr   $ra  				# and return
```  

### Memory Layout
* Text: program code
* Static Data: global var
* Dynamic Data: heap (malloc)
* Stack: automatic storage
* Important registers: PC, GP, SP, FP
* Instructions **are** in memory!  

**32-bit Constants**  
* `lui rt, constant`
 * copies 16-bit constant to left 16 bits of rt
 * clears right 16 bits of rt to 0
```
lui $s0, 61  		 0000 0000 0111 1101 0000 0000 0000 0000 
ori $s0, $s0, 2304 	 0000 0000 0111 1101 0000 1001 0000 0000
```  

**Branch Addressing**  
* PC: 32 bit register
* Most branch targets are near branch
```
op 		rs 		rt 		constant or address
6 bits 	5 bits 	5 bits 	16 bits
```  
* PC-relative addressing
 * target address = PC + offset * 4
 * PC already incremented by 4 this time

**Jump Addressing**  
* `j, jal` targets could be anywhere in text
```
op 		address
6 bits 	26 bits // actually 28 bits, because two lower bits always 0

// Example
Loop: 	sll  $t1, $s3, 2
		add  $t1, $t1, $s6
		lw   $t0, 0($t1)
		bne  $t0, $s5, Exit
		addi $s3, $s3, 1
		j 	 Loop
Exit:   ...
```  

**Branching really far away**  
* assembler rewrites the code
```
// Example
	beq $s0, $s1, L1
	bne $s0, $s1, L2
	j   L1
L2:  ...
```  




