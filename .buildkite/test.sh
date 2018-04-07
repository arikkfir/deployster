#!/usr/bin/env bash

set -euo pipefail

echo "--- Building test image"
docker build --file ./Dockerfile.test --tag infolinks/deployster-tests:${BUILDKITE_COMMIT:-local} .

echo "--- Running tests"
docker run --env COVERALLS_REPO_TOKEN="$(cat /buildkite/secrets/coveralls-token.txt)" \
           --env BUILDKITE="${BUILDKITE}" \
           --env BUILDKITE_JOB_ID="${BUILDKITE_JOB_ID}" \
           --env BUILDKITE_BRANCH="${BUILDKITE_BRANCH}" \
           --tty \
           infolinks/deployster-tests:${BUILDKITE_COMMIT:-local} \
           $@
