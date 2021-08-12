#!/bin/sh

repos=$(gh repo list --public --json "name,owner" --template "{{ range . }} {{ .owner.login }}/{{ .name }} {{ end }}")


for repo in $repos
do
   echo "\n-------------------------------------${repo}-------------------------------------\n"

   gh pr list -R $repo --json 'number,author,url,headRepository,title' --template '{{ range . }}{{ .number | printf "#%v" | color "green" }}{{ "\n" }}repository: {{ .headRepository.name }}{{ "\n" }}title: {{ .title }}{{ "\n" }}author: {{ .author.login }}{{ "\n" }}URL:{{ .url }}{{ "\n\n" }}{{ end }}' | tee;
done

