#!/bin/bash
set -u

repo_url=$(jq --raw-output .repository.html_url $GITHUB_EVENT_PATH)

file_tag_version=$(jq --raw-output 'if .release.tag_name != null then .release.tag_name else "" end' $GITHUB_EVENT_PATH)


doc_urls=()

for f in schemas/*
do
    file="$(basename -- $f)"
    outputfile="docs/${file%.*}${file_tag_version}.html"

    echo "file tag version ${file_tag_version}"

    if [ ! -z "$file_tag_version"]; then
        sed -E -i "s/v[0-9]+\.[0-9]+\.[0-9]+/v${VERSION}/g" "schemas/${file}"
    fi

    redoc-cli bundle "schemas/${file}" --output ${outputfile} 
    doc_urls+=outputfile
done

echo "Configuring git"
user_name=$1
user_token=$2
user_email=$3
branch=$4

git config --local user.name "${user_name}"
git config --local user.email "${user_email}"

echo "Committing changes"
git add .
git diff --cached HEAD --quiet || git commit -m "Generated documentation"

echo "Pushing changes"
git push https://${user_name}:${user_token}@github.com/${GITHUB_REPOSITORY}.git HEAD:${branch}

for doc_url in doc_urls
do
    echo "${repo_url}/${doc_url}"
done

echo "::set-output name=generated-doc-url::${repo_url}/docs"

if [ $? -ne 0 ]; then
    echo "::error::Failed to create documents"
    exit 1
fi

exit 0