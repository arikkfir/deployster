#!/usr/bin/env bash

set -euo pipefail

RELEASE_AND_SHA="${RELEASE}-${BUILDKITE_COMMIT}"

echo "+++ Generating pipeline"
echo "" > ./.buildkite/pipeline.yml

echo "env:" >> ./.buildkite/pipeline.yml
echo "  RELEASE: ${RELEASE}" >> ./.buildkite/pipeline.yml
echo "steps:" >> ./.buildkite/pipeline.yml
echo "  - label: Test" >> ./.buildkite/pipeline.yml
echo "    command: source ./.buildkite/test.sh" >> ./.buildkite/pipeline.yml
echo "  - label: Build & push Deployster image" >> ./.buildkite/pipeline.yml
echo "    command:" >> ./.buildkite/pipeline.yml
echo "      - docker build --build-arg \"VERSION=${RELEASE_AND_SHA}\" -t kfirz/deployster:${RELEASE_AND_SHA} -f ./Dockerfile ." >> ./.buildkite/pipeline.yml
echo "      - docker push kfirz/deployster:${RELEASE_AND_SHA}" >> ./.buildkite/pipeline.yml

BASE_IMAGES=( "dresource" "gcp" "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project" "k8s" )
echo "  - label: Build & push base images" >> ./.buildkite/pipeline.yml
echo "    command:" >> ./.buildkite/pipeline.yml
for name in "${BASE_IMAGES[@]}"; do
    echo "      - docker build --build-arg \"VERSION=${RELEASE_AND_SHA}\" -t kfirz/deployster-${name}:${RELEASE_AND_SHA} -f ./resources/Dockerfile.${name} ./resources" >> ./.buildkite/pipeline.yml
    echo "      - docker push kfirz/deployster-${name}:${RELEASE_AND_SHA}" >> ./.buildkite/pipeline.yml
done

echo "  - wait" >> ./.buildkite/pipeline.yml

K8S_RESOURCE_NAMES=( "clusterrole" "clusterrolebinding" "configmap" "cronjob" "daemonset" "deployment" "horizontalpodautoscaler" "ingress" "job" "namespace" "networkpolicy" "node" "persistentvolume" "persistentvolumeclaim" "pod" "replicaset" "replicationcontroller" "role" "rolebinding" "secret" "service" "serviceaccount" "statefulset" "storageclass" )
echo "  - label: Alias 'k8s' image as resource-specific images" >> ./.buildkite/pipeline.yml
echo "    command:" >> ./.buildkite/pipeline.yml
for name in "${K8S_RESOURCE_NAMES[@]}"; do
    echo "      - docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-${name}:${RELEASE_AND_SHA}" >> ./.buildkite/pipeline.yml
    echo "      - docker push kfirz/deployster-k8s-${name}:${RELEASE_AND_SHA}" >> ./.buildkite/pipeline.yml
done

echo "--- Show pipeline"
cat ./.buildkite/pipeline.yml

echo "--- Uploading pipeline"
cat ./.buildkite/pipeline.yml | buildkite-agent pipeline upload

exit 0
