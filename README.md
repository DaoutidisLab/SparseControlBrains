# Internal Control of Brains Networks via Sparse Feedback

This repository has the code necessary to generate the results in the following paper:

Mitrai, I., Jones, V., Dewantoro, H., Stamoulis, C., Daoutidis P., Internal control of brain networks via Sparse feedback

The repository has two Matlab files:

 - analyze_structural_network_final_code.m: This file solves the Sparsity promoting optimal controller Synthesis problem for the structurak brain networks
 - analyze_functional_network.m: This file solves the Sparsity promoting optimal controller Synthesis problem for the functional brain networks


This code requires the following data and packages:

Data: 
- [Structural brain networks](https://complexsystemsupenn.com/s/NCTfMRI30SubScale60_ROI_volcorrected.mat) 

Software:
- [LQRSP – Sparsity-Promoting Linear Quadratic Regulator](http://www.ece.umn.edu/users/mihailo/software/lqrsp/)

# Structural network
If you wnat to run LQRSP for the structural brains run the file: analyze_structural_network_final_code

# Functional network
To run LQRSP for one brain first you must import the adjacency matrix A and then run
```
results = analyze_functional_network(A)
```
The output of this command is "results" which is a struct. More more details on the fields see the analyze_functional_network.m file.


If you want to use a cluster or a high performance computer run:
```
sbatch -p <partition name> --array=1-30 parallel_runs
```
