{{/*
Template for Migrations Job resource
*/}}
{{- define "pantry-tracker.migrationsJob" -}}
{{- $ := index . 0 -}}
{{- with index . 1 -}}
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ .name }}
  labels:
    {{- include "pantry-tracker.labels" $ | nindent 4 }}
  annotations:
    helm.sh/hook: pre-install,pre-upgrade
    helm.sh/hook-weight: "-1"
spec:
  backoffLimit: 0
  template:
    spec:
      restartPolicy: Never
      imagePullSecrets:
        - name: {{ $.Values.registry_secret.name }}
      containers:
        - name: {{ .name }}
          image: "{{ $.Values.pantryTrackerBackend.image.repository }}:{{ $.Values.pantryTrackerBackend.image.tag }}"
          imagePullPolicy: {{ $.Values.pantryTrackerBackend.image.pullPolicy }}
          command:
            {{- toYaml .command | nindent 12 }}
          envFrom:
            - configMapRef:
                name: {{ $.Values.pantryTrackerBackend.name }}
                optional: false
            - secretRef:
                name: {{ $.Values.pantryTrackerBackend.name }}
                optional: false
{{- end -}}
{{- end -}}
