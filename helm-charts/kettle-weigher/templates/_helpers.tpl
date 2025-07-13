{{/*
Expand the name of the chart.
*/}}
{{- define "kettle-weigher.name" -}}
{{- .Chart.Name | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
ServicePort
*/}}
{{- define "kettle-weigher.servicePort" -}}
name: http
port: 80
protocol: TCP
targetPort: http
{{- end }}

{{/*
Selector labels
*/}}
{{- define "kettle-weigher.selectorLabels" -}}
app.kubernetes.io/name: {{ include "kettle-weigher.name" $ }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "kettle-weigher.labels" -}}
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
{{- define "kettle-weigher.tls_secret" -}}
{{- printf "%s-tls" (include "kettle-weigher.name" $) }}
{{- end }}
