{{/*
Expand the name of the chart.
*/}}
{{- define "driving-school.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "driving-school.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "driving-school.labels" -}}
helm.sh/chart: {{ include "driving-school.chart" . }}
{{ include "driving-school.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "driving-school.selectorLabels" -}}
app.kubernetes.io/name: {{ include "driving-school.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
