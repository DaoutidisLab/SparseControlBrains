# Internal Control of Brains Networks via Sparse Feedback

This repository has the necessary code to generate the results in the following paper:

Mitrai, I., Jones, V., Dewantoro, H., Stamoulis, C., Daoutidis P., Internal control of brain networks via Sparse feedback

The repository has the following files:

 - `analyze_structural_network_final_code.m`: This file solves the sparsity promoting optimal controller synthesis problem for the structural brain networks
 - `analyze_functional_network.m`: This file solves the sparsity promoting optimal controller synthesis problem for the functional brain networks
 - `parallel_run.m`: This file solves the sparsity promoting optimal controller synthesis problem in parallel for multiple functional brain networks
 - `list_connectomes`: List of the functional brain networks (connectomes) analyzed


This code requires the following data and packages:

Data: [Structural brain networks](https://complexsystemsupenn.com/s/NCTfMRI30SubScale60_ROI_volcorrected.mat) 

Software: [LQRSP – Sparsity-Promoting Linear Quadratic Regulator](http://www.ece.umn.edu/users/mihailo/software/lqrsp/)

## Structural network
If you want to run LQRSP for the structural brain networks run the file: `analyze_structural_network_final_code.m`

## Functional network
To run LQRSP for one functional brain network first you must import the adjacency matrix `A` and then define the options for the sparse controller synthesis problem. The options are: (see [LQRSP](http://www.ece.umn.edu/users/mihailo/software/lqrsp/) for detailed information)
1. `method`: This determines the penalty function in the LQRSP. We use the 'card', i.e., number of nonzero entries in the feedback gain matrix K. See [LQRSP](http://www.ece.umn.edu/users/mihailo/software/lqrsp/) website for other options.
2. `gamval`: Values of the penalty parameters (i.e. feedback cost) for which the control problem should be solved.
3. `rho`: This is a penalty parameter for the solution of the LQRSP problem (Augmented Lagrangian parameter). See [LQRSP](http://www.ece.umn.edu/users/mihailo/software/lqrsp/) for more information. Note this is different than the feedback cost parameter `gamval`.
4. `maxiter`: Maximum number of iterations for the algorithm that is used to solve the LQRSP problem.
5. `blksize`: This parameter is relevant only if the controller must have a specific number of blocks and is used only if the `method` is `blkcard`, `blkl1`, `blkwl1`, `blkslog`. See [LQRSP](http://www.ece.umn.edu/users/mihailo/software/lqrsp/) for detailed information.

An example is the following:
```
p_low = 8.5; # lower value of penalty parameter
p_up = 11; # upper value of the penalty parameter
Npts = 11: # Number of discretization points for the penalty parameter
# define the discretization of the pealty parameter 
p_val = linspace(8.5,11,11); 
# Note you can also use linspace or you can define your own set of parameter such as p_val = [1,2,3];

# Define the options for LQRSP
options = struct('method','card','gamval',p_val ,'rho',100,'maxiter',1000,'blksize',[1]);
```
Once the options for LQRSP are defined then the following code can be used to get the results:
```
results = analyze_functional_networks(A, options)
```
The output of this command is "results" which is a struct data format. More more details on the fields see the `analyze_functional_network.m` file.

If you want to use parallel computing to analyze multiple brains simultaneously then run the `parallel_run.m` file. The output of this file is a struct which has the LQRSP results for every brain. See the `parallel_run.m` file for more details. 

