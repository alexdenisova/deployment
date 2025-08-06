{{/*
Expand the name of the chart.
*/}}
{{- define "speech-to-text.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
ServicePort
*/}}
{{- define "speech-to-text.servicePort" -}}
name: http
port: 80
protocol: TCP
targetPort: http
{{- end }}

{{/*
Selector labels
*/}}
{{- define "speech-to-text.selectorLabels" -}}
app.kubernetes.io/name: {{ include "speech-to-text.name" $ }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "speech-to-text.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/name: {{ .Chart.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
TLS secret name
*/}}
{{- define "speech-to-text.tls_secret" -}}
{{- printf "%s-tls" (include "speech-to-text.name" $) }}
{{- end }}
