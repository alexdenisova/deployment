{{/*
Template for ConfigMap resource
*/}}
{{- define "pantry-tracker.configMap" -}}
{{- $ := index . 0 -}}
{{- with index . 1 -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .name }}
  labels:
    {{- include "pantry-tracker.labels" $ | nindent 4 }}
  annotations:
    helm.sh/hook: pre-install,pre-upgrade
    helm.sh/hook-weight: "-3"
data:
  {{- toYaml .configMapValues | nindent 2 }}
{{- end -}}
{{- end -}}
