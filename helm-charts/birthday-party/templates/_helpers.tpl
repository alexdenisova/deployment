{{- define "bp.fullname" -}}
{{- if contains .Chart.Name .Release.Name -}}
{{- .Release.Name | trunc 50 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 50 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}

{{- define "bp.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version }}
app.kubernetes.io/name: {{ .Chart.Name }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/* Selector labels for one component: include "bp.selectorLabels" (list . "api") */}}
{{- define "bp.selectorLabels" -}}
{{- $root := index . 0 -}}
app.kubernetes.io/name: {{ $root.Chart.Name }}
app.kubernetes.io/instance: {{ $root.Release.Name }}
app.kubernetes.io/component: {{ index . 1 }}
{{- end -}}

{{- define "bp.secretName" -}}
{{- .Values.secrets.existingSecret | default (printf "%s-secrets" (include "bp.fullname" .)) -}}
{{- end -}}

{{- define "bp.imagePullSecrets" -}}
imagePullSecrets:
  {{- list (dict "name" .Values.registrySecret.name) | toYaml | nindent 2 }}
{{- end -}}
