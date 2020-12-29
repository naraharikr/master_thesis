# Implementation of Algorithms using doubly-stocahtic weights for Synchronous networks

Synchronous networks are the multi-agent netwroks where each agent is updates their information synchronously to solve a distributed optimization problem.

To implement the algorithms, run "sync_networks.m"

The <sync_networks.m> contains following algorithms.

**Option 1: Push-sum consensus (Section III - B1)**

**Option 2: Subgradient-Push  (Section III - B2)**

**Option 3: ADD-OPT/Push-DIGing (Section III - B3)**


*PS: As the thesis is still in the initial stages, the local function "f" at each agent is considered as a Quadratic cost function and impmentation follows the same.  Not distributed logistic regression problem as stated in Section VI - Numerical Results*

<img src="https://latex.codecogs.com/gif.latex?f&space;=&space;\frac{1}{2}\left&space;\|x&space;-&space;x_0\right&space;\|^{2}" title="f = \frac{1}{2}\left \|x - x_0\right \|^{2}" />

*x0 = initial value at each agent i (n x 1),*

*n = number of agents*

