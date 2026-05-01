#!/bin/zsh

set -eu

PROJECT_NAME=$1
TAG=$2

DEBUG=0

if ! type "gsed" > /dev/null; then
    echo '\e[33m`gsed` not found. Install\e[m'
    brew install gnu-sed
fi

if ! type "gh" > /dev/null; then
    echo '\e[33m`gh` not found. Install\e[m'
    brew install gh
fi

if [ `git symbolic-ref --short HEAD` != 'main' ]; then
    echo '\e[33mRelease job is enabled only in main. Run in debug mode\e[m'
    DEBUG=1
fi

echo "${TAG}" | grep -wE '([0-9]+)\.([0-9]+)\.([0-9]+)' > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Invalid version format: \"${TAG}\""
    exit 1
fi

LOCAL_CHANGES=`git diff --name-only HEAD`
if [ "$LOCAL_CHANGES" = 'Makefile' ]; then
    MAKEFILE_DIFF="$(git diff -U0 Makefile | grep '^[+-]' | grep -Ev '^(--- a/|\+\+\+ b/)')"
    if [ "$(echo $MAKEFILE_DIFF | grep -Ev '^[+-]ver = [0-9]*\.[0-9]*\.[0-9]*$')" != '' ]; then
        echo '\e[31m[Error] There are some local changes.\e[m'
        exit 1
    fi
elif [ "$LOCAL_CHANGES" != '' ]; then
    echo '\e[31m[Error] There are some local changes.\e[m'
    exit 1
fi

# Validate
if git rev-parse "${TAG}" >/dev/null 2>&1; then
    echo "\e[31m[Error] Version \"${TAG}\" already exists.\e[m"
    exit 1
fi

README_VERSION=$(cat README.md | grep '.package(url: ' | awk '{ print $NF }' | sed -E 's/\"(.*)\"\)?\)?,?/\1/')
if [ "${TAG}" != "${README_VERSION}" ]; then
    sed -i '' -E "s/(\.package\(url: \".*${PROJECT_NAME}\.git\", from: \").*(\"\),)/\1${TAG}\2/g" README.md
fi

COMMIT_OPTION=''
if [ $DEBUG -ne 0 ]; then
    COMMIT_OPTION='--dry-run'
fi

git commit $COMMIT_OPTION -m "Bump version to ${TAG}" Makefile README.md

if [ $DEBUG -eq 0 ]; then
    git push origin main

    # GitHub Release
    gh release create "${TAG}"
fi
