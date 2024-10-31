# linkurious-enterprise

![Version: 0.2.35](https://img.shields.io/badge/Version-0.2.35-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 2.10.18](https://img.shields.io/badge/AppVersion-2.10.18-informational?style=flat-square)

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

You will need to clone this repository and build the chart.

```console
git clone https://github.com/Linkurious/docker-lke && cd docker-lke
helm package charts/linkurious-enterprise
```

To install a very basic version of Linkurious enterprise, please set your private registry in the [basic values file](../../chart-value-examples/basic/values.yaml)
 and then run:

```console
helm upgrade --install my-release linkurious-enterprise-0.2.35.tgz -f chart-value-examples/basic/values.yaml
```

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| affinity | object | `{}` |  |
| autoscaling.enabled | bool | `false` | Enable Horizontal Pod Autoscaler ([HPA]) for Linkurious server (not recommended) |
| autoscaling.maxReplicas | int | `2` | Maximum number of replicas for Linkurious server [HPA] |
| autoscaling.minReplicas | int | `1` | Minimum number of replicas for Linkurious server [HPA] |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | Average CPU utilization percentage for Linkurious server [HPA] |
| backup.litestream.config | string | `"---\n# https://litestream.io/reference/config/\ndbs:\n  - path: /data/server/database.sqlite\n    replicas:\n      - url: s3://BUCKETNAME/PATHNAME\n        retention: 720h\n        snapshot-interval: 24h\n"` |  |
| backup.litestream.enabled | bool | `false` |  |
| backup.litestream.image | string | `"litestream/litestream:0.3.13"` |  |
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
| config.db.options.dialect | string | `"sqlite"` | Run Linkurious Enterprise with SQLite |
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
| configOverlayEnabled | bool | `true` | Manage LKE configmap (Declarative Setup) # Ref: https://doc.linkurio.us/admin-manual/latest/configure/#variable-expansion |
| env | list | `[]` | Environment variables to pass to Linkurious server |
| envFrom | list | `[]` | envFrom to pass to Linkurious server |
| fullnameOverride | string | `""` |  |
| hostAliases | list | `[]` |  |
| hostPostfix | string | `"example.domain"` |  |
| hostPrefixOverride | string | `"linkurious-enterprise"` |  |
| image.pullPolicy | string | `"IfNotPresent"` | Image pull policy for Linkurious server, can be one of Always, IfNotPresent, Never |
| image.repository | string | `""` | Repository to use for the application. You will need to retrieve the image from the Linkurious Customer Center and load it into your private repository |
| image.tag | string | `""` | Overrides the image tag whose default is the chart appVersion. |
| imagePullSecrets | list | `[]` | Secrets with credentials to pull images from a private registry. Secrets must be manually created in the namespace. ref: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/ |
| ingress.annotations | object | `{}` | Additional ingress annotations |
| ingress.className | string | `""` | Defines which ingress controller will implement the resource |
| ingress.enabled | bool | `false` | Enable an ingress resource for the Linkurious Enterprise server |
| ingress.hosts[0].paths[0].path | string | `"/"` |  |
| ingress.hosts[0].paths[0].pathType | string | `"ImplementationSpecific"` |  |
| ingress.labels | object | `{}` | Additional ingress labels |
| ingress.tls[0].secretName | string | `"wildcard-default-cert"` |  |
| ipWhiteList | object | `{}` |  |
| livenessProbe.enabled | bool | `true` | Enable Kubernetes liveness probe for server |
| livenessProbe.failureThreshold | int | `3` |  |
| livenessProbe.initialDelaySeconds | int | `10` |  |
| livenessProbe.path | string | `"/api/status/"` | Http path for the liveness probe (templated) |
| livenessProbe.periodSeconds | int | `10` |  |
| livenessProbe.successThreshold | int | `1` |  |
| livenessProbe.timeoutSeconds | int | `1` |  |
| metrics.prometheus.disableAPICheck | bool | `true` |  |
| metrics.prometheus.enabled | bool | `true` | Deploy metrics service and service monitor |
| metrics.prometheus.entryPoint | string | `"metrics"` | Entry point used to expose metrics. |
| metrics.prometheus.serviceMonitor.additionalLabels.release | string | `"kube-prometheus-stack"` |  |
| metrics.prometheus.serviceMonitor.honorLabels | bool | `true` |  |
| metrics.prometheus.serviceMonitor.interval | string | `"30s"` |  |
| metrics.prometheus.serviceMonitor.jobLabel | string | `"linkurious-enterprise"` |  |
| nameOverride | string | `""` |  |
| nodeSelector | object | `{}` |  |
| offlineMaintenanceModeEnabled | bool | `false` | set offlineMaintenanceModeEnabled: true to restart the StatefulSet without the linkurious-enterprise process running this can be used to perform tasks that cannot be performed when Neo4j is running, or in case the configuration is broken |
| persistentVolume.accessModes[0] | string | `"ReadWriteOnce"` |  |
| persistentVolume.annotations | object | `{}` |  |
| persistentVolume.enabled | bool | `false` | Enable persistent volume for Linkurious server |
| persistentVolume.size | string | `"5Gi"` |  |
| podAnnotations | object | `{}` |  |
| podSecurityContext.fsGroup | int | `2000` |  |
| podSecurityContext.runAsNonRoot | bool | `true` |  |
| podSecurityContext.runAsUser | int | `2013` |  |
| podSecurityContext.seccompProfile.type | string | `"RuntimeDefault"` |  |
| readinessProbe.enabled | bool | `true` | Enable Kubernetes readiness probe for server |
| readinessProbe.failureThreshold | int | `3` |  |
| readinessProbe.initialDelaySeconds | int | `10` |  |
| readinessProbe.path | string | `"/api/status/"` | Http path for the readiness probe (templated) |
| readinessProbe.periodSeconds | int | `10` |  |
| readinessProbe.successThreshold | int | `1` |  |
| readinessProbe.timeoutSeconds | int | `1` |  |
| replicaCount | int | `1` |  |
| resources | object | `{}` |  |
| securityContext.allowPrivilegeEscalation | bool | `false` |  |
| securityContext.capabilities.drop[0] | string | `"ALL"` |  |
| service | object | `{"metricsPort":9400,"port":80,"type":"ClusterIP"}` | Existing secret to use for license licenseFromSecret: '{{ printf "%s-lke-license-secret" .Release.Name }}' |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| tolerations | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.14.2](https://github.com/norwoodj/helm-docs/releases/v1.14.2)

