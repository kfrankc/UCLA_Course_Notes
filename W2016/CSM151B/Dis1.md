# CS M151B Discussion 1

### Diyu Zhou
**Email**: zhoudiyupku@gmail.com  
**OH:** Wednesday, 3:30 PM - 5:30 PM, BH 2432  

### Things I can do
1. Summary
2. Go through the different part in the lecture
3. Review session before exams
4. More examples
5. Go over the homeworks

### Week 1: 
only slides 1_3 and 1_4 matters  
Usually, what is on the test is performance

```
performance = 1 / execution time
```  
ex. `X is n times faster than Y`  
```
performance_x / performance_y = n = execution_time_y / execution_time_x
```  
Now, we will talk about **CPU time**.  
```
CPU_time = Number_of_CPU_cycles * clock_cycle_time
Number_of_CPU_cycles = Number_of_instr * cycles_per_instr
```
Knowing this information, we have the following:  
```
CPU_time (ET) = IC * CPI * Clock_cycle (CT)
```   
**CPI Calculation**  
```
CPI = SUM(CPI * IC_i / IC_total)
```
**Amdahl's Law**  
```
T_improved = T_affected / T_improvement_factor + T_unaffected
```   
**Pitfall**: No matter how much we improve on the code, our lower bound (unaffected time) will always bound it.

### Sample question 1

Consider the performance of a processor with a clock frq of 2.4 GHz on a suite of benchmarks. Two different sets of measurements are made: 
1. The programs are compiled by a compiler and 
2. the programs are written in assembly by a highly skilled programmer.  

The highly skilled programmer manages to get a reduction of a factor of 2.3 in the CPI and a performance improvement of a factor of 9.7 compared to the compiled programs. What is the reduction in instruction count obtained by the highly-skilled programmer. 

#### Solution: 

```
We use the equation: ET = IC + CPI + CT
let ET_a be the compiler
let ET_b be the skilled programmer
We know the following:
ET_a / ET_b = 9.7
ET_a / ET_b = (IC_a + CPI_a + CT_a) / (IC_b + CPI_b + CT_b)
CPI_a = 2.3CPI_b
CT_a = CT_b because running on the same processor
Therefore, we can solve:
9.7 = IC_a * 2.3 / IC_b
IC_a / IC_b = 9.7 / 2.3 
IC_a = 4.217 * IC_b
```
Therefore, the reduction factor is 4.217

### Sample question 2

When a processor executes program PA, the execution time is 3.8 seconds and the CPI is 2.9. When the same processor executes program PB, the execution time is 8.5 seconds and the CPI is 3.7. A typical workload consists of executing PA, then executing PB. What is the CPI for this typical workload?

#### Solution:

```
Set the equation:
let ET_a be PA
let ET_a be PB
CPI_a+b = ET_a+b / (IC_a+b * CT)
we need IC_a and IC_b, since IC_a+b = IC_a + IC_b
IC_a = ET_a / (CPI_a + CT)
IC_b = ET_b / (CPI_b + CT)

Therefore, plug into our equation:
CPI_a+b = 12.3 / (3.8/(2.9*CT)*CT + (8.5/(3.7*CT)*CT))
CPI_a+b = 3.409
```
Therefore, our CPI for this workload is 3.409

### Sample question 3

Consider a processor that achieves an overall average CPI of 3.6 when executing a program P1. 23 % of the instructions of P1 performs floating point operations. For these floating point instructions, the average CPI is 5. By improving the design of the floating point ALU, the average CPI for floating point instructions is reduced from 5 to 3.  
1. What is the overall average CPI for the improved processor? 
2. If the original processor executed P1 in 190 seconds, how long will it take the improved processor to execute P1?

#### Solution:

```
1. To find overall average CPI, first calculate the CPI needed to execute the 77 % of the job
3.6 = .23*5 + .77 * x
x = 3.182
Now, we set 5 to 3, and recalculate the average CPI
CPI = .23 * 3 + .77 * 3.182
CPI = 3.14

2. Simiarly use our famous equation:
ET_new = (ET_old / CPI_old) * CPI_new 
ET_new = (190 / 3.6) * 3.14 = 165.72 s
```

### Sample question 4 

We have two different processors, one with floating point hardware, and the other without it.  
For the one with floating point hardware:  
* Floating-point multiply: 6 cycles
* Floating-point add: 4 cycles
* Floating-point divide: 20 cycles
* Integer instruction: 2 cycles

For the one without floating point hardware:  
* Integer instruction: 2 cycles
* Floating-point multiply: 30 integer instructions
* Floating-point add: 20 integer instructions
* Floating-point divide: 50 integer instructions

* Floating-point multiply: 10 %
* Floating-point add: 15 %
* Floating-point divide: 5 %
* Integer instructions: 70 %
* Clock rate: 1000 MHz

**Questions:**  
1. What is the execution rate in MIPS (millions instructions per seconds)?
 * Execution rate = number of instructions / seconds
2. Processors-FPU needs 300 million instructions for a program
 * How many instructions Processors-no-FPU needs?
3. Which processor is faster? 

#### Solution: 

```
1. We know from the problem that: ER = IC / ER = IC / (IC * CPI * CT) = 1 / (CPI*CT)
Floating point hardware:
ER_fp = 1 / (CPI_fp * CT)
CPI_fp = 0.1*6 + 0.15*4 + 0.05*20 + 0.7*2 = 3.6
ER_fp = 1 / (3.6 * (1/1000*10^6)) = 277.7*10^6 = 277.7 MIPS

No Floating point hardware:
ER_nofp = 1 / (CPI_nofp * CT)
CPI_nofp = 2 // because all calculations are turned into integer instructions, and there's only 2 cycles of that
ER_nofp = 1 / (2 * (1/1000*10^6)) = 1000*10^6 / 2 = 500 MIPS 

2. We know that IC_fp = 300*10^6 instructions
We now do the calculations:
IC_fp = 300 million
FP multiply: .10 * 300 million * 30 integer instructions = 900 million
FP add: .15 * 300 million * 20 integer instructions = 900 million 
FP divide: .05 * 300 million * 50 integer instructions = 750 million
Integer instructions: .7 * 300 = 210 million 

Now, we can find the total number of instructions by adding the above results together:
900 + 900 + 750 + 210 = 2760 million instructions

3. We simply compare:
ER_fp = IC_fp / ET_fp = 300*10^6 / 277.72*10^6 = 1.08
ER_nofp = IC_nofp / ET_nofp = 2760*10^6 / 500*10^6 = 5.52

We see that FP processor is faster.
```