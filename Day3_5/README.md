# RISCVMYTH

# RISC-V based Microprocessor

This repository contains all the information needed to build your RISC-V pipelined core, which has support of base interger RV32I instruction format using TL-Verilog on makerchip platform.

# Table of Contents

- [Digital Logic with TL-Verilog and Makerchip](#digital-logic-with-tl-verilog-and-makerchip)
  - [Combinational logic](#combinational-logic)
  - [Sequential logic](#sequential-logic)
  - [Pipelined logic](#pipelined-logic)
  - [Validity](#validity)

- [Basic RISC-V CPU micro-architecture](#basic-risc-v-cpu-micro-architecture)
  - [Fetch](#fetch)
  - [Decode](#decode)
  - [Register File Read and Write](#register-file-read-and-write)
  - [Execute](#execute)
  - [Control Logic](#control-logic)
- [Pipelined RISC-V CPU](#pipelined-risc-v-cpu)
  - [Pipelinig the CPU](#pipelining-the-cpu)
  - [Load and store instructions and memory](#load-and-store-instructions-and-memory)
  - [Completing the RISC-V CPU](#completing-the-risc-v-cpu)
- [Acknowledgements](#acknowledgements)


# Digital Logic with TL-Verilog and Makerchip

[Makerchip](https://makerchip.com/) is a free online environment for developing high-quality integrated circuits. You can code, compile, simulate, and debug Verilog designs, all from your browser. Your code, block diagrams, and waveforms are tightly integrated.

All the examples shown below are done on Makerchip IDE using TL-verilog. Also there are other tutorials present on IDE which can be found [here](https://makerchip.com/sandbox/) under Tutorials section.

## Combinational logic

Starting with basic example in combinational logic is an inverter. To write the logic of inverter using TL-verilog is `$out = ! $in;`. There is no need to declare `$out` and `$in` unlike Verilog. There is also no need to assign `$in`. Random stimulus is provided, and a warning is produced. 
  ### 1. [Full Adder](Day3/FullAdder.tlv)
  
![image](https://user-images.githubusercontent.com/55539862/170281859-4988981e-725f-4ff0-b9c7-c717476a5ec1.png)


 ### 2. [Combinational Calculator](Day3/CombinationalCalculator.tlv)
 
Below is snapshot of Combinational Calculator.

![image](https://user-images.githubusercontent.com/55539862/170273193-de277a9e-0317-4f60-a707-6223fa56c9bf.png)

## Sequential logic



Starting with basic example in sequential logic is Fibonacci Series with reset. To write the logic of Series using TL-Verilog is `$num[31:0] = $reset ? 1 : (>>1$num + >>2$num)`. This operator `>>?` is ahead of operator which will provide the value of that signal 1 cycle before and 2 cycle before respectively.

## 1. [Counter](Day3_5/Counter.v)
![image](https://user-images.githubusercontent.com/55539862/170286213-349fb881-532a-440d-a27e-a1456aa4b3ae.png)



## 2. [Sequential Calculator](Day3_5/Sequential_Calculator.v)
Below is snapshot of Sequential Calculator which remembers the last result, and uses it for the next calculation.
![image](https://user-images.githubusercontent.com/55539862/170290045-ba11ea20-2670-4cfa-902d-9133c1cd271d.png)

## [Pipelined logic](Day3_5/Cycle_Calculator.tlv)

Timing abstract powerful feature of TL-Verilog which converts a code into pipeline stages easily. Whole code under `|pipe` scope with stages defined as `@?`

Below is snapshot of 2-cycle calculator which clears the output alternatively and output of given inputs are observed at the next cycle.

![image](https://user-images.githubusercontent.com/55539862/170309779-95b0bfa8-5e21-4290-9659-02d92158becb.png)


## [Validity](Day3_5/Cycle_Calculator_Validity.tlv)

Validity is TL-verilog means signal indicates validity of transaction and described as "when" scope else it will work as don't care. Denoted as `?$valid`. Validity provides easier debug, cleaner design, better error checking, automated clock gating.

Below is snapshot of 2-cycle calculator with validity. 

![image](https://user-images.githubusercontent.com/55539862/170338671-9b0110b1-3172-451d-b3bf-bd013303c678.png)
# Basic RISC-V CPU micro-architecture

Designing the basic processor of 3 stages fetch, decode and execute based on RISC-V ISA.

## [Next PC Logic](/Day3_5/Next_PC.tlv)
![image](https://user-images.githubusercontent.com/55539862/170537490-992a875a-7f7e-4b72-9d07-d80785495767.png)

## [Fetch](Fetch.tlv)

* Program Counter (PC): Holds the address of next Instruction
* Instruction Memory (IM): Holds the set of instructions to be executed

During Fetch Stage, processor fetches the instruction from the IM pointed by address given by PC.

Below is snapshot from Makerchip IDE after performing the Fetch Stage.
![image](https://user-images.githubusercontent.com/55539862/170549506-7dcc03de-d888-4443-8b17-f46241f51a47.png)



## [Decode](Decode.tlv)

6 types of Instructions:
  * R-type - Register 
  * I-type - Immediate
  * S-type - Store
  * B-type - Branch (Conditional Jump)
  * U-type - Upper Immediate
  * J-type - Jump (Unconditional Jump)

Instruction Format includes Opcode, immediate value, source address, destination address. During Decode Stage, processor decodes the instruction based on instruction format and type of instruction.

Below is snapshot from Makerchip IDE after performing the Decode Stage.
![image](https://user-images.githubusercontent.com/55539862/170550428-23ac15d2-451d-4d63-b120-699e7481cf4e.png)



## [Register File Read and Write](Register_File_Read.tlv)

Here the Register file is 2 read, 1 write means 2 read and 1 write operation can happen simultanously.

Inputs:
  * Read_Enable   - Enable signal to perform read operation
  * Read_Address1 - Address1 from where data has to be read 
  * Read_Address2 - Address2 from where data has to be read 
  * Write_Enable  - Enable signal to perform write operation
  * Write_Address - Address where data has to be written
  * Write_Data    - Data to be written at Write_Address

Outputs:
  * Read_Data1    - Data from Read_Address1
  * Read_Data2    - Data from Read_Address2

Below is snapshot from Makerchip IDE after performing the Register File Read followed by Register File Write.

![image](https://user-images.githubusercontent.com/55539862/170552485-37f40413-7b42-4f31-977f-69784f1abdc9.png)

![image](https://user-images.githubusercontent.com/55539862/170554784-f053a7c2-ca33-47ae-9f58-c530e17c4cae.png)

## [Execute](ALU.tlv)

During the Execute Stage, both the operands perform the operation based on Opcode.

Below is snapshot from Makerchip IDE after performing the Execute Stage.

![image](https://user-images.githubusercontent.com/55539862/170557069-b68ec260-3bbd-4f26-ac05-e6ef816564d1.png)

## [Control Logic](Branches.tlv)

During Decode Stage, branch target address is calculated and fed into PC mux. Before Execute Stage, once the operands are ready branch condition is checked.

Below is snapshot from Makerchip IDE after including the control logic for branch instructions.

![image](https://user-images.githubusercontent.com/55539862/170557581-89513a5e-1a4d-4fbc-8a0a-4e8797446623.png)
# Pipelined RISC-V CPU

Converting non-piepleined CPU to pipelined CPU using timing abstract feature of TL-Verilog. This allows easy retiming wihtout any risk of funcational bugs. More details reagrding Timing Abstract in TL-Verilog can be found in IEEE Paper ["Timing-Abstract Circuit Design in Transaction-Level Verilog" by Steven Hoover.](https://ieeexplore.ieee.org/document/8119264)

## [Pipelining the CPU](Pipelining_the_CPU.tlv)

Pipelining the CPU with branches still having 3 cycle delay rest all instructions are pipelined. Pipelining the CPU in TL-Verilog can be done in following manner:
```
|<pipe-name>
    @<pipe stage>
       Instructions present in this stage
       
    @<pipe_stage>
       Instructions present in this stage
       
```

Below is snapshot of pipelined CPU with a test case of assembly program which does summation from 1 to 9 then stores to r10 of register file. In snapshot `r10 = 45`. Test case:
```
*passed = |cpu/xreg[10]>>5$value == (1+2+3+4+5+6+7+8+9);
```
![image](https://user-images.githubusercontent.com/55539862/170827725-85054bd4-23fd-4187-96b3-daea2108f835.png)




## [Load and store instructions and memory](Load_Store.tlv)

Similar to branch, load will also have 3 cycle delay. So, added a Data Memory 1 write/read memory.

Inputs:
  * Read_Enable - Enable signal to perform read operation
  * Write_Enable - Enable signal to perform write operation
  * Address - Address specified whether to read/write from
  * Write_Data - Data to be written on Address (Store Instruction)

Output: 
  * Read_Data - Data to be read from Address (Load Instruction)

Added test case to check fucntionality of load/store. Stored the summation of 1 to 9 on address 4 of Data Memory and loaded that value from Data Memory to r17.
```
*passed = |cpu/xreg[17]>>5$value == (1+2+3+4+5+6+7+8+9);
```
Below is snapshot from Makerchip IDE after including load/store instructions.

![image](https://user-images.githubusercontent.com/55539862/170827669-395d0d5e-3fe8-4b11-9566-7fd8f8b5ad4f.png)
## [Completing the RISC-V CPU](Final.tlv)

Added Jumps and completed Instruction Decode and ALU for all instruction present in RV32I base integer instruction set.

Below is final Snapshot of Complete Pipelined RISC-V CPU.
![image](https://user-images.githubusercontent.com/55539862/170813939-8c0b30ad-16fb-4f54-b22b-d372f45cb7d1.png)



# Acknowledgements
- [Kunal Ghosh](https://github.com/kunalg123), Co-founder, VSD Corp. Pvt. Ltd.
- [Steve Hoover](https://github.com/stevehoover), Founder, Redwood EDA
- [Shivam Potdar](https://github.com/shivampotdar), GSoC 2020 @fossi-foundation
- [Vineet Jain](https://github.com/vineetjain07), GSoC 2020 @fossi-foundation
