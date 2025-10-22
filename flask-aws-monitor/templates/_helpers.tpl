{{/* This is a comment - Generate basic labels */}}
{{- define "monitor.labels" }}
generator: helm
date: {{ now | htmlDate }}
name: {{ .Release.Name }}
version: {{ .Chart.Version}}
{{- end }}
