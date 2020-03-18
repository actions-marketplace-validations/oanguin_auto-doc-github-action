#!/bin/bash
set -u

for f in schemas/*
do
    file="$(basename -- $f)"
    redoc-cli bundle "schemas/${file}" --output "docs/${file%.*}.html" 
done

echo "::set-output name=generated-doc-url::http://generated-doc"
echo "Finished creatings docs"
exit 0