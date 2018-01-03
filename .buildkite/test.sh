#!/usr/bin/env bash

set -euo pipefail
RELEASE_AND_SHA="${RELEASE:-0.0.0}-${BUILDKITE_COMMIT:-local}"

echo "--- Building test image"
docker build --file ./Dockerfile.test --tag infolinks/deployster-tests:${RELEASE_AND_SHA} .

echo "--- Running tests"
docker run --env COVERALLS_REPO_TOKEN="${COVERALLS_REPO_TOKEN}" \
           --env BUILDKITE="${BUILDKITE}" \
           --env BUILDKITE_JOB_ID="${BUILDKITE_JOB_ID}" \
           --env BUILDKITE_BRANCH="${BUILDKITE_BRANCH}" \
           --tty \
           infolinks/deployster-tests:${RELEASE_AND_SHA} \
           $@
