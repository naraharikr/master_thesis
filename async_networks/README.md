# Distributed Optimization: Asynchronous Networks

All the algorithms described here, implements consensus algorithms and achieves convergence for given distributed network.  These algorithms are focused on network with dealys i.e, some/all the agents are exchanging inforamtion at different time instances with dealys.  Also, the graph topology is time-variant.

## Algorithms

The following section describes which file does what in breif.

* [`async_appopt.m`](async_appopt.m) implements ADD-OPT consensus algorithm in asynchronous network setup
* [`compute_gradient.m`](compute_gradient) function handle to compute the gradient of function at x

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Convergence Plots

In this secton, we show the convergence plots for all algorithms proposed in above section `Algorithms`






-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Residual plot

The following figure plots the comparision of average mean-square error between ADD-OPT and FROST algorithms.

