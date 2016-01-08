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

### Sample question 2

When a processor executes program PA, the execution time is 3.8 seconds and the CPI is 2.9. When the same processor executes program PB, the execution time is 8.5 seconds and the CPI is 3.7. A typical workload consists of executing PA, then executing PB. What is the CPI for this typical workload?

#### Solution:

### Sample question 3

Consider a processor that achieves an overall average CPI of 3.6 when executing a program P1. 23 % of the instructions of P1 performs floating point operations. For these floating point instructions, the average CPI is 5. By improving the design of the floating point ALU, the average CPI for floating point instructions is reduced from 5 to 3.  
1. What is the overall average CPI for the improved processor? 
2. If the original processor executed P1 in 190 seconds, how long will it take the improved processor to execute P1?

#### Solution:

