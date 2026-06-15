# Installing Linkurious Enterprise plugins via an init container

The sibling [values.yaml](values.yaml) file provides an example of installing
Linkurious Enterprise plugins by downloading their release archives into
`/data/plugins` using a `curl`-based init container.

This example downloads the [`lke-plugin-third-party-data`](https://github.com/Linkurious/lke-plugin-third-party-data)
plugin release from GitHub.

## How it works

The chart exposes `initContainers` (see [values.yaml](../../charts/linkurious-enterprise/values.yaml)),
which lets you run arbitrary containers before the main Linkurious Enterprise
container starts. The init container mounts the same `lke-data` PVC that the
main container uses at `/data`, downloads the plugin `.lke` file into
`/data/plugins`, and exits. Linkurious Enterprise then loads the plugin at
startup (`plugins.enabled: true`).

## Adding more plugins

Append additional `curl` commands to the init container `args` block, one per
plugin, all writing under `/data/plugins`. Pin each plugin to a specific
release tag — avoid `latest` so deployments are reproducible.

## Notes

- The plugin `.lke` files are persisted on the `lke-data` PVC. Re-running the
  init container on pod restart is idempotent (curl overwrites the file with
  the same content).
- The init container inherits the chart's default non-root `podSecurityContext`
  (`2013:2013`); `curlimages/curl` supports running as an arbitrary UID.
- If your cluster has no outbound internet access, pre-stage the plugin
  artifacts in an internal registry / object store and adjust the URL.
