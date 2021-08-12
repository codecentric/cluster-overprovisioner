# Overprovisioning Helm Chart

Helm Chart for Overprovisioning an autoscaling Kubernetes Cluster, based on the [Cluster Proportional Autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler) and the [Cluster Overprovisioning Helm Chart](https://github.com/deliveryhero/helm-charts/tree/master/stable/cluster-overprovisioner) from Delivery Hero.

It combines and improves both components, so that cluster-size aware and time-dependent overprovisioning can be achieved.

## Part I: Cluster Proportional Austoscaler
The Cluster Proportional Autoscaler is used to scale a target ressource based on the cluster size. It is able to consider number of schedulable nodes or number of available cores. It provides two different methods to calculate the desired replica count - `ladder` and `linear`. For further information and examples, please head over to the [official Github repository](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/tree/master/examples).

## Part II: Overprovisioning Deployment
To achieve the desired overprovisioning, a second component - called placeholder - can be installed with this helm chart. It is a Deployment based on Pods with an Pause Image and a very low priority class and a configurable amount of ressources to be reserved. These pods will be evicted, as soon as a new Pod with a higher priority assigned will be scheduled. For more detailed information, on how the overprovisiong works and interacts with the Cluster Proportional Autoscaler, see (here)[#how-does-op-work] or (ENTER BLOG ARTICLE HERE).


# Adaptations and Improvements
## Newly introduced features
* Scheduled config changes which allow time-based workloads, i.e. no activity at night.

## Improvements
* Add support for RBAC / PSP.
* Add Cronjob for scheduled Overprovisioning.
* Add support for more control patterns.

## Constraints
* Currently the Helm chart just supports the ladder mode as a control pattern for the Cluster Proportional Autoscaler.