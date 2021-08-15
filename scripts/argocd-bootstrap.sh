#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)

ARGOCD_HOST="$1"
ARGOCD_USER="$2"
ARGOCD_NAMESPACE="$3"
GIT_REPO="$4"
GIT_USER="$5"
BOOTSTRAP_PATH="$6"

if [[ -z "${ARGOCD_HOST}" ]] || [[ -z "${ARGOCD_USER}" ]] || [[ -z "${ARGOCD_NAMESPACE}" ]] || [[ -z "${GIT_REPO}" ]] || [[ -z "${GIT_USER}" ]] || [[ -z "${BOOTSTRAP_PATH}" ]]; then
  echo "Usage: argocd-bootstrap.sh ARGOCD_HOST ARGOCD_USER ARGOCD_NAMESPACE GIT_REPO GIT_USER BOOTSTRAP_PATH"
  exit 1
fi

if [[ -z "${ARGOCD_PASSWORD}" ]] || [[ -z "${GIT_TOKEN}" ]]; then
  echo "ARGOCD_PASSWORD and GIT_TOKEN must be provided as environment variables"
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

echo "Registering git repo: ${GIT_REPO}"
${ARGOCD} repo add "${GIT_REPO}" --username "${GIT_USER}" --password "${GIT_TOKEN}" --upsert

echo "Creating bootstrap project"
${ARGOCD} proj create 0-bootstrap \
  -d "https://kubernetes.default.svc,${ARGOCD_NAMESPACE}" \
  -s "${GIT_REPO}" \
  --description "Bootstrap project resources" \
  --upsert

echo "Creating bootstrap application"
${ARGOCD} app create 0-bootstrap \
  --project 0-bootstrap \
  --repo "${GIT_REPO}" \
  --path "${BOOTSTRAP_PATH}" \
  --dest-namespace "${ARGOCD_NAMESPACE}" \
  --dest-server "https://kubernetes.default.svc" \
  --sync-policy auto \
  --self-heal \
  --auto-prune \
  --upsert
