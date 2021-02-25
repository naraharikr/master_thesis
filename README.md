# Distributed Coordination over Directed graphs using Row-stochastic weights

In the presented work, we study the distributed optimization over directed graphs with row-stochastic weights as each agent need not have knowledge of it's out-neighbours, which is not practical in real-world applications.  In general,  the information exchange between the agents are asynchronous and hence we keep the main focus on asynchronous networks, i.e., network with dealys in the communication. ADD-OPT is a proven to linearly converge to optimal value when the weight matrix is column-stochastic, and on the other hand FROST algorithm is best and converges faster than previous one with row-stochastic weights.  In simple words, FROST is better than ADD-OPT in convergence and more practical for real-world problems.  The contribution of present work is to implement the asynchronous versions for ADD-OPT and FROST, and to study the convergence results for better performance and convergence.

## Problem Formulation & Quadractic Cost

In the presented distributed network, *n* agents caters to solve a distributed problem in `P1`.

```math
\text{P1}: \quad\underset{\mathbf{x}}{\min} F(\mathbf{x})\triangleq\frac{1}{n}\sum\limits_{i=1}^{n}f_{i}(\mathbf{x}),
```

where each agent locally solves private cost function $`f_i(x)`$ and communicates to it's out neighbours to find the global minimizer of aggregate cost, $`F(x)`$.

The private cost function $`f_i(x)`$ used at each agent is a `Distributed Quadratic cost function` defined as,

```math
f_i(x) = \frac{1}{2}{\alpha}_i(x-{\rho}_i)^{2}
```
### Research Objectives

The ouputs of the reserach is to study,
1. convergence of `ADD-OPT`and `FROST` algorithms in case of synchronous networks
2. extending implementation of both with asynchronous networks and plot the convergence
3. compare the `Average MSE` of FROST and ADD-OPT in case of asynchronous networks and delays

### System Requirements

The algorithms are developed with `MATLAB (R2020b)` and tested on `Windows`platform. `MATLAB` is sufficeint enough for execution of the scripts, preferably `R2020a` or `R2020b`.  The back compatibility has not been done, if you're using previous version of the software.  Also, evaluation of algorithms has been tested only on Windows platform at the moment.  In case of issues in Linux or MAC kindly raise the query or [`contact me`](narahari.kasagattaramesh@aalto.fi) 


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Folder structure

* [`sync_networks`] contains implementation of `push-sum`, `subgradient-push`, `ADD-OPT`,` Projected Subgradient`and `FROST` algorithms with synchronous networks
* [`async_networks`] contains implementation of `ADD-OPT` and `FROST` algorithms with asynchronous networks
* [`assests`] contains plots and figures in .eps and .png formats

**NOTE: Out of above algorithms pushsum, subgradient-push, ADD-OPT needs column-stochastic weight matrix, while projected subgradient and FROST uses row-stochastic weights.  This information is also available in each `.m` file.  Be careful to check these requirements if you change weight matrix.**

### Algorithms

The following section describes which file does what in breif.

**Synchronous Networks**
* [`sync_pushsum.m`](sync_networks/sync_pushsum.m) implements pushsum consensus algorithm in synchronous network setup *(weight matrix should be column-stochastic)*
* [`sync_subgradpush.m`](sync_networks/sync_subgradpush.m) implements subgradient push consensus algorithm in synchronous network setup *(weight matrix should be column-stochastic)*
* [`sync_appopt.m`](sync_networks/sync_appopt.m) implements ADD-OPT consensus algorithm in synchronous network setup *(weight matrix should be column-stochastic)*
* [`sync_projsubgrad.m`](sync_networks/sync_projsubgrad.m) implements projected subgradient consensus algorithm in synchronous network setup *(weight matrix should be row-stochastic)*
* [`sync_frost.m`](sync_networks/sync_frost.m) implements FROST consensus algorithm in synchronous network setup *(weight matrix should be row-stochastic)*

**Asynchronous Networks**
* [`async_appopt.m`](async_networks/async_appopt.m) implements ADD-OPT consensus algorithm in asynchronous network setup *(weight matrix should be column-stochastic)*


### Running algorithms

Change the working directory to the path where code is stored and run the required `.m` file.

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
### Disclaimer
This is an ongoing part of my Master Thesis at Aalto University.  The Master thesis is being supervised by [`Themistoklis Charalambous`](https://themistoklis.org/), `Associate Professor, Aalto University`.  Also, he heads [`Distributed and Networked Control Systems`](https://www.aalto.fi/en/department-of-electrical-engineering-and-automation/distributed-and-networked-control-systems) research group, which focuses on blending control theory, communication theory and information theory.  The master thesis focuses primalrily to reproduce the distributed optimisation algorithms proposed in research paper as mentioned in `Reference Work`.

### Reference Work

The aim to study `Xin, R., Xi, C. & Khan, U. [FROST—Fast row-stochastic optimization with uncoordinated step-sizes](https://doi.org/10.1186/s13634-018-0596-y). EURASIP J. Adv. Signal Process. 2019, 1 (2019)` reserach journal and implment `Section B-III` and `Section IV-A`, which is ADD-OPT and FROST algorithms for synchronous networks respectively.  

Implementation of same algorithms to asynchronous networks would be an extension to this work.  Also, it will be the novel contribution to master thesis.