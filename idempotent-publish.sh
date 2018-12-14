#!/usr/bin/env bash

PROJECT_NAME=$(jq -r .name < package.json)
COMMITTED_VERSION=$(npm ls ${PROJECT_NAME} --json | jq -r .version)
PUBLISHED_VERSION=$(npm view ${PROJECT_NAME} --json | jq -r .version)

if [ ${COMMITTED_VERSION} != ${PUBLISHED_VERSION} ]; then
    yarn build
    npm publish
else
    echo "Version $COMMITTED_VERSION of $PROJECT_NAME has already been published"
fi
