#!/usr/bin/env bash

set -euo pipefail

RELEASE_AND_SHA="${RELEASE}-${BUILDKITE_COMMIT}"

echo "+++ Generating pipeline"
echo "" > ./.buildkite/pipeline.yml
echo "env:" >> ./.buildkite/pipeline.yml
echo "  RELEASE: ${RELEASE}" >> ./.buildkite/pipeline.yml

echo "steps:" >> ./.buildkite/pipeline.yml

echo "  - label: Run tests" >> ./.buildkite/pipeline.yml
echo "    command: source ./.buildkite/test.sh" >> ./.buildkite/pipeline.yml

echo "  - label: Build 'kfirz/deployster:${RELEASE_AND_SHA}'" >> ./.buildkite/pipeline.yml
echo "    command: docker build --build-arg \"VERSION=${RELEASE_AND_SHA}\" -t kfirz/deployster:${RELEASE_AND_SHA} -f ./Dockerfile ." >> ./.buildkite/pipeline.yml
echo "  - label: Build 'kfirz/deployster-dresource:${RELEASE_AND_SHA}'" >> ./.buildkite/pipeline.yml
echo "    command: docker build --build-arg \"VERSION=${RELEASE_AND_SHA}\" -t kfirz/deployster-dresource:${RELEASE_AND_SHA} -f ./resources/Dockerfile.dresource ./resources" >> ./.buildkite/pipeline.yml

echo "  - wait" >> ./.buildkite/pipeline.yml
for name in "gcp" "k8s"; do
    echo "  - label: Build 'kfirz/deployster-${name}:${RELEASE_AND_SHA}'" >> ./.buildkite/pipeline.yml
    echo "    command: docker build --build-arg \"VERSION=${RELEASE_AND_SHA}\" -t kfirz/deployster-${name}:${RELEASE_AND_SHA} -f ./resources/Dockerfile.${name} ./resources" >> ./.buildkite/pipeline.yml
done

echo "  - wait" >> ./.buildkite/pipeline.yml
for name in "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project"; do
    echo "  - label: Build 'kfirz/deployster-${name}:${RELEASE_AND_SHA}'" >> ./.buildkite/pipeline.yml
    echo "    command: docker build --build-arg \"VERSION=${RELEASE_AND_SHA}\" -t kfirz/deployster-${name}:${RELEASE_AND_SHA} -f ./resources/Dockerfile.${name} ./resources" >> ./.buildkite/pipeline.yml
done
for name in "clusterrole" "clusterrolebinding" "configmap" "cronjob" "daemonset" "deployment" "horizontalpodautoscaler" "ingress" "job" "namespace" "networkpolicy" "node" "persistentvolume" "persistentvolumeclaim" "pod" "replicaset" "replicationcontroller" "role" "rolebinding" "secret" "service" "serviceaccount" "statefulset" "storageclass"; do
    echo "  - label: Build 'kfirz/deployster-k8s-${name}:${RELEASE_AND_SHA}'" >> ./.buildkite/pipeline.yml
    echo "    command: docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-${name}:${RELEASE_AND_SHA}" >> ./.buildkite/pipeline.yml
done

echo "  - wait" >> ./.buildkite/pipeline.yml
echo "  - label: Push 'kfirz/deployster:${RELEASE_AND_SHA}'" >> ./.buildkite/pipeline.yml
echo "    command: docker push kfirz/deployster:${RELEASE_AND_SHA}" >> ./.buildkite/pipeline.yml
for name in "dresource" "gcp" "k8s" "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project" "k8s-clusterrole" "k8s-clusterrolebinding" "k8s-configmap" "k8s-cronjob" "k8s-daemonset" "k8s-deployment" "k8s-horizontalpodautoscaler" "k8s-ingress" "k8s-job" "k8s-namespace" "k8s-networkpolicy" "k8s-node" "k8s-persistentvolume" "k8s-persistentvolumeclaim" "k8s-pod" "k8s-replicaset" "k8s-replicationcontroller" "k8s-role" "k8s-rolebinding" "k8s-secret" "k8s-service" "k8s-serviceaccount" "k8s-statefulset" "k8s-storageclass"; do
    echo "  - label: Push 'kfirz/deployster-${name}:${RELEASE_AND_SHA}'" >> ./.buildkite/pipeline.yml
    echo "    command: docker push kfirz/deployster-${name}:${RELEASE_AND_SHA}" >> ./.buildkite/pipeline.yml
done

echo "--- Show pipeline"
cat ./.buildkite/pipeline.yml

echo "--- Uploading pipeline"
cat ./.buildkite/pipeline.yml | buildkite-agent pipeline upload

exit 0
