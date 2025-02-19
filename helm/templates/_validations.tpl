{{/*
Validates mcLabels values needed for general labels and annotations
*/}}
{{- define "validateGeneral" -}}
{{- $mcLabels := include "mcLabels.merged" . | fromYaml -}}

{{- if not (hasKey $mcLabels "environment") -}}
    {{- fail "There is no environment key in mcLabels" -}}
{{- end -}}
{{- if not (hasKey $mcLabels "createdBy") -}}
    {{- fail "There is no createdBy key in mcLabels" -}}
{{- end -}}
{{- if not (hasKey $mcLabels "partOf") -}}
    {{- fail "There is no partOf key in mcLabels" -}}
{{- end -}}
{{- if not (hasKey $mcLabels "owner") -}}
    {{- fail "There is no owner key in mcLabels" -}}
{{- end -}}

{{- $environments := splitList " " (include "environments" .) }}
{{- $gisDomains := splitList " " (include "gisDomains" .) }}
{{- $owners := splitList " " (include "owners" .) }}

{{- if not (has $mcLabels.environment $environments) -}}
    {{- fail (printf "Invalid value for mapcolonies.io/environment.\nProvided: %s \nValid values are: %s" $mcLabels.environment ($environments | join " | ")) -}}
{{- end -}}

{{- if not (has $mcLabels.owner $owners) -}}
    {{- fail (printf "Invalid value for mapcolonies.io/owner.\nProvided: %s \nValid values are: %s" $mcLabels.owner ($owners | join " | ")) -}}
{{- end -}}

{{- if and (hasKey $mcLabels "gisDomain") (not (has $mcLabels.gisDomain $gisDomains)) -}}
    {{- fail (printf "Invalid value for mapcolonies.io/gisDomain.\nProvided: %s \nValid values are: %s" $mcLabels.gisDomain ($gisDomains | join " | ")) -}}
{{- end -}}
{{- end -}}

{{/*
Validate mcLabels values needed for labels and annotations of all kubernetes components besides service
*/}}
{{- define "validate" -}}
{{- $mcLabels := include "mcLabels.merged" . | fromYaml -}}

{{- if not (hasKey $mcLabels "component") -}}
    {{- fail "There is no component key in mcLabels" -}}
{{- end -}}

{{- $components := splitList " " (include "components" .) }}

{{- if not (has $mcLabels.component $components) -}}
    {{- fail (printf "Invalid value for mapcolonies.io/component.\nProvided: %s \nValid values are: %s" $mcLabels.component ($components | join " | ")) -}}
{{- end -}}
{{- end -}}
