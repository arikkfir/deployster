#!/usr/bin/env bash

set -euo pipefail

echo "--- Login to Docker Hub"
cat ${DOCKERHUB_PASSWORD_FILE} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin

echo "--- Re-tagging images tagged as '${RELEASE}' with 'latest'"
docker tag kfirz/deployster-dresource:${RELEASE} kfirz/deployster-dresource:latest
docker tag kfirz/deployster-gcp:${RELEASE} kfirz/deployster-gcp:latest
docker tag kfirz/deployster-gcp-cloud-sql:${RELEASE} kfirz/deployster-gcp-cloud-sql:latest
docker tag kfirz/deployster-gcp-compute-ip-address:${RELEASE} kfirz/deployster-gcp-compute-ip-address:latest
docker tag kfirz/deployster-gcp-gke-cluster:${RELEASE} kfirz/deployster-gcp-gke-cluster:latest
docker tag kfirz/deployster-gcp-iam-policy:${RELEASE} kfirz/deployster-gcp-iam-policy:latest
docker tag kfirz/deployster-gcp-iam-service-account:${RELEASE} kfirz/deployster-gcp-iam-service-account:latest
docker tag kfirz/deployster-gcp-project:${RELEASE} kfirz/deployster-gcp-project:latest
docker tag kfirz/deployster-k8s:${RELEASE} kfirz/deployster-k8s:latest
docker tag kfirz/deployster-k8s-clusterrole:${RELEASE} kfirz/deployster-k8s-clusterrole:latest
docker tag kfirz/deployster-k8s-clusterrolebinding:${RELEASE} kfirz/deployster-k8s-clusterrolebinding:latest
docker tag kfirz/deployster-k8s-configmap:${RELEASE} kfirz/deployster-k8s-configmap:latest
docker tag kfirz/deployster-k8s-cronjob:${RELEASE} kfirz/deployster-k8s-cronjob:latest
docker tag kfirz/deployster-k8s-daemonset:${RELEASE} kfirz/deployster-k8s-daemonset:latest
docker tag kfirz/deployster-k8s-deployment:${RELEASE} kfirz/deployster-k8s-deployment:latest
docker tag kfirz/deployster-k8s-horizontalpodautoscaler:${RELEASE} kfirz/deployster-k8s-horizontalpodautoscaler:latest
docker tag kfirz/deployster-k8s-ingress:${RELEASE} kfirz/deployster-k8s-ingress:latest
docker tag kfirz/deployster-k8s-job:${RELEASE} kfirz/deployster-k8s-job:latest
docker tag kfirz/deployster-k8s-namespace:${RELEASE} kfirz/deployster-k8s-namespace:latest
docker tag kfirz/deployster-k8s-networkpolicy:${RELEASE} kfirz/deployster-k8s-networkpolicy:latest
docker tag kfirz/deployster-k8s-node:${RELEASE} kfirz/deployster-k8s-node:latest
docker tag kfirz/deployster-k8s-persistentvolume:${RELEASE} kfirz/deployster-k8s-persistentvolume:latest
docker tag kfirz/deployster-k8s-persistentvolumeclaim:${RELEASE} kfirz/deployster-k8s-persistentvolumeclaim:latest
docker tag kfirz/deployster-k8s-pod:${RELEASE} kfirz/deployster-k8s-pod:latest
docker tag kfirz/deployster-k8s-replicaset:${RELEASE} kfirz/deployster-k8s-replicaset:latest
docker tag kfirz/deployster-k8s-replicationcontroller:${RELEASE} kfirz/deployster-k8s-replicationcontroller:latest
docker tag kfirz/deployster-k8s-role:${RELEASE} kfirz/deployster-k8s-role:latest
docker tag kfirz/deployster-k8s-rolebinding:${RELEASE} kfirz/deployster-k8s-rolebinding:latest
docker tag kfirz/deployster-k8s-secret:${RELEASE} kfirz/deployster-k8s-secret:latest
docker tag kfirz/deployster-k8s-service:${RELEASE} kfirz/deployster-k8s-service:latest
docker tag kfirz/deployster-k8s-serviceaccount:${RELEASE} kfirz/deployster-k8s-serviceaccount:latest
docker tag kfirz/deployster-k8s-statefulset:${RELEASE} kfirz/deployster-k8s-statefulset:latest
docker tag kfirz/deployster-k8s-storageclass:${RELEASE} kfirz/deployster-k8s-storageclass:latest
docker tag kfirz/deployster:${RELEASE} kfirz/deployster:latest

echo "--- Pushing images"
docker push kfirz/deployster-dresource:latest
docker push kfirz/deployster-gcp:latest
docker push kfirz/deployster-gcp-cloud-sql:latest
docker push kfirz/deployster-gcp-compute-ip-address:latest
docker push kfirz/deployster-gcp-gke-cluster:latest
docker push kfirz/deployster-gcp-iam-policy:latest
docker push kfirz/deployster-gcp-iam-service-account:latest
docker push kfirz/deployster-gcp-project:latest
docker push kfirz/deployster-k8s:latest
docker push kfirz/deployster-k8s-clusterrole:latest
docker push kfirz/deployster-k8s-clusterrolebinding:latest
docker push kfirz/deployster-k8s-configmap:latest
docker push kfirz/deployster-k8s-cronjob:latest
docker push kfirz/deployster-k8s-daemonset:latest
docker push kfirz/deployster-k8s-deployment:latest
docker push kfirz/deployster-k8s-horizontalpodautoscaler:latest
docker push kfirz/deployster-k8s-ingress:latest
docker push kfirz/deployster-k8s-job:latest
docker push kfirz/deployster-k8s-namespace:latest
docker push kfirz/deployster-k8s-networkpolicy:latest
docker push kfirz/deployster-k8s-node:latest
docker push kfirz/deployster-k8s-persistentvolume:latest
docker push kfirz/deployster-k8s-persistentvolumeclaim:latest
docker push kfirz/deployster-k8s-pod:latest
docker push kfirz/deployster-k8s-replicaset:latest
docker push kfirz/deployster-k8s-replicationcontroller:latest
docker push kfirz/deployster-k8s-role:latest
docker push kfirz/deployster-k8s-rolebinding:latest
docker push kfirz/deployster-k8s-secret:latest
docker push kfirz/deployster-k8s-service:latest
docker push kfirz/deployster-k8s-serviceaccount:latest
docker push kfirz/deployster-k8s-statefulset:latest
docker push kfirz/deployster-k8s-storageclass:latest
docker push kfirz/deployster:latest

exit 0
