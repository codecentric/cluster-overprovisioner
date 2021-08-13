# Overprovisioning Helm Chart

Helm Chart for Overprovisioning an autoscaling Kubernetes Cluster, based on the [Cluster Proportional Autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler) and a cluster overprovisioner which is inspired by [Cluster Overprovisioning Helm Chart](https://github.com/deliveryhero/helm-charts/tree/master/stable/cluster-overprovisioner) from Delivery Hero.

It combines and improves both components, so that cluster-size aware and time-dependent overprovisioning can be achieved.

# TL;DR,
```
helm install codecentric/cluster-overprovisioner
```

## Part I: Cluster Proportional Austoscaler
The Cluster Proportional Autoscaler is used to scale a target ressource based on the cluster size. It is able to consider number of schedulable nodes or number of available cores. It provides two different methods to calculate the desired replica count - `ladder` and `linear`. For further information and examples, please head over to the [official Github repository](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/tree/master/examples).

### Scheduling
The Cluster Proportional Autoscaler comes with a time-based scheduling feature. This allows changing schedulues for times where load will be generally lower, i.e. night times or weekends. The change is triggered through a cronjob in the Kubernetes cluster. For exampels on how to configure this see the  [Chart-Readme](charts/cluster-overprovisioner/README.md).

## Part II: Overprovisioning Deployment
To achieve the desired overprovisioning, a second component - called overprovisioner - can be installed with this Helm chart. It is a deployment based on pods with a pause image and a very low priority class and a configurable amount of ressources to be reserved. These pods will be evicted, as soon as a new Pod with a higher priority assigned will be scheduled. For more detailed information, on how the overprovisiong works and interacts with the Cluster Proportional Autoscaler, see (here)[#how-does-op-work] or (ENTER BLOG ARTICLE HERE). The image of the pause pod can of cause be replaced with any other image desired.

# Adaptations and Improvements
## Newly introduced features
* Scheduled config changes which allow time-based workloads, i.e. no activity at night.
* Add support for RBAC / PSP.
* Add Cronjob for scheduled overprovisioning.
* Add support for more control patterns.
* Add securityContext to default values.

# Values
Please refer to the [Chart-Readme](charts/cluster-overprovisioner/README.md) for information about configuring and deploying the Helm chart.
