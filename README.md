# mc-labels-and-annotations

This repository contains a Helm chart designed to streamline the deployment of Kubernetes applications by
providing predefined helper templates.

The `_helpers.tpl` file includes templates for standard Kubernetes labels, ensuring uniformity across deployments.

## To utilize this Helm chart in your project:
Include the Chart: Add this chart as a dependency in your project's Chart.yaml.

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
```
