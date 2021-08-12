{{/*
Expand the name of the chart.
*/}}
{{- define "cluster-overprovisioner.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 60 | trimSuffix "-" }}
{{- end }}

{{/*
Expand a name for the cpa component.
*/}}
{{- define "cluster-overprovisioner.cpa.name" -}}
{{- default (printf "%s-%s" (include "cluster-overprovisioner.name" .) "cpa") .Values.cpa.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Expand the name for the op component.
*/}}
{{- define "cluster-overprovisioner.op.name" -}}
{{- default (printf "%s-%s" (include "cluster-overprovisioner.name" .) "op") .Values.cpa.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified name for cpa comp.
*/}}
{{- define "cluster-overprovisioner.cpa.fullname" -}}
{{- if .Values.cpa.fullnameOverride }}
{{- .Values.cpa.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (include "cluster-overprovisioner.cpa.name" .) .Values.cpa.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create a default fully qualified name for op comp.
*/}}
{{- define "cluster-overprovisioner.op.fullname" -}}
{{- if .Values.op.fullnameOverride }}
{{- .Values.op.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default (include "cluster-overprovisioner.op.name" .) .Values.op.nameOverride }}
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
{{- define "cluster-overprovisioner.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "cluster-overprovisioner.labels" -}}
helm.sh/chart: {{ include "cluster-overprovisioner.chart" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
CPA Common Labels
*/}}
{{- define "cluster-overprovisioner.cpa.labels" -}}
{{ include "cluster-overprovisioner.labels" . }}
{{ include "cluster-overprovisioner.cpa.selectorLabels" . }}
{{- end }}

{{/*
OP Common Labels
*/}}
{{- define "cluster-overprovisioner.op.labels" -}}
{{ include "cluster-overprovisioner.labels" . }}
{{ include "cluster-overprovisioner.op.selectorLabels" . }}
{{- end }}

{{/*
CPA selector labels
*/}}
{{- define "cluster-overprovisioner.cpa.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cluster-overprovisioner.cpa.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
OP selector labels
*/}}
{{- define "cluster-overprovisioner.op.selectorLabels" -}}
app.kubernetes.io/name: {{ include "cluster-overprovisioner.op.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to be used by op comp
*/}}
{{- define "cluster-overprovisioner.op.serviceAccountName" -}}
{{- if .Values.op.serviceAccount.create }}
{{- default (include "cluster-overprovisioner.op.fullname" .) .Values.op.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.op.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service account to be used by cpa comp
*/}}
{{- define "cluster-overprovisioner.cpa.serviceAccountName" -}}
{{- if .Values.cpa.serviceAccount.create }}
{{- default (include "cluster-overprovisioner.cpa.fullname" .) .Values.cpa.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.cpa.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Define CPA target resource
*/}}
{{- define "cluster-overprovisioner.cpa.target.name" -}}
{{- if .Values.op.enabled }}
{{- printf "%s/%s" "deployment" (include "cluster-overprovisioner.op.fullname" .) }}
{{- else }}
{{- .Values.cpa.target.name }}
{{- end }}
{{- end }}

{{/*
Define CPA target namespace
*/}}
{{- define "cluster-overprovisioner.cpa.target.namespace" -}}
{{- if .Values.op.enabled }}
{{- .Release.Namespace }}
{{- else }}
{{- .Values.cpa.target.namespace }}
{{- end }}
{{- end }}