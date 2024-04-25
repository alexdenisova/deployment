{{/*
ServicePort
*/}}
{{- define "pantry-tracker.servicePort" -}}
name: http
port: 80
protocol: TCP
targetPort: http
{{- end }}

{{/*
Common labels
*/}}
{{- define "pantry-tracker.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
app.kubernetes.io/name: {{ .Chart.Name }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
