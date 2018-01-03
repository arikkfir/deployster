#!/usr/bin/env bash

set -euo pipefail

if [[ "${DEPLOYMENT_ENV}" != "production" ]]; then
    echo "Only production environment is supported." >&2
    exit 1
fi

RELEASE_AND_SHA="${RELEASE}-${BUILDKITE_COMMIT}"

echo "--- Login to Docker Hub"
cat ${DOCKERHUB_PASSWORD_FILE} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin

echo "--- Re-tagging resource images tagged as '${RELEASE_AND_SHA}' with '${RELEASE}'"
docker tag kfirz/deployster-dresource:${RELEASE_AND_SHA} kfirz/deployster-dresource:${RELEASE}
docker tag kfirz/deployster-gcp:${RELEASE_AND_SHA} kfirz/deployster-gcp:${RELEASE}
docker tag kfirz/deployster-gcp-cloud-sql:${RELEASE_AND_SHA} kfirz/deployster-gcp-cloud-sql:${RELEASE}
docker tag kfirz/deployster-gcp-compute-ip-address:${RELEASE_AND_SHA} kfirz/deployster-gcp-compute-ip-address:${RELEASE}
docker tag kfirz/deployster-gcp-gke-cluster:${RELEASE_AND_SHA} kfirz/deployster-gcp-gke-cluster:${RELEASE}
docker tag kfirz/deployster-gcp-iam-policy:${RELEASE_AND_SHA} kfirz/deployster-gcp-iam-policy:${RELEASE}
docker tag kfirz/deployster-gcp-iam-service-account:${RELEASE_AND_SHA} kfirz/deployster-gcp-iam-service-account:${RELEASE}
docker tag kfirz/deployster-gcp-project:${RELEASE_AND_SHA} kfirz/deployster-gcp-project:${RELEASE}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s:${RELEASE}
docker tag kfirz/deployster-k8s-clusterrole:${RELEASE_AND_SHA} kfirz/deployster-k8s-clusterrole:${RELEASE}
docker tag kfirz/deployster-k8s-clusterrolebinding:${RELEASE_AND_SHA} kfirz/deployster-k8s-clusterrolebinding:${RELEASE}
docker tag kfirz/deployster-k8s-configmap:${RELEASE_AND_SHA} kfirz/deployster-k8s-configmap:${RELEASE}
docker tag kfirz/deployster-k8s-cronjob:${RELEASE_AND_SHA} kfirz/deployster-k8s-cronjob:${RELEASE}
docker tag kfirz/deployster-k8s-daemonset:${RELEASE_AND_SHA} kfirz/deployster-k8s-daemonset:${RELEASE}
docker tag kfirz/deployster-k8s-deployment:${RELEASE_AND_SHA} kfirz/deployster-k8s-deployment:${RELEASE}
docker tag kfirz/deployster-k8s-horizontalpodautoscaler:${RELEASE_AND_SHA} kfirz/deployster-k8s-horizontalpodautoscaler:${RELEASE}
docker tag kfirz/deployster-k8s-ingress:${RELEASE_AND_SHA} kfirz/deployster-k8s-ingress:${RELEASE}
docker tag kfirz/deployster-k8s-job:${RELEASE_AND_SHA} kfirz/deployster-k8s-job:${RELEASE}
docker tag kfirz/deployster-k8s-namespace:${RELEASE_AND_SHA} kfirz/deployster-k8s-namespace:${RELEASE}
docker tag kfirz/deployster-k8s-networkpolicy:${RELEASE_AND_SHA} kfirz/deployster-k8s-networkpolicy:${RELEASE}
docker tag kfirz/deployster-k8s-node:${RELEASE_AND_SHA} kfirz/deployster-k8s-node:${RELEASE}
docker tag kfirz/deployster-k8s-persistentvolume:${RELEASE_AND_SHA} kfirz/deployster-k8s-persistentvolume:${RELEASE}
docker tag kfirz/deployster-k8s-persistentvolumeclaim:${RELEASE_AND_SHA} kfirz/deployster-k8s-persistentvolumeclaim:${RELEASE}
docker tag kfirz/deployster-k8s-pod:${RELEASE_AND_SHA} kfirz/deployster-k8s-pod:${RELEASE}
docker tag kfirz/deployster-k8s-replicaset:${RELEASE_AND_SHA} kfirz/deployster-k8s-replicaset:${RELEASE}
docker tag kfirz/deployster-k8s-replicationcontroller:${RELEASE_AND_SHA} kfirz/deployster-k8s-replicationcontroller:${RELEASE}
docker tag kfirz/deployster-k8s-role:${RELEASE_AND_SHA} kfirz/deployster-k8s-role:${RELEASE}
docker tag kfirz/deployster-k8s-rolebinding:${RELEASE_AND_SHA} kfirz/deployster-k8s-rolebinding:${RELEASE}
docker tag kfirz/deployster-k8s-secret:${RELEASE_AND_SHA} kfirz/deployster-k8s-secret:${RELEASE}
docker tag kfirz/deployster-k8s-service:${RELEASE_AND_SHA} kfirz/deployster-k8s-service:${RELEASE}
docker tag kfirz/deployster-k8s-serviceaccount:${RELEASE_AND_SHA} kfirz/deployster-k8s-serviceaccount:${RELEASE}
docker tag kfirz/deployster-k8s-statefulset:${RELEASE_AND_SHA} kfirz/deployster-k8s-statefulset:${RELEASE}
docker tag kfirz/deployster-k8s-storageclass:${RELEASE_AND_SHA} kfirz/deployster-k8s-storageclass:${RELEASE}
docker tag kfirz/deployster:${RELEASE_AND_SHA} kfirz/deployster:${RELEASE}

echo "--- Pushing images"
docker push kfirz/deployster-dresource:${RELEASE}
docker push kfirz/deployster-gcp:${RELEASE}
docker push kfirz/deployster-gcp-cloud-sql:${RELEASE}
docker push kfirz/deployster-gcp-compute-ip-address:${RELEASE}
docker push kfirz/deployster-gcp-gke-cluster:${RELEASE}
docker push kfirz/deployster-gcp-iam-policy:${RELEASE}
docker push kfirz/deployster-gcp-iam-service-account:${RELEASE}
docker push kfirz/deployster-gcp-project:${RELEASE}
docker push kfirz/deployster-k8s:${RELEASE}
docker push kfirz/deployster-k8s-clusterrole:${RELEASE}
docker push kfirz/deployster-k8s-clusterrolebinding:${RELEASE}
docker push kfirz/deployster-k8s-configmap:${RELEASE}
docker push kfirz/deployster-k8s-cronjob:${RELEASE}
docker push kfirz/deployster-k8s-daemonset:${RELEASE}
docker push kfirz/deployster-k8s-deployment:${RELEASE}
docker push kfirz/deployster-k8s-horizontalpodautoscaler:${RELEASE}
docker push kfirz/deployster-k8s-ingress:${RELEASE}
docker push kfirz/deployster-k8s-job:${RELEASE}
docker push kfirz/deployster-k8s-namespace:${RELEASE}
docker push kfirz/deployster-k8s-networkpolicy:${RELEASE}
docker push kfirz/deployster-k8s-node:${RELEASE}
docker push kfirz/deployster-k8s-persistentvolume:${RELEASE}
docker push kfirz/deployster-k8s-persistentvolumeclaim:${RELEASE}
docker push kfirz/deployster-k8s-pod:${RELEASE}
docker push kfirz/deployster-k8s-replicaset:${RELEASE}
docker push kfirz/deployster-k8s-replicationcontroller:${RELEASE}
docker push kfirz/deployster-k8s-role:${RELEASE}
docker push kfirz/deployster-k8s-rolebinding:${RELEASE}
docker push kfirz/deployster-k8s-secret:${RELEASE}
docker push kfirz/deployster-k8s-service:${RELEASE}
docker push kfirz/deployster-k8s-serviceaccount:${RELEASE}
docker push kfirz/deployster-k8s-statefulset:${RELEASE}
docker push kfirz/deployster-k8s-storageclass:${RELEASE}
docker push kfirz/deployster:${RELEASE}

exit 0
