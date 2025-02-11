{{- define "libchart.labels" -}}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.Version }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
helm.sh/chart: {{ .Chart.Name }}-{{ .Chart.Version }}
app.kubernetes.io/created-by: "{{ .Values.deployment.createdBy }}"
app.kubernetes.io/component: "{{ .Values.deployment.component }}"
app.kubernetes.io/part-of: "{{ .Values.deployment.partOf }}"
mapcolonies.io/environment: "{{ .Values.deployment.environment }}"
mapcolonies.io/release-version: "{{ .Values.deployment.releaseVersion }}"
mapcolonies.io/owner: "{{ .Values.deployment.owner }}"
mapcolonies.io/gis-domain: "{{ .Values.deployment.gisDomain }}"
{{- end }}

{{- define "libchart.validateLabelsAndAnnotations" -}}

  {{- if not (has .Values.deployment.component (list "frontend" "backend" "database" "proxy-server" "cache-server" "infrastructure")) -}}
      {{- fail (printf "Invalid value for mapcolonies.io/component:") -}}
  {{- end -}}

  {{- if not (has .Values.deployment.gisDomain (list "vector" "raster" "3d" "dem" "terrain-analysis")) -}}
      {{- fail (printf "Invalid value for mapcolonies.io/gisDomain:") -}}
  {{- end -}}

  {{- if not (has .Values.deployment.environment (list "dev" "prod" "integration")) -}}
      {{- fail (printf "Invalid value for mapcolonies.io/environment:") -}}
  {{- end -}}
  
  {{- if not (has .Values.deployment.owner (list "vector" "raster" "3d" "app" "dem" "infra" "common")) -}}
      {{- fail (printf "Invalid value for mapcolonies.io/owner:") -}}
  {{- end -}}

{{- end -}}
