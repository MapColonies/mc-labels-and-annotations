{{/*
Defines valid values for different fields
*/}}
{{- define "components" -}}
{{- join " " (list "frontend" "backend" "database" "proxy-server" "cache-server" "infrastructure") -}}
{{- end -}}

{{- define "gisDomains" -}}
{{- join " " (list "vector" "raster" "3d" "dem" "terrain-analysis") -}}
{{- end -}}

{{- define "environments" -}}
{{- join " " (list "development" "production" "stage") -}}
{{- end -}}

{{- define "owners" -}}
{{- join " " (list "vector" "raster" "3d" "app" "dem" "infra" "common") -}}
{{- end -}}

{{/*
Merge global and local mcLabels values
*/}}
{{- define "mcLabels.merged" -}}
{{- if not (or .Values.global.mcLabels .Values.mcLabels) -}}
    {{- fail (printf "There is no mcLabels key (locally or globally)") -}}
{{- end -}}
{{- $globalMcLabels := default (dict) .Values.global.mcLabels -}}
{{- $localMcLabels := default (dict) .Values.mcLabels -}}
{{- $merged := merge $localMcLabels $globalMcLabels -}}
{{- $merged | toYaml -}}
{{- end -}}
