#!/bin/bash
set -u

tag=$(jq --raw-output .release.tag_name $GITHUB_EVENT_PATH)

repo_url=$(jq --raw-output .repository.html_url $GITHUB_EVENT_PATH)

file_tag_version=""

if [ -n "$tag" ]; then
    file_tag_version=".v${tag}"
fi

doc_urls=()

for f in schemas/*
do
    file="$(basename -- $f)"
    outputfile="docs/${file}${file_tag_version}.html"
    redoc-cli bundle "schemas/${file}" --output ${outputfile} 
    doc_urls+=outputfile
done

echo "Configuring git"
user_name=$1
user_password=$2
user_email=$3

git config --local user.name "${user_name}"
git config --local user.email "${user_email}"

echo "Committing changes"
git add .
git diff --cached HEAD --quiet || git commit -m "Generated documentation"

echo "Pushing changes"
git pull
git push https://${user_name}:${user_password}@github.com/${GITHUB_REPOSITORY}.git HEAD:master

for doc_url in doc_urls
do
    echo "${repo_url}/${doc_url}"
done

echo "::set-output name=generated-doc-url::${repo_url}/docs"

exit 0