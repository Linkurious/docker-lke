# Project Guidelines

## Architecture

Linkurious Enterprise deployment infrastructure — Helm chart + Docker Compose stacks.

- **Helm chart**: `charts/linkurious-enterprise/` — StatefulSet-based deployment for Kubernetes
- **Docker Compose**: Composable multi-file stacks (`-f` flag) for local dev/prod/preprod
- **CI/CD**: Jenkins pipelines using `linkurious-shared` library (`Jenkinsfile`, `Jenkinsfile.devops-release`)
- **Local K8s dev**: Tiltfile (requires Tilt ≥0.30.8, targets k8s-preprod context)

### Key Components

| Component | Purpose |
|-----------|---------|
| StatefulSet | Primary workload (non-root 2013:2013, seccomp RuntimeDefault) |
| ConfigMap | App config via `overlay.json` (runtime-editable) or `docker.json` (immutable) |
| Litestream | SQLite backup to S3 (init restore + sidecar replication) |
| Velero Schedule | K8s-native volume snapshots |
| Traefik Ingress | Routing with IP allowlist middleware, sticky sessions when replicas > 1 |

## Build and Test

```bash
# Helm lint/test (chart-testing)
ct lint --config ct.yaml
ct install --config ct.yaml

# Local dev with Tilt
tilt up

# Docker Compose (composable stacks)
docker-compose -f docker-compose.yml -f docker-compose.dev.yml \
  -f docker-compose.neo4jsa.yml -f docker-compose.es.yml up

# Standalone local
docker-compose -f docker-compose.lke.yml up
```

## Conventions

- **Helm templates**: Follow `linkurious-enterprise.*` helper naming in `_helpers.tpl`. Standard K8s labels (`app.kubernetes.io/*`).
- **Environment variables**: Use `$ENV:VAR_NAME` (string) or `$ENV-JSON:VAR_NAME` (JSON boolean) syntax in config.
- **Per-environment files**: `.env.lke-server.{RUN_ENV}`, `.env.backup.{RUN_ENV}` — `RUN_ENV` determines suffix.
- **Docker images**: Always require `${REPOSITORY}` prefix — no public registry defaults.
- **YAML lint rules**: See `lintconf.yaml` — trailing spaces enforced, unix newlines, unlimited line length.

## Critical Pitfalls

1. **Persistent volume disabled by default** (`emptyDir`) — always enable `persistentVolume.enabled: true` for production. On AKS use `managed-csi-premium`.
2. **License file**: Must exist before deployment (`touch license.key`). Mounted read-only at `/data/license.key`.
3. **Litestream restore**: Init container restores with `-if-db-not-exists` — wrong S3 credentials fail silently. Verify credentials before first deploy.
4. **ConfigMap overlay mode**: UI config changes in `overlay.json` are not persistent across pod restarts unless backed by PVC.
5. **Multi-replica**: Sticky sessions auto-applied when `replicaCount > 1`. Cluster mode auto-enabled for appVersion ≥4.2.0. HPA is **not recommended**.
6. **Neo4j migrations**: Require manual steps and `NEO4J_dbms_allow__upgrade=true` flag. See [README.md](../README.md) for migration paths.

## Documentation

- [README.md](../README.md) — Docker Compose usage, configuration layers, licensing, Neo4j migrations, Litestream backup
- [charts/linkurious-enterprise/README.md](../charts/linkurious-enterprise/README.md) — Helm chart installation and values reference
- [chart-value-examples/](../chart-value-examples/) — Ready-to-use value files (basic, Azure AKS, ingress)
