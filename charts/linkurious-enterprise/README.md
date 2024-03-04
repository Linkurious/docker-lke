# linkurious-enterprise

![Version: 0.2.26](https://img.shields.io/badge/Version-0.2.26-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.10.18](https://img.shields.io/badge/AppVersion-2.10.18-informational?style=flat-square)

A Helm chart for Linkurious Enterprise

**Homepage:** <https://linkurio.us>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| enys |  |  |

## Source Code

* <https://github.com/Linkurious/docker-lke>

## Installing the Chart

To install the chart with the release name `my-release`:

You will need to clone this repository.

```console
$ helm upgrade --install my-release charts/linkurious-enterprise/
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` |  |
| autoscaling.maxReplicas | int | `5` |  |
| autoscaling.minReplicas | int | `1` |  |
| autoscaling.targetCPUUtilizationPercentage | int | `80` |  |
| backup.litestream.config | string | `"---\n# https://litestream.io/reference/config/\ndbs:\n  - path: /data/server/database.sqlite\n    replicas:\n      - url: s3://BUCKETNAME/PATHNAME\n        retention: 720h\n        snapshot-interval: 24h\n"` |  |
| backup.litestream.enabled | bool | `false` |  |
| backup.litestream.livenessProbe.exec.command[0] | string | `"litestream"` |  |
| backup.litestream.livenessProbe.exec.command[1] | string | `"snapshots"` |  |
| backup.litestream.livenessProbe.exec.command[2] | string | `"/data/server/database.sqlite"` |  |
| backup.litestream.livenessProbe.failureThreshold | int | `3` |  |
| backup.litestream.livenessProbe.initialDelaySeconds | int | `5` |  |
| backup.litestream.livenessProbe.periodSeconds | int | `15` |  |
| backup.litestream.livenessProbe.timeoutSeconds | int | `5` |  |
| backup.litestream.readinessProbe.exec.command[0] | string | `"litestream"` |  |
| backup.litestream.readinessProbe.exec.command[1] | string | `"snapshots"` |  |
| backup.litestream.readinessProbe.exec.command[2] | string | `"/data/server/database.sqlite"` |  |
| backup.litestream.readinessProbe.failureThreshold | int | `3` |  |
| backup.litestream.readinessProbe.initialDelaySeconds | int | `5` |  |
| backup.litestream.readinessProbe.periodSeconds | int | `15` |  |
| backup.litestream.readinessProbe.timeoutSeconds | int | `5` |  |
| backup.litestream.resources | object | `{}` |  |
| backup.litestream.secretRef.name | string | `"litestream-lke-secret"` |  |
| backup.velero.enabled | bool | `false` |  |
| config.access.authRequired | string | `"$ENV:LKE_AUTH_REQUIRED"` |  |
| config.access.autoRefreshGroupMapping | string | `"$ENV-JSON:LKE_OAUTH2_AUTO_REFRESH_GROUP_MAPPING"` |  |
| config.access.oauth2.authorizationURL | string | `"$ENV:LKE_OAUTH2_AUTHORIZATION_URL"` |  |
| config.access.oauth2.azure.tenantID | string | `"$ENV:LKE_OAUTH2_AZURE_TENANT_ID"` |  |
| config.access.oauth2.clientID | string | `"$ENV:LKE_OAUTH2_CLIENT_ID"` |  |
| config.access.oauth2.clientSecret | string | `"$ENV:LKE_OAUTH2_CLIENT_SECRET"` |  |
| config.access.oauth2.enabled | string | `"$ENV-JSON:LKE_OAUTH2_ENABLED"` |  |
| config.access.oauth2.provider | string | `"$ENV:LKE_OAUTH2_PROVIDER"` |  |
| config.access.oauth2.tokenURL | string | `"$ENV:LKE_OAUTH2_TOKEN_URL"` |  |
| config.db.options.dialect | string | `"sqlite"` |  |
| config.db.options.storage | string | `"server/database.sqlite"` |  |
| config.server.allowFraming | bool | `false` |  |
| config.server.allowOrigin | string | `"$ENV:LKE_ALLOW_ORIGIN"` |  |
| config.server.cookieHttpOnly | bool | `true` |  |
| config.server.domain | string | `"$ENV:LKE_PUBLIC_DOMAIN"` |  |
| config.server.forceHttps | bool | `false` |  |
| config.server.forcePublicHttps | string | `"$ENV-JSON:LKE_FORCE_PUBLIC_HTTPS"` |  |
| config.server.publicPortHttps | string | `"$ENV-NUMBER:LKE_PUBLIC_PORT_HTTPS"` |  |
| config.server.useHttps | bool | `false` |  |
| config.version | string | `"2.10.18"` |  |
| configEnabled | bool | `false` | Manage LKE configmap (Declarative Setup) # Ref: https://doc.linkurio.us/admin-manual/latest/configure/#variable-expansion |
| configOverlayEnabled | bool | `true` |  |
| env | list | `[]` |  |
| envFrom | list | `[]` |  |
| fullnameOverride | string | `""` |  |
| hostAliases | list | `[]` |  |
| hostPostfix | string | `"example.domain"` |  |
| hostPrefixOverride | string | `"linkurious-enterprise"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `""` | Repository to use for the application. You will need to retrieve the image from the Linkurious Customer Center and load it into your private repository |
| image.tag | string | `""` |  |
| imagePullSecrets | list | `[]` |  |
| ingress.annotations | object | `{}` |  |
| ingress.className | string | `""` |  |
| ingress.enabled | bool | `false` |  |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.labels | object | `{}` |  |
| ingress.tls[0].secretName | string | `"wildcard-default-cert"` |  |
| ipWhiteList | object | `{}` |  |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `1` |  |
| metrics.prometheus.disableAPICheck | bool | `true` |  |
| metrics.prometheus.enabled | bool | `true` |  |
| metrics.prometheus.entryPoint | string | `"metrics"` |  |
| metrics.prometheus.serviceMonitor.additionalLabels.release | string | `"kube-prometheus-stack"` |  |
| metrics.prometheus.serviceMonitor.honorLabels | bool | `true` |  |
| metrics.prometheus.serviceMonitor.interval | string | `"30s"` |  |
| metrics.prometheus.serviceMonitor.jobLabel | string | `"linkurious-enterprise"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| offlineMaintenanceModeEnabled | bool | `false` |  |
| persistentVolume.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistentVolume.annotations | object | `{}` |  |
| persistentVolume.enabled | bool | `false` |  |
| persistentVolume.size | string | `"5Gi"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.fsGroup | int | `2000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `2013` |  |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `1` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| securityContext.runAsNonRoot | bool | `true` |  |
| securityContext.runAsUser | int | `2013` |  |
| securityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| service.metricsPort | int | `9400` |  |
| service.port | int | `80` |  |
| service.type | string | `"ClusterIP"` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.create | bool | `false` |  |
| serviceAccount.name | string | `""` |  |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.13.1](https://github.com/norwoodj/helm-docs/releases/v1.13.1)

