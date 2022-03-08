#!/bin/zsh

PROJECT_NAME=$1
TAG=$2

if [ `git symbolic-ref --short HEAD` != 'main' ]; then
    echo '\e[31mRelease job is enabled only in main.\e[m'
    exit 1
fi

echo "${TAG}" | grep -wE '([0-9]+)\.([0-9]+)\.([0-9]+)' > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Invalid version format: \"${TAG}\""
    exit 1
fi

if [ "`git diff --name-only HEAD`" != '' ]; then
    echo '[Error] There are some local changes.'
    exit 1
fi

# Validate
README_VERSION=$(cat README.md | grep '.package(url: ' | awk '{ print $NF }' | sed -E 's/\"(.*)\"\)?\)?,?/\1/')
if [ "${TAG}" != "${README_VERSION}" ]; then
    echo '[Error] README.md not updated. Match version in installation.'
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

if ! type "gh" > /dev/null; then
    echo '`gh` not found. Install'
    brew install gh
fi

# Podspec
MAC_OS_VERSION="$(cat Package.swift | grep '.macOS(.v' | gsed -r "s/\s*\.macOS\(\.v([0-9_]*)\),?/\1/g" | gsed -r "s/_/./g")"
if [[ "$MAC_OS_VERSION" != *"."* ]]; then
    MAC_OS_VERSION="${MAC_OS_VERSION}.0"
fi
IOS_VERSION="$(cat Package.swift | grep '.iOS(.v' | gsed -r "s/\s*\.iOS\(\.v([0-9_]*)\),?/\1/g" | gsed -r "s/_/./g")"
if [[ "$IOS_VERSION" != *"."* ]]; then
    IOS_VERSION="${IOS_VERSION}.0"
fi
TV_OS_VERSION="$(cat Package.swift | grep '.tvOS(.v' | gsed -r "s/\s*\.tvOS\(\.v([0-9_]*)\),?/\1/g" | gsed -r "s/_/./g")"
if [[ "$TV_OS_VERSION" != *"."* ]]; then
    TV_OS_VERSION="${TV_OS_VERSION}.0"
fi
WATCH_OS_VERSION="$(cat Package.swift | grep '.watchOS(.v' | gsed -r "s/\s*\.watchOS\(\.v([0-9_]*)\),?/\1/g" | gsed -r "s/_/./g")"
if [[ "$WATCH_OS_VERSION" != *"."* ]]; then
    WATCH_OS_VERSION="${WATCH_OS_VERSION}.0"
fi

gsed -i -r "s/(s\.osx\.deployment_target\s*?=\s)\"([0-9]*\.[0-9]*(\.[0-9]*)?)\"/\1\"${MAC_OS_VERSION}\"/g" ${PROJECT_NAME}.podspec
gsed -i -r "s/(s\.ios\.deployment_target\s*?=\s)\"([0-9]*\.[0-9]*(\.[0-9]*)?)\"/\1\"${IOS_VERSION}\"/g" ${PROJECT_NAME}.podspec
gsed -i -r "s/(s\.tvos\.deployment_target\s*?=\s)\"([0-9]*\.[0-9]*(\.[0-9]*)?)\"/\1\"${TV_OS_VERSION}\"/g" ${PROJECT_NAME}.podspec
gsed -i -r "s/(s\.watchos\.deployment_target\s*?=\s)\"([0-9]*\.[0-9]*(\.[0-9]*)?)\"/\1\"${WATCH_OS_VERSION}\"/g" ${PROJECT_NAME}.podspec
gsed -i -r "s/(s\.version\s*?=\s)\"([0-9]*\.[0-9]*\.[0-9]*?)\"/\1\"${TAG}\"/g" ${PROJECT_NAME}.podspec
git commit -m "Update podspec\nBump version to ${TAG}" "${PROJECT_NAME}.podspec"
git push origin main

# GitHub Release
gh release create "${TAG}"

# CocoaPods
bundle exec pod trunk push ${PROJECT_NAME}.podspec --allow-warnings
