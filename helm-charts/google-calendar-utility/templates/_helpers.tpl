{{/*
Expand the name of the chart.
*/}}
{{- define "google-calendar-utility.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "google-calendar-utility.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "google-calendar-utility.labels" -}}
helm.sh/chart: {{ include "google-calendar-utility.chart" . }}
{{ include "google-calendar-utility.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "google-calendar-utility.selectorLabels" -}}
app.kubernetes.io/name: {{ include "google-calendar-utility.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Google private key secret name.
*/}}
{{- define "google-calendar-utility.privateKeyName" -}}
google-private-key
{{- end }}
