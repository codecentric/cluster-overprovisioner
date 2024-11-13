# Overprovisioning Helm Chart

Helm Chart for overprovisioning an autoscaling Kubernetes Cluster, based on the [Cluster Proportional Autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler) and a deployment, that's acting as a "placeholder" for overprovisioning which is inspired by [Cluster Overprovisioning Helm Chart](https://github.com/deliveryhero/helm-charts/tree/master/stable/cluster-overprovisioner) from Delivery Hero.

It combines both components into a single solution, so that cluster-size aware and time-dependent overprovisioning can be achieved.

> Note: To read more about our use-case, using this Helm-Chart to speed up your CI/CD jobs, take a look at [our blog post](https://blog.codecentric.de/en/2021/09/ci-cd-jobs-speed-up-in-kubernetes/).

## Prerequisites
To use this Chart in your cluster, you need:
* an autoscaling k8s setup, for example using the [cluster-autoscaler](https://github.com/kubernetes/autoscaler/tree/master/cluster-autoscaler)
* Helm v3 installed

### TL;DR
```
helm install codecentric/cluster-overprovisioner
```

## Component I: Cluster Proportional Autoscaler
The Cluster Proportional Autoscaler is used to scale a target ressource based on the cluster size. It is able to consider number of schedulable nodes or number of available cores. It provides two different methods to calculate the desired replica count - `ladder` and `linear`. For further information and examples, please head over to the [official Github repository](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler/tree/master/examples).

## Component II: Overprovisioning Deployment
To achieve the desired overprovisioning, a second component - called overprovisioner - can be installed with this Helm chart. It is a deployment based on pods with a pause image and a very low priority class and a configurable amount of ressources to be reserved. These pods will be evicted, as soon as a new Pod with a higher priority assigned will be scheduled. Per default, the chart installs a default PriorityClass and an overprovisioning PriorityClass, that is assigned to the Pods of the overprovisioning deployment. 
For more detailed information, on how the overprovisiong works and interacts with the Cluster Proportional Autoscaler, see [here](#how-does-overprovisioning-work). 

> Note: The image of the pause pod can of cause be replaced with any other image desired. It is also possible, to use your resource and disable the default op-deployment.

### How does overprovisioning work
To achieve overprovisioning, you need some sort of placeholder in your cluster, that requests a certain amount of ressources. 

## Additional Features / Improvements
In addition to the functionality introduced by the components above, this charts adds the possibility to use different overprovisioning configurations based on cron-schedules.

### Scheduling
The time-based scheduling feature uses Cronjobs, to replace the active configuration of the `Cluster Proportional Autoscaler`. This allows reducing the amount of overprovisioning for times where load will be lower or startup times of pods are irrelevant, i.e. night times or weekends. 

For examples on how to configure scheduling, see the [examples folder](examples/), the comments in the [values.yaml](values.yaml) or the [Chart-Readme](charts/cluster-overprovisioner/README.md).

# Helm Chart configuration
Please refer to the [Chart-Readme](charts/cluster-overprovisioner/README.md) for information on how to configure and deploy this chart.
