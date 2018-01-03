#!/usr/bin/env bash

set -euo pipefail

function retag_resource() {
    echo "docker tag kfirz/deployster-${1}:${RELEASE} kfirz/deployster-${1}:latest"
}

function push_resource() {
    echo "docker push kfirz/deployster-${1}:latest"
}

echo "+++ Generating pipeline"
echo "" > ./.buildkite/pipeline.yml
echo "steps:" >> ./.buildkite/pipeline.yml

echo "  - label: Re-tag resource images tagged as '${RELEASE}' with 'latest'" >> ./.buildkite/pipeline.yml
echo "    command:" >> ./.buildkite/pipeline.yml
echo "      - docker tag kfirz/deployster:${RELEASE} kfirz/deployster:latest" >> ./.buildkite/pipeline.yml
for name in "dresource" "gcp" "k8s" "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project" "k8s-clusterrole" "k8s-clusterrolebinding" "k8s-configmap" "k8s-cronjob" "k8s-daemonset" "k8s-deployment" "k8s-horizontalpodautoscaler" "k8s-ingress" "k8s-job" "k8s-namespace" "k8s-networkpolicy" "k8s-node" "k8s-persistentvolume" "k8s-persistentvolumeclaim" "k8s-pod" "k8s-replicaset" "k8s-replicationcontroller" "k8s-role" "k8s-rolebinding" "k8s-secret" "k8s-service" "k8s-serviceaccount" "k8s-statefulset" "k8s-storageclass"; do
    echo "      - $(retag_resource ${name})" >> ./.buildkite/pipeline.yml
done

echo "  - label: Push 'kfirz/deployster:latest'" >> ./.buildkite/pipeline.yml
echo "    command: docker push kfirz/deployster:latest" >> ./.buildkite/pipeline.yml
for name in "dresource" "gcp" "k8s" "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project" "k8s-clusterrole" "k8s-clusterrolebinding" "k8s-configmap" "k8s-cronjob" "k8s-daemonset" "k8s-deployment" "k8s-horizontalpodautoscaler" "k8s-ingress" "k8s-job" "k8s-namespace" "k8s-networkpolicy" "k8s-node" "k8s-persistentvolume" "k8s-persistentvolumeclaim" "k8s-pod" "k8s-replicaset" "k8s-replicationcontroller" "k8s-role" "k8s-rolebinding" "k8s-secret" "k8s-service" "k8s-serviceaccount" "k8s-statefulset" "k8s-storageclass"; do
    echo "  - label: Push 'kfirz/deployster-${name}:latest'" >> ./.buildkite/pipeline.yml
    echo "    command: $(push_resource ${name})" >> ./.buildkite/pipeline.yml
done

echo "--- Show pipeline"
cat ./.buildkite/pipeline.yml

echo "--- Uploading pipeline"
cat ./.buildkite/pipeline.yml | buildkite-agent pipeline upload

exit 0
