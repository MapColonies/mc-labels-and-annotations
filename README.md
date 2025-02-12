# mc-labels-and-annotations

This repository contains a Helm chart designed to streamline the deployment of Kubernetes applications by
providing predefined labels and annotations by helper templates.

The `_helpers.tpl` file includes templates for standard Kubernetes labels, ensuring uniformity across deployments.

## Usage:
In order to use this package and include the labels in your repo, add the package as a dependency:

```yaml
dependencies:
  - name: mc-labels-and-annotations
    version: 0.1.0
    repository: oci://acrarolibotnonprod.azurecr.io/helm/infra
```

Reference Helper Templates: In your Kubernetes manifest templates, incorporate the helper templates as needed.
For example, to add standard labels:

```yaml
metadata:
  labels:
    {{ include "mc-labels-and-annotations.labels" . | nindent 4 }}
  annotations:
    {{ include "mc-labels-and-annotations.annotations" . | nindent 4 }}
```
