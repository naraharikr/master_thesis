# Accelerated Distributed Directed Optimization With Time Delays

In the presented work, we study the distributed optimization over directed graphs with row-stochastic weights as each agent need not know of its out-neighbors, which is not practical in real-world applications.  In general,  the information exchange between the agents are asynchronous and hence we keep the main focus on asynchronous networks, i.e., network with delays in the communication. ADD-OPT is proven to linearly converge to optimal value when the weight matrix is column-stochastic, and on the other hand, the FROST algorithm is best and converges faster than the previous one with row-stochastic weights.  In simple words, FROST is better than ADD-OPT in convergence and more practical for real-world problems.  The contribution of the present work is to implement the asynchronous versions for ADD-OPT and FROST and to study the convergence results for better performance and convergence.

## Problem Formulation & Quadractic Cost

In the presented distributed network, *n* agents caters to solve a distributed problem in `P1`.

<p align="center"">
  <img src="https://latex.codecogs.com/gif.latex?\textbf{P1}:&space;\quad\underset{\mathbf{x}}{\min}&space;F(\mathbf{x})\triangleq\frac{1}{n}\sum\limits_{i=1}^{n}f_{i}(\mathbf{x})" title="\textbf{P1}: \quad\underset{\mathbf{x}}{\min} F(\mathbf{x})\triangleq\frac{1}{n}\sum\limits_{i=1}^{n}f_{i}(\mathbf{x})" />
</p>

where each agent locally solves private cost function *fi(x)* and communicates to it's out neighbours to find the global minimizer of aggregate cost *F(x)*

The private cost function used at each agent is a `Distributed Quadratic cost function` defined as,

<p align="center"">
  <img src="https://latex.codecogs.com/gif.latex?f_i(x)&space;=&space;\frac{1}{2}{\alpha}_i(x-{\rho}_i)^{2}" title="f_i(x) = \frac{1}{2}{\alpha}_i(x-{\rho}_i)^{2}" />
</p>

### Research Objectives

The outputs of the research are to study,
1. convergence of `ADD-OPT`and `FROST` algorithms in case of synchronous networks (network with no delays and no switchings)
2. implementation of `ADD-OPT` and `FROST` algorithms in case of asynchronous networks (network with delays and switchings)
3. compare residual plots in case of different delays in the network and discuss the results
3. compare the `Average MSE` of FROST and ADD-OPT in case of asynchronous networks

### System Requirements

The algorithms are developed with `MATLAB (R2020b)` and tested on `Windows`platform. `MATLAB` is sufficient enough for the execution of the scripts, preferably `R2020a` or `R2020b`.  The back-compatibility has not been tested if you're using the previous version of the software.  Also, the evaluation of algorithms has been tested only on the Windows platform at the moment.  

In case of any issues, kindly reach me at `narahari.kasagattaramesh@aalto.fi`




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Folder structure

The project is organized into three folders, namely:

* `sync_networks` contains implementation of `push-sum`, `subgradient-push`, `ADD-OPT`,` Projected Subgradient`and `FROST` algorithms with synchronous networks
* `async_networks` contains an implementation of `ADD-OPT` and `FROST` algorithms with asynchronous networks
* `triton_scripts` contains an testscripts and logs of ADD-OPT with delay networks for 28 step-sizes with 10 delays for each
* `assets` contains `plots` containing convergence and residual plots (.png format) & matlab workspace variables are stored in `matvar`

## Scripts

The following section describes the `.m` files and `function`s used in the project.

* [`compare_residual_plots.m`](compare_residual_plots) script generating residual plot comparision
* [`compute_gradient.m`](compute_gradient) function handle to compute the gradient of function at x
* [`compute_residual.m`](compute_residual) function handle to compute the average mean-square-error for any algorithm

### Running algorithms

Change the working directory to the path where code is stored and run the required `.m` file.




-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## DISCLAIMER
This is an ongoing part of my Master Thesis at Aalto University.  The Master thesis is being supervised by [Themistoklis Charalambous](https://themistoklis.org/), Associate Professor, Aalto University.  Also, he heads [Distributed and Networked Control Systems](https://www.aalto.fi/en/department-of-electrical-engineering-and-automation/distributed-and-networked-control-systems) research group, which focuses on blending control theory, communication theory and information theory.  

I am being part of the research group for my master thesis which focuses primalrily to reproduce the distributed optimisation algorithms proposed in research paper as mentioned in `Reference Work` and to extend the implementaion of `ADD-OPT (Section III-B3)` and `FROST (Section IV-A)` for time-varying graphs with delays, with switchings, and both delays & switchings.

### Reference Work

Xin, R., Xi, C. & Khan, U. [`FROST—Fast row-stochastic optimization with uncoordinated step-sizes`](https://doi.org/10.1186/s13634-018-0596-y). EURASIP J. Adv. Signal Process. 2019, 1 (2019)
