{{/*
Template for Frontend Deployment resource
*/}}
{{- define "pantry-tracker.frontendDeployment" -}}
{{- $ := index . 0 -}}
{{- with index . 1 -}}
{{- $selectorLabels := dict "app.kubernetes.io/name" $.Chart.Name "app.kubernetes.io/instance" .name -}}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .name }}
  labels:
    {{- include "pantry-tracker.labels" $ | nindent 4 }}
spec:
  replicas: {{ .replicaCount }}
  selector:
    matchLabels:
      {{- toYaml $selectorLabels | nindent 6 }}
  template:
    metadata:
      annotations:
        {{- toYaml .annotations | nindent 8 }}
      labels:
        {{- toYaml $selectorLabels | nindent 8 }}
    spec:
      imagePullSecrets:
        - name: {{ $.Values.registry_secret.name }}
      containers:
        - name: {{ .name }}
          image: "{{ .image.repository }}:{{ .image.tag }}"
          imagePullPolicy: {{ .image.pullPolicy }}
          ports:
            - name: {{ get (include "pantry-tracker.servicePort" $ | fromYaml) "name" }}
              containerPort: {{ .port }}
              protocol: {{ get (include "pantry-tracker.servicePort" $ | fromYaml) "protocol" }}
          resources:
            {{- toYaml .resources | nindent 12 }}
{{- end -}}
{{- end -}}
