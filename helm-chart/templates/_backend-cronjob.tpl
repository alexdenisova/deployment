{{/*
Template for CronJob resource
*/}}
{{- define "pantry-tracker.backendCronJob" -}}
{{- $ := index . 0 -}}
{{- with index . 1 -}}
{{- $selectorLabels := dict "app.kubernetes.io/name" $.Chart.Name "app.kubernetes.io/instance" .name -}}
apiVersion: batch/v1
kind: CronJob
metadata:
  name: {{ .name }}
  labels:
    {{- include "pantry-tracker.labels" $ | nindent 4 }}
spec:
  schedule: {{ .schedule }}
  jobTemplate:
    spec:
      template:
        metadata:
          name: {{ .name }}
          labels:
            {{- toYaml $selectorLabels | nindent 12 }}
        spec:
          restartPolicy: OnFailure
          imagePullSecrets:
            - name: {{ $.Values.registry_secret.name }}
          containers:
            - name: {{ .name }}
              image: "{{ $.Values.backend.image.repository }}:{{ $.Values.backend.image.tag }}"
              imagePullPolicy: {{ $.Values.backend.image.pullPolicy }}
              command:
                {{- toYaml .command | nindent 16 }}
              envFrom:
                - configMapRef:
                    name: {{ $.Values.backend.name }}
                    optional: false
                - secretRef:
                    name: {{ $.Values.backend.name }}
                    optional: false
              ports:
                - name: {{ get (include "pantry-tracker.servicePort" $ | fromYaml) "name" }}
                  containerPort: {{ $.Values.backend.port }}
                  protocol: {{ get (include "pantry-tracker.servicePort" $ | fromYaml) "protocol" }}
              resources:
                {{- toYaml .resources | nindent 16 }}
{{- end -}}
{{- end -}}
