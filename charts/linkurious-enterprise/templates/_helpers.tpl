{{/*
Expand the name of the chart.
*/}}
{{- define "linkurious-enterprise.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "linkurious-enterprise.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "linkurious-enterprise.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "linkurious-enterprise.labels" -}}
helm.sh/chart: {{ include "linkurious-enterprise.chart" . }}
{{ include "linkurious-enterprise.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "linkurious-enterprise.selectorLabels" -}}
app.kubernetes.io/name: {{ include "linkurious-enterprise.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "linkurious-enterprise.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "linkurious-enterprise.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Default external url
#fixing DLKE-17 bug
*/}}
{{- define "linkurious-enterprise.defaultHostUrl" -}}
{{- if eq (include "linkurious-enterprise.fullname" .) .Release.Name }}
{{- print   (include "linkurious-enterprise.fullname" .) "."  .Release.Namespace "." .Values.hostPostfix | replace (include "linkurious-enterprise.name" .) .Values.hostPrefixOverride -}}
{{- else }}
{{- print   (include "linkurious-enterprise.fullname" .) "."  .Release.Namespace "." .Values.hostPostfix | replace (print "-" (include "linkurious-enterprise.name" .)) .Values.hostPrefixOverride -}}
{{- end }}
{{- end }}

{{/*
LKE Configuration Preset Values (Incluenced by Values configuration)
*/}}
{{- define "linkurious-enterprise.config.presets" -}}
  {{- .Files.Get "docker.preset-config.json" }}
{{- end -}}

{{/*
LKE Configuration Config Values
*/}}
{{- define "linkurious-enterprise.config.values" -}}
{{- if or (.Values.configEnabled) (.Values.configOverlayEnabled) -}}
  {{- with .Values.config }}
    {{- tpl (toYaml .) $ | nindent 2 }}
  {{- end }}
{{- end -}}
{{- end -}}

{{/*
Merge LKE Configuration Config Values with Preset Configuration
*/}}
{{- define "linkurious-enterprise.config" -}}
  {{- if .Values.configEnabled -}}
{{- toYaml ( mustMergeOverwrite (default dict (fromJson (include "linkurious-enterprise.config.presets" $))) (fromYaml (include "linkurious-enterprise.config.values" $)) ) }}
  {{- else if .Values.configOverlayEnabled }}
    {{- include "linkurious-enterprise.config.values" $ }}
  {{- end -}}
{{- end -}}

