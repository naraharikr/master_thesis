# Distributed Optimization: Synchronous Networks

All the algorithms described here, implements consensus algorithms and achieves convergence for given distributed network.  These algorithms are constrained to no-delay scenarious i.e, all the agents are assumed to comuunicate synchronously without any dealy in the information.  Also, the graph topology is time-invariant.

## Algorithms

The following section describes which file does what in breif, in synchronous network setup.

* [`sync_pushsum.m`](sync_pushsum.m) implements pushsum consensus algorithm
* [`sync_subgradpush.m`](sync_subgradpush.m) implements subgradient push consensus algorithm
* [`sync_appopt.m`](sync_appopt.m) implements ADD-OPT consensus algorithm
* [`sync_projsubgrad.m`](sync_projsubgrad.m) implements projected subgradient consensus algorithm
* [`sync_frost.m`](sync_frost.m) implements FROST consensus algorithm


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Convergence Plots

In this secton, we show the convergence plots for all algorithms proposed in above section `Algorithms`

<!-- Push sum and Subgradient-push consensus-->
<p float="middle">
  <img src="../assets/plots/sync_pushsum.png" alt="network" width="500"/>
  <img src="../assets/plots/sync_subgradpush.png" alt="network" width="500"/>
</p>

<!-- ADD-OPT and FROST consensus-->
<p float="middle">
  <img src="../assets/plots/sync_addopt.png" alt="network" width="500"/>
  <img src="../assets/plots/sync_frost.png" alt="network" width="500"/>
</p>


-------------------------------------------------------------------------------------------------------------------------------------------------------------------------
## Residual Plots

The following figure plots the comparision of average mean-square error between ADD-OPT and FROST algorithms.

<!-- Residual plot comparision between ADD-OPT and FROST -->
<p float="middle">
  <img src="../assets/plots/avg_mse_comparision_addopt_frost_sync.png" alt="network" width="550"/>
</p>