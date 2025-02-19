{{/*
Create common labels for all kubernetes components
*/}}
{{- define "generalLabels" -}}
{{- include "validateGeneral" . }}
{{- include "selectorLabels" . }}
{{ $mcLabels := fromYaml (include "mcLabels.merged" .) -}}
app.kubernetes.io/part-of: {{ $mcLabels.partOf }}
mapcolonies.io/owner: {{ $mcLabels.owner }}
app.kubernetes.io/created-by: {{ $mcLabels.createdBy }}
{{- if hasKey $mcLabels "releaseVersion" }}
mapcolonies.io/release-version: {{ $mcLabels.releaseVersion }}
{{- end -}}
{{ if hasKey $mcLabels "gisDomain" }}
mapcolonies.io/gis-domain: {{ $mcLabels.gisDomain }}
{{- end -}}
{{- end }}

{{/*
Create common annotations for all kubernetes components
*/}}
{{- define "generalAnnotations" -}}
{{- end }}

{{/*
Create common labels for all kubernetes components
*/}}
{{- define "selectorLabels" -}}
{{- $mcLabels := fromYaml (include "mcLabels.merged" .) -}}
mapcolonies.io/environment: {{ $mcLabels.environment }}
{{- end }}

{{/*
Create common labels for all kubernetes components besides service.
It includes also the common labels from "generalLabels" function
*/}}
{{- define "mc-labels-and-annotations.labels" -}}
{{- include "validate" . }}
{{- $mcLabels := fromYaml (include "mcLabels.merged" .) -}}
{{- include "generalLabels" . }}
app.kubernetes.io/component: {{ $mcLabels.component }}
{{- end }}

{{/*
Create common annotations for all kubernetes components besides service.
It includes also the common annotations from "generalAnnotations" function
*/}}
{{- define "mc-labels-and-annotations.annotations" -}}
{{- include "generalAnnotations" . }}
{{- end }}

{{/*
Create common labels for kubernetes service component.
It includes also the common labels from "generalLabels" function
*/}}
{{- define "mc-labels-and-annotations.serviceLabels" -}}
{{- include "generalLabels" . }}
{{- end }}

{{/*
Create common annotations for kubernetes service component.
It includes also the common annotations from "generalAnnotations" function
*/}}
{{- define "mc-labels-and-annotations.serviceAnnotations" -}}
{{- include "generalAnnotations" . }}
{{- end }}
