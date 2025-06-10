# version_settings() enforces a minimum Tilt version
# https://docs.tilt.dev/api.html#api.version_settings
version_settings(constraint='>=0.30.8')

load('ext://kubectl_build', 'kubectl_build')
load('ext://helm_resource', 'helm_resource', 'helm_repo')

ctx = k8s_context()
if ctx.endswith('k8s-preprod'):
  allow_k8s_contexts(ctx)

if not k8s_namespace().endswith("dev"):
  fail("You are not targeting a dev namespace")
builder = "builder-" + k8s_namespace()


enterprise_workload_name = 'linkurious-enterprise'
enterprise_release_name = ctx.removesuffix('@k8s-preprod') + '-tilt'
enterprise_ingress_workload_name = ctx.removesuffix('@k8s-preprod') + '-tilt'
deps=['charts/linkurious-enterprise']
extra_values=[]
internal_values_filename = 'internal-values.yaml'
if os.path.exists(internal_values_filename):
  extra_values = ['--values='+internal_values_filename]
  deps += [internal_values_filename]
helm_resource(
  name=enterprise_workload_name,
  release_name=enterprise_release_name,
  chart='charts/linkurious-enterprise',
  deps=['charts/linkurious-enterprise', 'internal-values.yaml'],
  flags=extra_values,
  )
k8s_resource(workload=enterprise_workload_name,
  links=[
      enterprise_ingress_workload_name + '-' +enterprise_workload_name + '.' + k8s_namespace() + '.k8s.preprod.linkurious.net/',
  ]
)
