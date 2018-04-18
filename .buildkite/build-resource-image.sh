#!/usr/bin/env bash

RESOURCE="${1}"
if [[ -z "${RESOURCE}" ]]; then
    echo "usage: $0 <resource> <tag>" >&2
    exit 1
fi

TAG="${2}"
if [[ -z "${TAG}" ]]; then
    echo "usage: $0 <resource> <tag>" >&2
    exit 1
fi

DOCKERFILE="${3}"
if [[ -z "${DOCKERFILE}" ]]; then
    DOCKERFILE="./resources/Dockerfile.${RESOURCE}"
fi
if [[ ! -f "${DOCKERFILE}" ]]; then
    echo "could not find '${DOCKERFILE}'" >&2
    exit 1
fi

set -euo pipefail

sed -i "s/^FROM \(kfirz\/.\+\):.\+/FROM \1:'${TAG}'/" ${DOCKERFILE}
docker build --build-arg "VERSION=${TAG}" -t kfirz/deployster-${RESOURCE}:${TAG} -f ${DOCKERFILE} ./resources
docker push kfirz/deployster-${RESOURCE}:${TAG}

exit 0
