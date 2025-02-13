# mc-labels-and-annotations

This Helm chart is maintained by MapColonies.
It provides predefined labels and annotations through helper templates to streamline the deployment
of Kubernetes applications.

The `_helpers.tpl` file includes teןאmplates for standard Kubernetes labels, ensuring uniformity across deployments.

## Usage:
To use this package and include the labels in your repository, add the package as a dependency:

```yaml
dependencies:
  - name: mc-labels-and-annotations
    version: 0.1.0
    repository: oci://artifactory.io/helm/infra
```

In your Kubernetes manifest templates, reference the helper templates to add labels and annotations:

```yaml
metadata:
  labels:
    {{ include "mc-labels-and-annotations.labels" . | nindent 4 }}
  annotations:
    {{ include "mc-labels-and-annotations.annotations" . | nindent 4 }}
```

To ensure the labels are properly generated, add the following values in your `values.yaml`

```yaml
mcMetadata:
  name: "MichalApplication"
  createdBy: "Michal" 
  component: "infrastructure"
  partOf: "Monitoring"
  releaseVersion: "v1.1.0"
  owner: "infra"
  gisDomain: ""
```

## Validation:
The chart includes validation logic to ensure that required label values are provided and arein the expected
formats. For instance, it checks that fields like createdBy and partOf are not empty, and that component 
matches one of the predefined categories such as "frontend", "backend", or "infrastructure".
This validation helps maintain consistency and prevents deployment errors due to misconfigured labels.
