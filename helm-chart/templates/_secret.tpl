{{/*
Template for Secret resource
*/}}
{{- define "pantry-tracker.secret" -}}
{{- $ := index . 0 -}}
{{- with index . 1 -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ .name }}
  labels:
    {{- include "pantry-tracker.labels" $ | nindent 4 }}
  annotations:
    helm.sh/hook: pre-install,pre-upgrade
    helm.sh/hook-weight: "-3"
data:
  {{- range $k, $v := .secretValues }}
  {{ $k }}: {{ $v | b64enc }}
  {{- end }}
{{- end -}}
{{- end -}}
