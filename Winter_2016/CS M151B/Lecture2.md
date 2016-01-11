# CS M151B Lecture 2

### Instruction Set

* Repertoire of instruction of acomputer
* Different computers have different ISAs

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

* [www.mips.com](https://www.mips.com)
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