#!/usr/bin/env bash

set -euo pipefail

if [[ "${DEPLOYMENT_ENV}" != "production" ]]; then
    echo "Only production environment is supported." >&2
    exit 1
fi

RELEASE_AND_SHA="${RELEASE}-${BUILDKITE_COMMIT}"

echo "+++ Generating pipeline"
echo "" > ./.buildkite/pipeline.yml
echo "steps:" >> ./.buildkite/pipeline.yml

echo "  - label: Re-tag resource images tagged as '${RELEASE_AND_SHA}' with '${RELEASE}'" >> ./.buildkite/pipeline.yml
echo "    command:" >> ./.buildkite/pipeline.yml
echo "      - docker tag kfirz/deployster:${RELEASE_AND_SHA} kfirz/deployster:${RELEASE}" >> ./.buildkite/pipeline.yml
for name in "dresource" "gcp" "k8s" "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project" "k8s-clusterrole" "k8s-clusterrolebinding" "k8s-configmap" "k8s-cronjob" "k8s-daemonset" "k8s-deployment" "k8s-horizontalpodautoscaler" "k8s-ingress" "k8s-job" "k8s-namespace" "k8s-networkpolicy" "k8s-node" "k8s-persistentvolume" "k8s-persistentvolumeclaim" "k8s-pod" "k8s-replicaset" "k8s-replicationcontroller" "k8s-role" "k8s-rolebinding" "k8s-secret" "k8s-service" "k8s-serviceaccount" "k8s-statefulset" "k8s-storageclass"; do
    echo "      - docker tag kfirz/deployster-${name}:${RELEASE_AND_SHA} kfirz/deployster-${name}:${RELEASE}" >> ./.buildkite/pipeline.yml
done

echo "  - wait" >> ./.buildkite/pipeline.yml

echo "  - label: Push 'kfirz/deployster:${RELEASE_AND_SHA}'" >> ./.buildkite/pipeline.yml
echo "    command: docker push kfirz/deployster:${RELEASE_AND_SHA}" >> ./.buildkite/pipeline.yml
for name in "dresource" "gcp" "k8s" "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project" "k8s-clusterrole" "k8s-clusterrolebinding" "k8s-configmap" "k8s-cronjob" "k8s-daemonset" "k8s-deployment" "k8s-horizontalpodautoscaler" "k8s-ingress" "k8s-job" "k8s-namespace" "k8s-networkpolicy" "k8s-node" "k8s-persistentvolume" "k8s-persistentvolumeclaim" "k8s-pod" "k8s-replicaset" "k8s-replicationcontroller" "k8s-role" "k8s-rolebinding" "k8s-secret" "k8s-service" "k8s-serviceaccount" "k8s-statefulset" "k8s-storageclass"; do
    echo "  - label: Push 'kfirz/deployster-${name}:${RELEASE}'" >> ./.buildkite/pipeline.yml
    echo "    command:" >> ./.buildkite/pipeline.yml
    echo "      - docker push kfirz/deployster-${name}:${RELEASE}" >> ./.buildkite/pipeline.yml
done

echo "--- Uploading pipeline"
cat ./.buildkite/pipeline.yml | buildkite-agent pipeline upload
rm -fv ./.buildkite/pipeline.yml

exit 0
