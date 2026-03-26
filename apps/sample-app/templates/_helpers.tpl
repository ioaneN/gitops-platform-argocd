{{- define "sample-app.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "sample-app.fullname" -}}
{{- .Release.Name -}}
{{- end -}}