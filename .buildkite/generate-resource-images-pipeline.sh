#!/usr/bin/env bash

TAG="${1}"
if [[ -z "${1}" ]]; then
    echo "usage: $0 <tag>" >&2
    exit 1
fi

echo "steps:"
for name in "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project"; do
    echo "  - label: kfirz/deployster-${name}"
    echo "    plugins: { docker-login#v1.0.0: { username: arikkfir} }"
    echo "    command: ./.buildkite/build-resource-image.sh ${name} ${TAG}"
done
for name in "clusterrole" "clusterrolebinding" "configmap" "cronjob" "daemonset" "deployment" "horizontalpodautoscaler" "ingress" "job" "namespace" "networkpolicy" "node" "persistentvolume" "persistentvolumeclaim" "pod" "replicaset" "replicationcontroller" "role" "rolebinding" "secret" "service" "serviceaccount" "statefulset" "storageclass"; do
    echo "  - label: kfirz/deployster-k8s-${name}"
    echo "    plugins: { docker-login#v1.0.0: { username: arikkfir} }"
    echo "    command:"
    echo "      - docker tag kfirz/deployster-k8s:${TAG} kfirz/deployster-k8s-${name}:${TAG}"
    echo "      - docker push kfirz/deployster-k8s-${name}:${TAG}"
done

exit 0
