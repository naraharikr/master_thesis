# Implementation of Distributed consensus using row stocahtic weights and synchronous update of states

Synchronous networks are the multi-agent netwroks where each agent is updates their information synchronously to solve a distributed optimization problem.

[projected_subgrad.m](https://github.com/naraharikr/master_thesis/blob/main/row_stochastic_algorithms/projected_subgrad.m) implements Projected subgradient consensus algorithm as in **(Section IV - Eq.(9a)-(9b))**


## Sneakpeak into results 

### Algorithms using Row-stochastic Weights

### Projected Subgradient Consensus

![Projected Subgradient consensus](https://github.com/naraharikr/master_thesis/blob/main/Results/row_stochastic/projected_subgrad.png)



*PS: As the thesis is still in the initial stages, the local function "f" at each agent is considered as a Quadratic cost function and impmentation follows the same.  Not distributed logistic regression problem as stated in Section VI - Numerical Results*

<img src="http://latex.codecogs.com/gif.latex?\dpi{110}&space;\textit{f(x)}&space;=&space;\frac{1}{2}\alpha&space;\left&space;(&space;x&space;-&space;x_0\right&space;)^{2}" title="http://latex.codecogs.com/gif.latex?\dpi{110} \textit{f(x)} = \frac{1}{2}\alpha \left ( x - x_0\right )^{2}" />

*x0 = initial value at each agent i (n x 1),*

*n = number of agents*