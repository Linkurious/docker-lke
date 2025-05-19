# Deploying Linkurious Enterprise helm chart on Azure Kubernetes Service

The sibling [values.yaml](values.yaml) file provides an example of deploying Linkurious Enterprise on AKS with persistent storage.

Please only use disk based CSI storage.
For more details please see [Azure CSI storage drivers documentation](https://learn.microsoft.com/en-us/azure/aks/csi-storage-drivers).
