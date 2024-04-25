{{/*
Template for Service resource
*/}}
{{- define "pantry-tracker.service" -}}
{{- $ := index . 0 -}}
{{- with index . 1 -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ .name }}
  labels:
    {{- include "pantry-tracker.labels" $ | nindent 4 }}
    app.kubernetes.io/instance: {{ .name }}
spec:
  type: ClusterIP
  ports: 
    {{- include "pantry-tracker.servicePort" $ | fromYaml | list | toYaml | nindent 4 }}
  selector:
    app.kubernetes.io/name: {{ $.Chart.Name }}
    app.kubernetes.io/instance: {{ .name }}
{{- end -}}
{{- end -}}
