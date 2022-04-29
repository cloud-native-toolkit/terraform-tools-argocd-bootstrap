#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname "$0"); pwd -P)
REPO_DIR=$(cd ${SCRIPT_DIR}/../..; pwd -P)

if [[ -n "$GITHUB_USERNAME" ]] && [[ -n "$GITHUB_TOKEN" ]]; then
  GITHUB_AUTH="-u ${GITHUB_USERNAME}:${GITHUB_TOKEN}"
fi

CHANGED_REPO="$1"

if [[ -n "${CHANGED_REPO}" ]]; then
  echo "** Updating modules based on filter: ${CHANGED_REPO}"
else
  echo "** Updating all modules"
fi

set -e

find "${REPO_DIR}" -name "*.tf" -maxdepth 1 | while read stageFile; do
  SOURCES=$(grep -E 'source *=' "${stageFile}" | sed -E 's/.*source *= *"(.*)"/\1/g')

  echo "${SOURCES}" | while read -r source; do
    if [[ -z "${source}" ]]; then
      continue
    fi

    if [[ "${source}" =~ ^github.com ]]; then
      git_slug=$(echo "$source" | sed -E 's~github.com/(.*)\?.*~\1~g' | sed "s/.git//g")
    else
      git_slug=$(echo "${source}" | sed -E "s~([^/]+)/([^/]+)/([^/]+)~\1/terraform-\3-\2~g")
    fi

    if [[ -z "${CHANGED_REPO}" ]] || [[ "${git_slug}" == "${CHANGED_REPO}" ]]; then
      echo " - Updating stage: $stageFile"
      echo " - Checking for latest version of ${git_slug}"
    else
      continue
    fi

    git_release_url="https://api.github.com/repos/${git_slug}/releases/latest"

    latest_release=$(curl ${GITHUB_AUTH} -s "${git_release_url}" | grep tag_name | sed -E "s/.*\"tag_name\": \"(.*)\".*/\1/")

    if [[ -z "${latest_release}" ]]; then
      echo "  ** Release not found for ${git_release_url}"
      continue
    fi

    if [[ "${source}" =~ ^github.com ]]; then
      latest_source=$(echo "${source}" | sed -E "s/(.*)=.*/\1=${latest_release}/g")

      echo "  ++ Latest source for ${git_slug} is ${latest_source}"
      sed "s~${source}~${latest_source}~g" "${stageFile}" > "${stageFile}.tmp" && \
        rm "${stageFile}" && \
        mv "${stageFile}.tmp" "${stageFile}"
    else
      current_version=$(grep -E "source *= *\"${source}\"" -A 1 | grep 'version *= *"(.*)"')

      sed "s~version *= *\"${current_version}\"~version = \"${latest_release}\"" > "${stageFile}.tmp" && \
        rm "${stageFile}" && \
        mv "${stageFile}.tmp" "${stageFile}"
    fi
  done
done
