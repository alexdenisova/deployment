{{/*
Template for Ingress Secret resource
*/}}
{{- define "pantry-tracker.ingressSecret" -}}
{{- $ := index . 0 -}}
{{- with index . 1 -}}
apiVersion: v1
kind: Secret
type: kubernetes.io/tls
metadata:
  name: {{ .secretName }}
  labels:
    {{- include "pantry-tracker.labels" $ | nindent 4 }}
  annotations:
    helm.sh/hook: pre-install,pre-upgrade
    helm.sh/hook-weight: "-3"
data:
  tls.crt: {{ .certificate | b64enc }}
  tls.key: {{ .key | b64enc }}
{{- end -}}
{{- end -}}
