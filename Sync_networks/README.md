# Implementation of Algorithms using doubly-stocahtic weights for Synchronous networks

Synchronous networks are the multi-agent netwroks where each agent is updates their information synchronously to solve a distributed optimization problem.

To implement the algorithms, run "sync_networks.m"

The "sync_networks.m" contains following algorithms.

*Option 1: Push-sum consensus (Section III - B1)*
*Option 2: Subgradient-Push  (Section III - B2)*
*Option 3: ADD-OPT/Push-DIGing (Section III - B3)*


*PS: As the thesis is still in the initial stages, the local function "f" at each agent is considered as a Quadratic cost function and impmentation follows the same.  Not distributed logistic regression problem as stated in Section VI - Numerical Results*

				f = 1/2 ||x - x0||^2

*x0 = initial value at each agent i (n x 1)*
*n = number of agents*

*Please provide proper acknowledgment of all uses of this code.*

