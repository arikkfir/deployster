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

set -ex

sed -i "s/^FROM \(kfirz\/.\+\):.\+/FROM \1:'${TAG}'/" ./resources/Dockerfile.${RESOURCE}
docker build --build-arg "VERSION=${TAG}" -t kfirz/deployster-${RESOURCE}:${TAG} -f ./resources/Dockerfile.${RESOURCE} ./resources
docker push kfirz/deployster-${RESOURCE}:${TAG}

exit 0
