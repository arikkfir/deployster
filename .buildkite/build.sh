#!/usr/bin/env bash

set -euo pipefail

TAG="${RELEASE}-${BUILDKITE_COMMIT}"

function build_resource() {
    echo "docker build --build-arg \"VERSION=${TAG}\" -t kfirz/deployster-${1}:${TAG} -f ./resources/Dockerfile.${1} ./resources"
}

echo "+++ Generating pipeline"
echo "" > ./.buildkite/pipeline.yml
echo "steps:" >> ./.buildkite/pipeline.yml

echo "  - label: Run tests" >> ./.buildkite/pipeline.yml
echo "    command: source ./.buildkite/test.sh" >> ./.buildkite/pipeline.yml

echo "  - label: Build & push 'kfirz/deployster'" >> ./.buildkite/pipeline.yml
echo "    command:" >> ./.buildkite/pipeline.yml
echo "      - docker build --build-arg \"VERSION=${TAG}\" -t kfirz/deployster:${TAG} -f ./Dockerfile ." >> ./.buildkite/pipeline.yml
echo "      - docker push kfirz/deployster:${TAG}" >> ./.buildkite/pipeline.yml

echo "  - label: Build & push base resource images" >> ./.buildkite/pipeline.yml
echo "    command:" >> ./.buildkite/pipeline.yml
echo "      - $(build_resource dresource)" >> ./.buildkite/pipeline.yml
echo "      - docker push kfirz/deployster-dresource:${TAG}" >> ./.buildkite/pipeline.yml
echo "      - $(build_resource gcp)" >> ./.buildkite/pipeline.yml
echo "      - docker push kfirz/deployster-gcp:${TAG}" >> ./.buildkite/pipeline.yml
echo "      - $(build_resource k8s)" >> ./.buildkite/pipeline.yml
echo "      - docker push kfirz/deployster-k8s:${TAG}" >> ./.buildkite/pipeline.yml

echo "  - wait" >> ./.buildkite/pipeline.yml
for name in "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project"; do
    echo "  - label: Build & push 'kfirz/deployster-${name}'" >> ./.buildkite/pipeline.yml
    echo "    command:" >> ./.buildkite/pipeline.yml
    echo "      - $(build_resource ${name})" >> ./.buildkite/pipeline.yml
    echo "      - docker push kfirz/deployster-${name}:${TAG}" >> ./.buildkite/pipeline.yml
done
for name in "clusterrole" "clusterrolebinding" "configmap" "cronjob" "daemonset" "deployment" "horizontalpodautoscaler" "ingress" "job" "namespace" "networkpolicy" "node" "persistentvolume" "persistentvolumeclaim" "pod" "replicaset" "replicationcontroller" "role" "rolebinding" "secret" "service" "serviceaccount" "statefulset" "storageclass"; do
    echo "  - label: Build & push 'kfirz/deployster-k8s-${name}'" >> ./.buildkite/pipeline.yml
    echo "    command:" >> ./.buildkite/pipeline.yml
    echo "      - docker tag kfirz/deployster-k8s:${TAG} kfirz/deployster-k8s-${name}:${TAG}" >> ./.buildkite/pipeline.yml
    echo "      - docker push kfirz/deployster-k8s-${name}:${TAG}" >> ./.buildkite/pipeline.yml
done

echo "--- Show pipeline"
cat ./.buildkite/pipeline.yml

echo "--- Uploading pipeline"
cat ./.buildkite/pipeline.yml | buildkite-agent pipeline upload

exit 0
