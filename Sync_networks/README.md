# Implementation of Consensus Algorithms using doubly-stocahtic weights for Synchronous networks

Synchronous networks are the multi-agent netwroks where each agent is updates their information synchronously to solve a distributed optimization problem.

[pushsum.m](https://github.com/naraharikr/master_thesis/blob/main/Sync_networks/pushsum.m) implements Pushsum consensus algorithm as in **(Section III - B1)**

[subgrad_push.m](https://github.com/naraharikr/master_thesis/blob/main/Sync_networks/subgrad_push.m) implements Subgradient-Push consensus algorithm as in **(Section III - B2)**

[addopt.m](https://github.com/naraharikr/master_thesis/blob/main/Sync_networks/appopt.m) implements ADDOPT/DIGing consensus as in **(Section III - B3)**


*PS: As the thesis is still in the initial stages, the local function "f" at each agent is considered as a Quadratic cost function and impmentation follows the same.  Not distributed logistic regression problem as stated in Section VI - Numerical Results*

<img src="http://latex.codecogs.com/gif.latex?\dpi{110}&space;\textit{f(x)}&space;=&space;\frac{1}{2}\alpha&space;\left&space;(&space;x&space;-&space;x_0\right&space;)^{2}" title="http://latex.codecogs.com/gif.latex?\dpi{110} \textit{f(x)} = \frac{1}{2}\alpha \left ( x - x_0\right )^{2}" />

*x0 = initial value at each agent i (n x 1),*

*n = number of agents*

## Sneakpeak into results 

### Algorithms using Column-stochastic Weights

### Pushsum Consensus

![Push-sum consensus](https://github.com/naraharikr/master_thesis/blob/main/Results/Sync_networks/pushsum_consensus.png)

### Subgradient-Push Consensus

![Subgradient-push consensus](https://github.com/naraharikr/master_thesis/blob/main/Results/Sync_networks/subgradient_push.png)

### ADDOPT/Push-DIGing Consensus

![ADDOPT/Push-DIGing consensus](https://github.com/naraharikr/master_thesis/blob/main/Results/Sync_networks/addopt.png)