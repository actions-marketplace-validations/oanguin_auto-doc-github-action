#!/bin/bash
set -u

echo "::set-output name=generated-doc-url::http://generated-doc"

for f in schemas/*
do
    file="$(basename -- $f)"
    redoc-cli bundle "schemas/${file}" --output "docs/${file%.*}.html" 
done


echo "Finished creatings docs"
exit 0