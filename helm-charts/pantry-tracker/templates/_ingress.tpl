{{/*
Template for Ingress resource
*/}}
{{- define "pantry-tracker.ingress" -}}
{{- $ := index . 0 -}}
{{- with index . 1 -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ .name }}
  labels:
    {{- include "pantry-tracker.labels" $ | nindent 4 }}
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
spec:
  ingressClassName: {{ $.Values.ingress.className }}
  tls:
    - hosts:
        - {{ $.Values.ingress.host }}
      secretName: {{ $.Values.ingress.tls.secretName }}
  rules:
    - host: {{ $.Values.ingress.host }}
      http:
        paths:
          - path: {{ .ingressPath }}
            pathType: Prefix
            backend:
              service:
                name: {{ .name }}
                port:
                  number: {{ get (include "pantry-tracker.servicePort" . | fromYaml) "port" }}
{{- end -}}
{{- end -}}
