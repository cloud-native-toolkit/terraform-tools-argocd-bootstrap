#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

ARGOCD_HOST="$1"
ARGOCD_USER="$2"
GIT_REPO="$3"

if [[ -z "${ARGOCD_HOST}" ]] || [[ -z "${ARGOCD_USER}" ]] || [[ -z "${GIT_REPO}" ]]; then
  echo "Usage: argocd-bootstrap.sh ARGOCD_HOST ARGOCD_USER GIT_REPO"
  exit 1
fi

if [[ -z "${ARGOCD_PASSWORD}" ]]; then
  echo "ARGOCD_PASSWORD must be provided as environment variable"
  exit 1
fi

ARGOCD=$(command -v argocd || command -v ./bin/argocd)

if [[ -z "${ARGOCD}" ]]; then
  VERSION=$(curl --silent "https://api.github.com/repos/argoproj/argo-cd/releases/latest" | grep '"tag_name"' | sed -E 's/.*"([^"]+)".*/\1/')
  mkdir -p ./bin && curl -sSL -o ./bin/argocd https://github.com/argoproj/argo-cd/releases/download/$VERSION/argocd-linux-amd64
  chmod +x ./bin/argocd
  ARGOCD="$(cd ./bin; pwd -P)/argocd"
fi

echo "Logging into argocd: ${ARGOCD_HOST}"
${ARGOCD} login "${ARGOCD_HOST}" --username "${ARGOCD_USER}" --password "${ARGOCD_PASSWORD}" --insecure --grpc-web

echo "Deleting bootstrap application"
${ARGOCD} app create bootstrap

echo "Deleting bootstrap project"
${ARGOCD} proj delete bootstrap

echo "Removing git repo: ${GIT_REPO}"
${ARGOCD} repo rm "${GIT_REPO}"
