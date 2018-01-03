#!/usr/bin/env bash

set -euo pipefail

RELEASE_AND_SHA="${RELEASE}-${BUILDKITE_COMMIT}"

function build_deployster() {
    echo "docker build --build-arg "VERSION=${RELEASE_AND_SHA}" -t kfirz/deployster:${RELEASE_AND_SHA} -f ./Dockerfile ."
}

function build_resource() {
    echo "docker build --build-arg "VERSION=${RELEASE_AND_SHA}" -t kfirz/deployster-${1}:${RELEASE_AND_SHA} -f ./resources/Dockerfile.${1} ./resources"
}

function build_k8s_resource() {
    echo "docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-${1}:${RELEASE_AND_SHA}"
}

function push_resource() {
    echo "docker push kfirz/deployster-${1}:${RELEASE_AND_SHA}"
}

echo "+++ Generating pipeline"
echo "" > ./.buildkite/pipeline.yml
echo "steps:" >> ./.buildkite/pipeline.yml

echo "  - label: Run tests" >> ./.buildkite/pipeline.yml
echo "    command: source ./.buildkite/test.sh" >> ./.buildkite/pipeline.yml

echo "  - label: Build 'kfirz/deployster'" >> ./.buildkite/pipeline.yml
echo "    command: $(build_deployster)" >> ./.buildkite/pipeline.yml
echo "  - label: Build 'kfirz/deployster-dresource'" >> ./.buildkite/pipeline.yml
echo "    command: $(build_resource dresource)" >> ./.buildkite/pipeline.yml

echo "  - wait" >> ./.buildkite/pipeline.yml
for name in "gcp" "k8s"; do
    echo "  - label: Build 'kfirz/deployster-${name}'" >> ./.buildkite/pipeline.yml
    echo "    command: $(build_resource ${name})" >> ./.buildkite/pipeline.yml
done

echo "  - wait" >> ./.buildkite/pipeline.yml
for name in "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project"; do
    echo "  - label: Build 'kfirz/deployster-${name}'" >> ./.buildkite/pipeline.yml
    echo "    command: $(build_resource ${name})" >> ./.buildkite/pipeline.yml
done
echo "  - label: Re-tagging 'kfirz/deployster-k8s' as specific Kubernetes resource images" >> ./.buildkite/pipeline.yml
echo "    command:" >> ./.buildkite/pipeline.yml
for name in "clusterrole" "clusterrolebinding" "configmap" "cronjob" "daemonset" "deployment" "horizontalpodautoscaler" "ingress" "job" "namespace" "networkpolicy" "node" "persistentvolume" "persistentvolumeclaim" "pod" "replicaset" "replicationcontroller" "role" "rolebinding" "secret" "service" "serviceaccount" "statefulset" "storageclass"; do
    echo "      - $(build_k8s_resource ${name})" >> ./.buildkite/pipeline.yml
done

echo "  - wait" >> ./.buildkite/pipeline.yml
echo "  - label: Push 'kfirz/deployster'" >> ./.buildkite/pipeline.yml
echo "    command: docker push kfirz/deployster:${RELEASE_AND_SHA}" >> ./.buildkite/pipeline.yml
for name in "dresource" "gcp" "k8s" "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project" "k8s-clusterrole" "k8s-clusterrolebinding" "k8s-configmap" "k8s-cronjob" "k8s-daemonset" "k8s-deployment" "k8s-horizontalpodautoscaler" "k8s-ingress" "k8s-job" "k8s-namespace" "k8s-networkpolicy" "k8s-node" "k8s-persistentvolume" "k8s-persistentvolumeclaim" "k8s-pod" "k8s-replicaset" "k8s-replicationcontroller" "k8s-role" "k8s-rolebinding" "k8s-secret" "k8s-service" "k8s-serviceaccount" "k8s-statefulset" "k8s-storageclass"; do
    echo "  - label: Push 'kfirz/deployster-${name}'" >> ./.buildkite/pipeline.yml
    echo "    command: $(push_resource ${name})" >> ./.buildkite/pipeline.yml
done

echo "--- Show pipeline"
cat ./.buildkite/pipeline.yml

echo "--- Uploading pipeline"
cat ./.buildkite/pipeline.yml | buildkite-agent pipeline upload

exit 0
