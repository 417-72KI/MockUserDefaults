#!/bin/zsh

PROJECT_NAME=$1
TAG=$2

if [ `git symbolic-ref --short HEAD` != 'master' ]; then
    echo '\e[31mRelease job is enabled only in master.\e[m'
    exit 1
fi

echo "${TAG}" | grep -wE '([0-9]+)\.([0-9]+)\.([0-9]+)' > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Invalid version format: \"${TAG}\""
    exit 1
fi

if git rev-parse "${TAG}" >/dev/null 2>&1; then
    echo "Version \"${TAG}\" already exists."
    exit 1
fi

if ! type "gsed" > /dev/null; then
    echo '`gsed` not found. Install'
    brew install gnu-sed
fi

if ! type "github-release" > /dev/null; then
    echo '`github-release` not found. Install'
    go get github.com/aktau/github-release
fi

# Version
gsed -i -r "s/(s\.version\s*?=\s)\"([0-9]*\.[0-9]*\.[0-9]*?)\"/\1\"${TAG}\"/g" ${PROJECT_NAME}.podspec
git commit -m "Bump version to ${TAG}" "${PROJECT_NAME}.podspec"

# TAG
git tag "${TAG}"
git push origin master "${TAG}"

# GitHub Release
github-release release \
    --user 417-72KI \
    --repo ${PROJECT_NAME} \
    --tag "${TAG}"

# CocoaPods
bundle exec pod trunk push ${PROJECT_NAME}.podspec --allow-warnings
