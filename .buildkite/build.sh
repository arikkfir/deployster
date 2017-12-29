#!/usr/bin/env bash

REPOSITORY="eu.gcr.io/kfirs-gcr"

if [[ -n "${CI}" ]]; then
    PUSH="1"
    if [[ -n "${BUILDKITE}" ]]; then
        if [[ -n "${BUILDKITE_TAG}" ]]; then
            COMMIT_SHA="${BUILDKITE_COMMIT}"
            TAG="${BUILDKITE_TAG}"
            source $(dirname $0)/build-tag.sh

        elif [[ -n "${BUILDKITE_COMMIT}" ]]; then
            TAG="${BUILDKITE_COMMIT}"
            source $(dirname $0)/build-branch.sh

        else
            echo "Running in CI, but both BUILDKITE_TAG and BUILDKITE_COMMIT are empty!" >&2
            exit 1
        fi
    else
        echo "Running in an unrecognized CI system: ${CI}" >&2
        exit 1
    fi
else
    PUSH="0"
    TAG="0.0.0"
    source $(dirname $0)/build-branch.sh
fi

exit 0
