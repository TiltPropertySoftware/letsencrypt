#!/bin/bash
#
# Generic docker image build script - tag based on repo name
#

THIS_SCRIPT=${BASH_SOURCE[0]:-$0}
if [[ -L "${THIS_SCRIPT}" ]]; then
  THIS_SCRIPT=$(readlink "${THIS_SCRIPT}" 2>&1)
fi
SCRIPT_HOME="$( cd "$( dirname "${THIS_SCRIPT}" )/" && pwd )"

GITHUB_URL=$(git remote get-url origin)
GITHUB_REGEX="(git@github.com:|https://github.com/)([a-zA-Z0-9]+)/([a-zA-Z0-9\-]+).git"
if [[ $GITHUB_URL =~ $GITHUB_REGEX ]]; then
  export GITHUB_ORG="${BASH_REMATCH[2]}"
  export GITHUB_PROJECT="${BASH_REMATCH[3]}"
else
  echo "ERROR: Can't detect GITHUB_ORG and GITHUB_PROJECT"
  exit 2
fi

DOCKER_REPO=$(echo ${GITHUB_ORG} | tr '[:upper:]' '[:lower:]')
DOCKER_IMAGE=$(echo ${GITHUB_PROJECT} | tr '[:upper:]' '[:lower:]')

docker build -f Dockerfile -t ${DOCKER_REPO}/${DOCKER_IMAGE} .
docker push ${DOCKER_REPO}/${DOCKER_IMAGE}:latest
