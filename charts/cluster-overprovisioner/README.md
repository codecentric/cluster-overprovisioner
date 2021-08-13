# cluster-overprovisioner
Helm chart, that enables scheduled scaling of a target resource, intended to be add overprovisioning to an autoscaling k8s cluster.

## Use the Chart

```bash
# Add Chart Repo
helm repo add codecentric https://codecentric.github.io/cluster-overprovisioner
helm repo update

# Install the Chart with default values
helm install my-release codecentric/cluster-overprovisioner
```

## Configure CPA

The cluster-proportional autoscaler deployed with this chart is configured using configmaps. It comes with a dummy default configuration:
```yaml
ladder:
  {
    "nodesToReplicas":
      [
        [0, 1],  # if you have up to 4 nodes, scale resource to 1 replica
        [5, 2],  # if you have less than 10 nodes but more than 4, scale resource to 2 replica
        [10, 3]  # if more than 11 nodes, scale resource to 3 replica
      ]
  }
```
Please adapt this config to your needs.

Please see the [cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#control-patterns-and-configmap-formats) docs for more information on the individual modes.

### configure-schedules
If you need time-dependent configuration, you can use the `schedules`:
```yaml
schedules:
- name: night
  cronTimeExpression: "0 16 * * 1-5"  # disable overprovisioning Monday - Friday from 6pm
  config:
    ladder:
      {
        "nodesToReplicas":
          [
            [0, 0]
          ]
      }
```

For every schedule a cronjob is created, that replaces the active config with the config from the schedule.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cpa.affinity | object | `{}` | PodAffinity of the cpa Pod |
| cpa.extraArgs[0] | string | `"--logtostderr=true"` <br /> `"--v=2"` | Additional args for the cpa (refer to [cluster-proportional-autoscaler/README.md](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#readme) for more information) |
| cpa.fullnameOverride | string | `""` |  |
| cpa.image.pullPolicy | string | `"IfNotPresent"` | ImagePullPolicy |
| cpa.image.repository | string | `"freddyfroehlich/cpa-dirty"` | Name of the image to be used for cpa (\<repo>/\<image>) |
| cpa.image.tag | string | `"latest"` | Docker tag |
| cpa.imagePullSecrets | list | `[]` | PullSecrets, if pulling from a private registry |
| cpa.nameOverride | string | `""` |  |
| cpa.nodeSelector | object | `{}` | NodeSelector of the cpa Pod |
| cpa.podAnnotations | object | `{}` | Annotations to add to the cpa Pod |
| cpa.podSecurityContext.fsGroup | int | `1000` |  |
| cpa.podSecurityContext.runAsGroup | int | `1000` |  |
| cpa.podSecurityContext.runAsUser | int | `1000` |  |
| cpa.rbac.create | bool | `true` | Specifies whether RBAC-Ressources should be created |
| cpa.rbac.podSecurityPolicy.enabled | bool | `false` | Specifies whether a PSP should be created |
| cpa.resources.limits.cpu | string | `"100m"` | CPU Limit for cpa-Pod |
| cpa.resources.limits.memory | string | `"128Mi"` | Memory Limit for cpa-Pod |
| cpa.securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation |
| cpa.securityContext.capabilities.drop[0] | string | `"ALL"` | Capabilities to drop |
| cpa.securityContext.privileged | bool | `false` | Run pod privileged |
| cpa.securityContext.readOnlyRootFilesystem | bool | `true` | Mount FS read-only |
| cpa.securityContext.runAsNonRoot | bool | `true` | Run pod as non-root user |
| cpa.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| cpa.serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| cpa.serviceAccount.automountServiceAccountToken | bool | `true` | Mount ServiceAccount-Token (true, because cpa accesses kube-api) |
| cpa.serviceAccount.name | string | `""` | Name of the Service Account to use |
| cpa.target.name | string | `Defaults to the op-deployment, if enabled.` | Name of the scalable-resource, that should be scaled by the cpa. Must be in form of `<resource-type>/<resource-name>` |
| cpa.target.namespace | string | `Default to the op-namespace, if enabled.` | Namespace of the target resource |
| cpa.tolerations | list | `[]` | Tolerations of the cpa Pod |
| op.enabled | bool | `true` | Specifies, whether the default overprovisioning Deployment should be used. |
| op.affinity | object | `{}` | PodAffinity of the cpa Pod |
| op.fullnameOverride | string | `""` |  |
| op.image.pullPolicy | string | `"IfNotPresent"` | ImagePullPolicy |
| op.image.repository | string | `"k8s.gcr.io/pause"` | Image of the overprovisioning deployment |
| op.image.tag | string | `"3.2"` | Docker tag |
| op.imagePullSecrets | list | `[]` | PullSecrets, if pulling from a private registry |
| op.nameOverride | string | `""` |  |
| op.nodeSelector | object | `{}` | NodeSelector of op Pod |
| op.podAnnotations | object | `{}` | Annotations to add to the op Pod |
| op.podSecurityContext.fsGroup | int | `1000` |  |
| op.podSecurityContext.runAsGroup | int | `1000` |  |
| op.podSecurityContext.runAsUser | int | `1000` |  |
| op.priorityClasses.default.enabled | bool | `false` | Specifies, whether a default priorityClass should be created |
| op.priorityClasses.default.name | string | `"default"` | Name of the default priorityClass |
| op.priorityClasses.default.value | int | `0` | Priority of the default priorityClass |
| op.priorityClasses.overprovision.name | string | `"overprovision"` | Name of the overprovisioning priorityClass |
| op.priorityClasses.overprovision.value | int | `-1` | Priority of the default priorityClass (intended to by lower than `op.priorityClasses.default.value`) |
| op.rbac.podSecurityPolicy.enabled | bool | `false` | Specifies whether a PSP should be created |
| op.resources | object | `{}` | Resource-information for the op Deployment |
| op.securityContext.allowPrivilegeEscalation | bool | `false` | Allow privilege escalation |
| op.securityContext.capabilities.drop[0] | string | `"ALL"` | `"ALL"` | Capabilities to drop |
| op.securityContext.privileged | bool | `false` | Run pod privileged |
| op.securityContext.readOnlyRootFilesystem | bool | `true` | Mount FS read-only |
| op.securityContext.runAsNonRoot | bool | `true` | Run pod as non-root user |
| op.serviceAccount.create | bool | `true` | Specifies whether a service account should be created |
| op.serviceAccount.annotations | object | `{}` | Mount ServiceAccount-Token (true, because cpa accesses kube-api)|
| op.serviceAccount.automountServiceAccountToken | bool | `false` | Annotations to add to the service account |
| op.serviceAccount.name | string | `""` | Name of the Service Account to use  |
| op.tolerations | list | `[]` | Tolerations of the cpa Pod |
| cronJob.failedJobsHistoryLimit | int | `1` | Specifies, how many failed Jobs should be kept |
| cronJob.image.pullPolicy | string | `"Always"` | ImagePullPolicy |
| cronJob.image.repository | string | `"ghcr.io/codecentric/cluster-overprovisioner-helper"` | Image used to executed the cronjob |
| cronJob.image.tag | string | `"latest"` | Docker tag |
| cronJob.successfulJobsHistoryLimit | int | `1` | Specifies, how many successfull Jobs should be kept |
| defaultConfig | `{}` | Please refer to [default-config](#default) | Config to be used as the default config (see [cpa-config](#configure-cpa)) |
| schedules | [] | Please refer to [scheduler-config](#configure-schedules) | Configure a list of schedules, that used be created |
----------------------------------------------

## Configure CPA

The cluster-proportional autoscaler deployed with this chart is configured using configmaps. It comes with a dummy default configuration:
```yaml
ladder:
  {
    "nodesToReplicas":
      [
        [0, 1],  # if you have up to 4 nodes, scale resource to 1 replica
        [5, 2],  # if you have less than 10 nodes but more than 4, scale resource to 2 replica
        [10, 3]  # if more than 11 nodes, scale resource to 3 replica
      ]
  }
```
Please adapt this config to your needs.

Please see the [cluster-proportional-autoscaler](https://github.com/kubernetes-sigs/cluster-proportional-autoscaler#control-patterns-and-configmap-formats) docs for more information on the individual modes.

### configure-schedules
If you need time-dependent configuration, you can use the `schedules`:
```yaml
schedules:
- name: night
  cronTimeExpression: "0 16 * * 1-5"  # disable overprovisioning Monday - Friday from 6pm
  config:
    ladder:
      {
        "nodesToReplicas":
          [
            [0, 0]
          ]
      }
```

For every schedule a cronjob is created, that replaces the active config with the config from the schedule.

## Maintainers

| Name | Email |
| ---- | ------ |
| tielou | thilo@wobker.co |
| grieshaber | freddy.grieshaber+github@gmail.com |
