# cluster-overprovisioner

![Version: 0.4.5](https://img.shields.io/badge/Version-0.4.5-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 1.16.0](https://img.shields.io/badge/AppVersion-1.16.0-informational?style=flat-square)

Helm chart, that enables scheduled scaling of a target resource, intended to be add overprovisioning to an autoscaling k8s cluster.

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| tielou | thilo@wobker.co |  |
| grieshaber | freddy.grieshaber+github@gmail.com |  |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| cpa.affinity | object | `{}` |  |
| cpa.extraArgs[0] | string | `"--logtostderr=true"` |  |
| cpa.extraArgs[1] | string | `"--v=2"` |  |
| cpa.fullnameOverride | string | `""` |  |
| cpa.image.pullPolicy | string | `"IfNotPresent"` |  |
| cpa.image.repository | string | `"freddyfroehlich/cpa-dirty"` |  |
| cpa.image.tag | string | `"latest"` |  |
| cpa.imagePullSecrets | list | `[]` |  |
| cpa.nameOverride | string | `""` |  |
| cpa.nodeSelector | object | `{}` |  |
| cpa.podAnnotations | object | `{}` |  |
| cpa.podSecurityContext.fsGroup | int | `1000` |  |
| cpa.podSecurityContext.runAsGroup | int | `1000` |  |
| cpa.podSecurityContext.runAsUser | int | `1000` |  |
| cpa.rbac.create | bool | `true` |  |
| cpa.rbac.podSecurityPolicy.enabled | bool | `false` |  |
| cpa.resources.limits.cpu | string | `"100m"` |  |
| cpa.resources.limits.memory | string | `"128Mi"` |  |
| cpa.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| cpa.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| cpa.securityContext.privileged | bool | `false` |  |
| cpa.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| cpa.securityContext.runAsNonRoot | bool | `true` |  |
| cpa.serviceAccount.annotations | object | `{}` |  |
| cpa.serviceAccount.automountServiceAccountToken | bool | `true` |  |
| cpa.serviceAccount.create | bool | `true` |  |
| cpa.serviceAccount.name | string | `""` |  |
| cpa.target.name | string | `""` |  |
| cpa.target.namespace | string | `""` |  |
| cpa.tolerations | list | `[]` |  |
| cronJob.failedJobsHistoryLimit | int | `1` |  |
| cronJob.image.pullPolicy | string | `"Always"` |  |
| cronJob.image.repository | string | `"ghcr.io/codecentric/cluster-overprovisioner-helper"` |  |
| cronJob.image.tag | string | `"latest"` |  |
| cronJob.successfulJobsHistoryLimit | int | `1` |  |
| defaultConfig.ladder.nodesToReplicas[0][0] | int | `0` |  |
| defaultConfig.ladder.nodesToReplicas[0][1] | int | `7` |  |
| defaultConfig.ladder.nodesToReplicas[1][0] | int | `8` |  |
| defaultConfig.ladder.nodesToReplicas[1][1] | int | `4` |  |
| defaultConfig.ladder.nodesToReplicas[2][0] | int | `12` |  |
| defaultConfig.ladder.nodesToReplicas[2][1] | int | `0` |  |
| op.affinity | object | `{}` |  |
| op.enabled | bool | `true` |  |
| op.fullnameOverride | string | `""` |  |
| op.image.pullPolicy | string | `"IfNotPresent"` |  |
| op.image.repository | string | `"k8s.gcr.io/pause"` |  |
| op.image.tag | float | `3.2` |  |
| op.imagePullSecrets | list | `[]` |  |
| op.nameOverride | string | `""` |  |
| op.nodeSelector | object | `{}` |  |
| op.podAnnotations | object | `{}` |  |
| op.podSecurityContext.fsGroup | int | `1000` |  |
| op.podSecurityContext.runAsGroup | int | `1000` |  |
| op.podSecurityContext.runAsUser | int | `1000` |  |
| op.priorityClasses.default.enabled | bool | `false` |  |
| op.priorityClasses.default.name | string | `"default"` |  |
| op.priorityClasses.default.value | int | `0` |  |
| op.priorityClasses.overprovision.name | string | `"overprovision"` |  |
| op.priorityClasses.overprovision.value | int | `-1` |  |
| op.rbac.podSecurityPolicy.enabled | bool | `false` |  |
| op.resources | object | `{}` |  |
| op.securityContext.allowPrivilegeEscalation | bool | `false` |  |
| op.securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| op.securityContext.privileged | bool | `false` |  |
| op.securityContext.readOnlyRootFilesystem | bool | `true` |  |
| op.securityContext.runAsNonRoot | bool | `true` |  |
| op.serviceAccount.annotations | object | `{}` |  |
| op.serviceAccount.automountServiceAccountToken | bool | `false` |  |
| op.serviceAccount.create | bool | `true` |  |
| op.serviceAccount.name | string | `""` |  |
| op.tolerations | list | `[]` |  |
| schedules[0].config.ladder.nodesToReplicas[0][0] | int | `0` |  |
| schedules[0].config.ladder.nodesToReplicas[0][1] | int | `0` |  |
| schedules[0].cronTimeExpression | string | `"0 16 * * 1-5"` |  |
| schedules[0].name | string | `"night"` |  |
| schedules[1].config.ladder.nodesToReplicas[0][0] | int | `0` |  |
| schedules[1].config.ladder.nodesToReplicas[0][1] | int | `7` |  |
| schedules[1].config.ladder.nodesToReplicas[1][0] | int | `8` |  |
| schedules[1].config.ladder.nodesToReplicas[1][1] | int | `4` |  |
| schedules[1].config.ladder.nodesToReplicas[2][0] | int | `12` |  |
| schedules[1].config.ladder.nodesToReplicas[2][1] | int | `0` |  |
| schedules[1].cronTimeExpression | string | `"0 5 * * 1-5"` |  |
| schedules[1].name | string | `"day"` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.5.0](https://github.com/norwoodj/helm-docs/releases/v1.5.0)
