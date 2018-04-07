#!/usr/bin/env bash

########################################################################################################################
# This script is run by the BuildKite pipeline.
# It generates a BuildKite pipeline YAML (which will be fed by the caller to the BuildKite agent)
########################################################################################################################

TAG="${1}"
if [[ -z "${1}" ]]; then
    echo "usage: $0 <tag>" >&2
    exit 1
fi

function build_resource() {
    echo "docker build --build-arg \"VERSION=${TAG}\" -t kfirz/deployster-${1}:${TAG} -f ./resources/Dockerfile.${1} ./resources"
}

echo "steps:"
echo "  - label: Build 'kfirz/deployster'"
echo "    plugins:"
echo "      docker-login#v1.0.0:"
echo "        username: arikkfir"
echo "    command:"
echo "      - docker build --build-arg "VERSION=${TAG}" -t kfirz/deployster:${TAG} -f ./Dockerfile ."
echo "      - docker push kfirz/deployster:${TAG}"
echo "  - label: Build \"dresource\" images"
echo "    plugins:"
echo "      docker-login#v1.0.0:"
echo "        username: arikkfir"
echo "    command:"
echo "      - $(build_resource dresource)"
echo "      - docker push kfirz/deployster-dresource:${TAG}"
echo "  - wait"
echo "  - label: Build \"gcp\" resource images"
echo "    plugins:"
echo "      docker-login#v1.0.0:"
echo "        username: arikkfir"
echo "    command:"
echo '      - sed -i "s/^FROM \(kfirz\/.\+\):.\+/FROM \1:'${TAG}'/" ./resources/Dockerfile.gcp'
echo "      - $(build_resource gcp)"
echo "      - docker push kfirz/deployster-gcp:${TAG}"
echo "  - label: Build \"k8s\" resource images"
echo "    plugins:"
echo "      docker-login#v1.0.0:"
echo "        username: arikkfir"
echo "    command:"
echo '      - sed -i "s/^FROM \(kfirz\/.\+\):.\+/FROM \1:'${TAG}'/" ./resources/Dockerfile.k8s'
echo "      - $(build_resource k8s)"
echo "      - docker push kfirz/deployster-k8s:${TAG}"
echo "  - wait"
for name in "gcp-cloud-sql" "gcp-compute-ip-address" "gcp-gke-cluster" "gcp-iam-policy" "gcp-iam-service-account" "gcp-project"; do
    echo "  - label: Build 'kfirz/deployster-${name}'"
    echo "    plugins:"
    echo "      docker-login#v1.0.0:"
    echo "        username: arikkfir"
    echo "    command:"
    echo '      - sed -i "s/^FROM \(kfirz\/.\+\):.\+/FROM \1:'${TAG}'/" ./resources/Dockerfile.'${name}
    echo "      - $(build_resource ${name})"
    echo "      - docker push kfirz/deployster-${name}:${TAG}"
done
for name in "clusterrole" "clusterrolebinding" "configmap" "cronjob" "daemonset" "deployment" "horizontalpodautoscaler" "ingress" "job" "namespace" "networkpolicy" "node" "persistentvolume" "persistentvolumeclaim" "pod" "replicaset" "replicationcontroller" "role" "rolebinding" "secret" "service" "serviceaccount" "statefulset" "storageclass"; do
    echo "  - label: Build 'kfirz/deployster-k8s-${name}'"
    echo "    plugins:"
    echo "      docker-login#v1.0.0:"
    echo "        username: arikkfir"
    echo "    command:"
    echo "      - docker tag kfirz/deployster-k8s:${TAG} kfirz/deployster-k8s-${name}:${TAG}"
    echo "      - docker push kfirz/deployster-k8s-${name}:${TAG}"
done

exit 0
