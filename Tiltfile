
# version_settings() enforces a minimum Tilt version
# https://docs.tilt.dev/api.html#api.version_settings
version_settings(constraint='>=0.30.8')

load('ext://kubectl_build', 'kubectl_build')
load('ext://helm_resource', 'helm_resource', 'helm_repo')
# default_registry('prepush.docker.nexus3.vpc.prod.scw-par1.linkurious.net')

ctx = k8s_context()
if ctx.endswith('k8s-dev'):
  allow_k8s_contexts(ctx)

if not k8s_namespace().endswith("dev"):
  fail("You are not targeting a dev namespace")
builder = "builder-" + k8s_namespace()


enterprise_workload_name = 'linkurious-enterprise'
enterprise_release_name = ctx.removesuffix('@k8s-dev') + '-tilt'
enterprise_ingress_workload_name = ctx.removesuffix('@k8s-dev') + '-tilt'
extra_values = ['--values=./internal-values.yaml']
helm_resource(
  name=enterprise_workload_name,
  release_name=enterprise_release_name,
  chart='charts/linkurious-enterprise',
  deps=['charts/linkurious-enterprise', 'internal-values.yaml'],
  flags=extra_values,
  )
k8s_resource(workload=enterprise_workload_name,
  links=[
      enterprise_ingress_workload_name + '.' + k8s_namespace() + '.k8s.dev.linkurious.net/api/',
  ]
)