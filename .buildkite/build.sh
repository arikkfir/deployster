#!/usr/bin/env bash

if [[ -n "${BUILDKITE_TAG}" ]]; then
    source $(dirname $0)/build-tag.sh
elif [[ -n "${BUILDKITE_BRANCH}" ]]; then
    source $(dirname $0)/build-branch.sh
else
    echo "Both BUILDKITE_TAG and BUILDKITE_BRANCH are empty!" >&2
    exit 1
fi

exit 0
