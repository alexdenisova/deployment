{{/*
Template for Backend Deployment resource
*/}}
{{- define "pantry-tracker.backendDeployment" -}}
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
          image: "{{ $.Values.backend.image.repository }}:{{ $.Values.backend.image.tag }}"
          imagePullPolicy: {{ $.Values.backend.image.pullPolicy }}
          command:
            {{- toYaml .command | nindent 12 }}
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
          {{- if .livenessPath }}
          livenessProbe:
            httpGet:
              path: {{ .livenessPath }}
              port: {{ get (include "pantry-tracker.servicePort" $ | fromYaml) "name" }}
          {{- end }}
          {{- if .readinessPath }}
          readinessProbe:
            httpGet:
              path: {{ .readinessPath }}
              port: {{ get (include "pantry-tracker.servicePort" $ | fromYaml) "name" }}
          {{- end }}
          resources:
            {{- toYaml .resources | nindent 12 }}
{{- end -}}
{{- end -}}
