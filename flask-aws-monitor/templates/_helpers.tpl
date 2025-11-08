{{/* Base name */}}
{{- define "flask-aws-monitor.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/* Full release name */}}
{{- define "flask-aws-monitor.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else }}
{{- $name := include "flask-aws-monitor.name" . }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end }}
{{- end }}
{{- end }}

{{/* Chart label */}}
{{- define "flask-aws-monitor.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end }}

{{/* Common labels */}}
{{- define "flask-aws-monitor.labels" -}}
helm.sh/chart: {{ include "flask-aws-monitor.chart" . }}
app.kubernetes.io/name: {{ include "flask-aws-monitor.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/* Selector labels */}}
{{- define "flask-aws-monitor.selectorLabels" -}}
app.kubernetes.io/name: {{ include "flask-aws-monitor.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/* Service Account */}}
{{- define "flask-aws-monitor.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{ default (include "flask-aws-monitor.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{ default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}
