{{/*
Returns the name from global mcMetadata if exists or from the mcMetadata's values
*/}}
{{- define "mcMetadata.name" -}}
    {{- if (hasKey .Values.global.mcMetadata "name") -}}
        {{- .Values.global.mcMetadata.name -}}
    {{- else -}}
        {{- .Values.mcMetadata.name -}}
    {{- end -}}
{{- end -}}

{{/*
Returns the createdBy from global mcMetadata if exists or from the mcMetadata's values
*/}}
{{- define "mcMetadata.createdBy" -}}
    {{- if (hasKey .Values.global.mcMetadata "createdBy") -}}
        {{- .Values.global.mcMetadata.createdBy -}}
    {{- else -}}
        {{- .Values.mcMetadata.createdBy -}}
    {{- end -}}
{{- end -}}

{{/*
Returns the component from global mcMetadata if exists or from the mcMetadata's values
*/}}
{{- define "mcMetadata.component" -}}
    {{- if (hasKey .Values.global.mcMetadata "component") -}}
        {{- .Values.global.mcMetadata.component -}}
    {{- else -}}
        {{- .Values.mcMetadata.component -}}
    {{- end -}}
{{- end -}}

{{/*
Returns the partOf from global mcMetadata if exists or from the mcMetadata's values
*/}}
{{- define "mcMetadata.partOf" -}}
    {{- if (hasKey .Values.global.mcMetadata "partOf") -}}
        {{- .Values.global.mcMetadata.partOf -}}
    {{- else -}}
        {{- .Values.mcMetadata.partOf -}}
    {{- end -}}
{{- end -}}

{{/*
Returns the releaseVersion from global mcMetadata if exists or from the mcMetadata's values
*/}}
{{- define "mcMetadata.releaseVersion" -}}
    {{- if (hasKey .Values.global.mcMetadata "releaseVersion") -}}
        {{- .Values.global.mcMetadata.releaseVersion -}}
    {{- else -}}
        {{- .Values.mcMetadata.releaseVersion -}}
    {{- end -}}
{{- end -}}

{{/*
Returns the owner from global mcMetadata if exists or from the mcMetadata's values
*/}}
{{- define "mcMetadata.owner" -}}
    {{- if (hasKey .Values.global.mcMetadata "owner") -}}
        {{- .Values.global.mcMetadata.owner -}}
    {{- else -}}
        {{- .Values.mcMetadata.owner -}}
    {{- end -}}
{{- end -}}

{{/*
Returns the gisDomain from global mcMetadata if exists or from the mcMetadata's values
*/}}
{{- define "mcMetadata.gisDomain" -}}
    {{- if (hasKey .Values.global.mcMetadata "gisDomain") -}}
        {{- .Values.global.mcMetadata.gisDomain -}}
    {{- else -}}
        {{- .Values.mcMetadata.gisDomain -}}
    {{- end -}}
{{- end -}}

{{/*
Returns the environment from global if exists or from the chart's values, defaults to development
*/}}
{{- define "mcMetadata.environment" -}}
    {{- if (hasKey .Values "environment") -}}
        {{- .Values.environment -}}
    {{- else -}}
        {{- .Values.global.environment -}}
    {{- end -}}
{{- end -}}

{{- define "mc-labels-and-annotations.generalLabels" -}}
{{- $environment := include "mcMetadata.environment" . | trim }}
{{- $name := include "mcMetadata.name" . | trim }}
{{- $createdBy := include "mcMetadata.createdBy" . | trim }}
{{- $component := include "mcMetadata.component" . | trim }}
{{- $partOf := include "mcMetadata.partOf" . | trim }}
{{- $releaseVersion := include "mcMetadata.releaseVersion" . | trim }}
{{- $owner := include "mcMetadata.owner" . | trim }}
{{- $gisDomain := include "mcMetadata.gisDomain" . | trim }}

app.kubernetes.io/name: "{{ $name }}"
app.kubernetes.io/managed-by: {{ .Release.Service }}
app.kubernetes.io/created-by: "{{ $createdBy }}"
app.kubernetes.io/part-of: "{{ $partOf }}"
mapcolonies.io/environment: "{{ $environment }}"
mapcolonies.io/release-version: "{{ $releaseVersion }}"
mapcolonies.io/owner: "{{ $owner }}"
mapcolonies.io/gis-domain: "{{ $gisDomain }}"
{{- end }}

{{- define "mc-labels-and-annotations.labels" -}}
{{- include "mc-labels-and-annotations.validateLabelsAndAnnotations" . }}
{{- include "mc-labels-and-annotations.generalLabels" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/component: "{{ .Values.mcMetadata.component }}"
{{- end }}

{{- define "mc-labels-and-annotations.serviceLabels" -}}
{{- include "mc-labels-and-annotations.generalLabels" . }}
{{- end }}

{{- define "mc-labels-and-annotations.annotations" -}}
{{- end }}

{{- define "mc-labels-and-annotations.validateLabelsAndAnnotations" -}}

{{- $environment := include "mcMetadata.environment" . | trim }}
{{- $component := include "mcMetadata.component" . | trim }}
{{- $owner := include "mcMetadata.owner" . | trim }}
{{- $gisDomain := include "mcMetadata.gisDomain" . | trim }}

  {{- if not (has $component (list "frontend" "backend" "database" "proxy-server" "cache-server" "infrastructure")) -}}
      {{- fail (printf "Invalid value for mapcolonies.io/component:") -}}
  {{- end -}}

  {{- if not (has $gisDomain (list "vector" "raster" "3d" "dem" "terrain-analysis")) -}}
      {{- fail (printf "Invalid value for mapcolonies.io/gisDomain:") -}}
  {{- end -}}

  {{- if not (has $environment (list "dev" "prod" "integration")) -}}
      {{- fail (printf "Invalid value for mapcolonies.io/environment: %s" $environment) -}}
  {{- end -}}
  
  {{- if not (has $owner (list "vector" "raster" "3d" "app" "dem" "infra" "common")) -}}
      {{- fail (printf "Invalid value for mapcolonies.io/owner:") -}}
  {{- end -}}

{{- end -}}
