#!/usr/bin/env bash

# setup
[[ -z "${REPOSITORY}" ]] && echo "REPOSITORY environment variable not set" >&2 && exit 1
[[ -z "${COMMIT_SHA}" ]] && echo "COMMIT_SHA environment variable not set" >&2 && exit 1
[[ -z "${TAG}" ]] && echo "TAG environment variable not set" >&2 && exit 1
set -e

# pull SHA images
echo "--- Pulling commit SHA images"
docker pull ${REPOSITORY}/deployster-dresource:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-gcp:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-gcp-cloud-sql:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-gcp-compute-ip-address:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-gcp-gke-cluster:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-gcp-iam-policy:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-gcp-iam-service-account:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-gcp-project:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-clusterrole:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-clusterrolebinding:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-configmap:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-cronjob:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-daemonset:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-deployment:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-horizontalpodautoscaler:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-ingress:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-job:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-namespace:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-networkpolicy:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-node:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-persistentvolume:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-persistentvolumeclaim:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-pod:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-replicaset:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-replicationcontroller:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-role:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-rolebinding:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-secret:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-service:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-serviceaccount:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-statefulset:${COMMIT_SHA}
docker pull ${REPOSITORY}/deployster-k8s-storageclass:${COMMIT_SHA}

# build versioned images
echo "--- Build versioned images"
docker tag ${REPOSITORY}/deployster-dresource:${COMMIT_SHA} ${REPOSITORY}/deployster-dresource:${TAG}
docker tag ${REPOSITORY}/deployster-gcp:${COMMIT_SHA} ${REPOSITORY}/deployster-gcp:${TAG}
docker tag ${REPOSITORY}/deployster-gcp-cloud-sql:${COMMIT_SHA} ${REPOSITORY}/deployster-gcp-cloud-sql:${TAG}
docker tag ${REPOSITORY}/deployster-gcp-compute-ip-address:${COMMIT_SHA} ${REPOSITORY}/deployster-gcp-compute-ip-address:${TAG}
docker tag ${REPOSITORY}/deployster-gcp-gke-cluster:${COMMIT_SHA} ${REPOSITORY}/deployster-gcp-gke-cluster:${TAG}
docker tag ${REPOSITORY}/deployster-gcp-iam-policy:${COMMIT_SHA} ${REPOSITORY}/deployster-gcp-iam-policy:${TAG}
docker tag ${REPOSITORY}/deployster-gcp-iam-service-account:${COMMIT_SHA} ${REPOSITORY}/deployster-gcp-iam-service-account:${TAG}
docker tag ${REPOSITORY}/deployster-gcp-project:${COMMIT_SHA} ${REPOSITORY}/deployster-gcp-project:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-clusterrole:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-clusterrole:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-clusterrolebinding:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-clusterrolebinding:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-configmap:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-configmap:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-cronjob:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-cronjob:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-daemonset:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-daemonset:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-deployment:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-deployment:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-horizontalpodautoscaler:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-horizontalpodautoscaler:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-ingress:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-ingress:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-job:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-job:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-namespace:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-namespace:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-networkpolicy:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-networkpolicy:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-node:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-node:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-persistentvolume:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-persistentvolume:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-persistentvolumeclaim:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-persistentvolumeclaim:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-pod:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-pod:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-replicaset:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-replicaset:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-replicationcontroller:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-replicationcontroller:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-role:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-role:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-rolebinding:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-rolebinding:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-secret:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-secret:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-service:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-service:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-serviceaccount:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-serviceaccount:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-statefulset:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-statefulset:${TAG}
docker tag ${REPOSITORY}/deployster-k8s-storageclass:${COMMIT_SHA} ${REPOSITORY}/deployster-k8s-storageclass:${TAG}
docker build -q --build-arg "VERSION=${TAG}" --tag ${REPOSITORY}/deployster:${TAG} -f ./Dockerfile .

# build "latest" images
echo "--- Build \"latest\" images"
docker tag ${REPOSITORY}/deployster-dresource:${TAG} ${REPOSITORY}/deployster-dresource:latest
docker tag ${REPOSITORY}/deployster-gcp:${TAG} ${REPOSITORY}/deployster-gcp:latest
docker tag ${REPOSITORY}/deployster-gcp-cloud-sql:${TAG} ${REPOSITORY}/deployster-gcp-cloud-sql:latest
docker tag ${REPOSITORY}/deployster-gcp-compute-ip-address:${TAG} ${REPOSITORY}/deployster-gcp-compute-ip-address:latest
docker tag ${REPOSITORY}/deployster-gcp-gke-cluster:${TAG} ${REPOSITORY}/deployster-gcp-gke-cluster:latest
docker tag ${REPOSITORY}/deployster-gcp-iam-policy:${TAG} ${REPOSITORY}/deployster-gcp-iam-policy:latest
docker tag ${REPOSITORY}/deployster-gcp-iam-service-account:${TAG} ${REPOSITORY}/deployster-gcp-iam-service-account:latest
docker tag ${REPOSITORY}/deployster-gcp-project:${TAG} ${REPOSITORY}/deployster-gcp-project:latest
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s:latest
docker tag ${REPOSITORY}/deployster-k8s-clusterrole:${TAG} ${REPOSITORY}/deployster-k8s-clusterrole:latest
docker tag ${REPOSITORY}/deployster-k8s-clusterrolebinding:${TAG} ${REPOSITORY}/deployster-k8s-clusterrolebinding:latest
docker tag ${REPOSITORY}/deployster-k8s-configmap:${TAG} ${REPOSITORY}/deployster-k8s-configmap:latest
docker tag ${REPOSITORY}/deployster-k8s-cronjob:${TAG} ${REPOSITORY}/deployster-k8s-cronjob:latest
docker tag ${REPOSITORY}/deployster-k8s-daemonset:${TAG} ${REPOSITORY}/deployster-k8s-daemonset:latest
docker tag ${REPOSITORY}/deployster-k8s-deployment:${TAG} ${REPOSITORY}/deployster-k8s-deployment:latest
docker tag ${REPOSITORY}/deployster-k8s-horizontalpodautoscaler:${TAG} ${REPOSITORY}/deployster-k8s-horizontalpodautoscaler:latest
docker tag ${REPOSITORY}/deployster-k8s-ingress:${TAG} ${REPOSITORY}/deployster-k8s-ingress:latest
docker tag ${REPOSITORY}/deployster-k8s-job:${TAG} ${REPOSITORY}/deployster-k8s-job:latest
docker tag ${REPOSITORY}/deployster-k8s-namespace:${TAG} ${REPOSITORY}/deployster-k8s-namespace:latest
docker tag ${REPOSITORY}/deployster-k8s-networkpolicy:${TAG} ${REPOSITORY}/deployster-k8s-networkpolicy:latest
docker tag ${REPOSITORY}/deployster-k8s-node:${TAG} ${REPOSITORY}/deployster-k8s-node:latest
docker tag ${REPOSITORY}/deployster-k8s-persistentvolume:${TAG} ${REPOSITORY}/deployster-k8s-persistentvolume:latest
docker tag ${REPOSITORY}/deployster-k8s-persistentvolumeclaim:${TAG} ${REPOSITORY}/deployster-k8s-persistentvolumeclaim:latest
docker tag ${REPOSITORY}/deployster-k8s-pod:${TAG} ${REPOSITORY}/deployster-k8s-pod:latest
docker tag ${REPOSITORY}/deployster-k8s-replicaset:${TAG} ${REPOSITORY}/deployster-k8s-replicaset:latest
docker tag ${REPOSITORY}/deployster-k8s-replicationcontroller:${TAG} ${REPOSITORY}/deployster-k8s-replicationcontroller:latest
docker tag ${REPOSITORY}/deployster-k8s-role:${TAG} ${REPOSITORY}/deployster-k8s-role:latest
docker tag ${REPOSITORY}/deployster-k8s-rolebinding:${TAG} ${REPOSITORY}/deployster-k8s-rolebinding:latest
docker tag ${REPOSITORY}/deployster-k8s-secret:${TAG} ${REPOSITORY}/deployster-k8s-secret:latest
docker tag ${REPOSITORY}/deployster-k8s-service:${TAG} ${REPOSITORY}/deployster-k8s-service:latest
docker tag ${REPOSITORY}/deployster-k8s-serviceaccount:${TAG} ${REPOSITORY}/deployster-k8s-serviceaccount:latest
docker tag ${REPOSITORY}/deployster-k8s-statefulset:${TAG} ${REPOSITORY}/deployster-k8s-statefulset:latest
docker tag ${REPOSITORY}/deployster-k8s-storageclass:${TAG} ${REPOSITORY}/deployster-k8s-storageclass:latest
docker tag ${REPOSITORY}/deployster:${TAG} ${REPOSITORY}/deployster:latest

# push versioned images
echo "--- Push versioned images"
docker push ${REPOSITORY}/deployster-dresource:${TAG}
docker push ${REPOSITORY}/deployster-gcp:${TAG}
docker push ${REPOSITORY}/deployster-gcp-cloud-sql:${TAG}
docker push ${REPOSITORY}/deployster-gcp-compute-ip-address:${TAG}
docker push ${REPOSITORY}/deployster-gcp-gke-cluster:${TAG}
docker push ${REPOSITORY}/deployster-gcp-iam-policy:${TAG}
docker push ${REPOSITORY}/deployster-gcp-iam-service-account:${TAG}
docker push ${REPOSITORY}/deployster-gcp-project:${TAG}
docker push ${REPOSITORY}/deployster-k8s:${TAG}
docker push ${REPOSITORY}/deployster-k8s-clusterrole:${TAG}
docker push ${REPOSITORY}/deployster-k8s-clusterrolebinding:${TAG}
docker push ${REPOSITORY}/deployster-k8s-configmap:${TAG}
docker push ${REPOSITORY}/deployster-k8s-cronjob:${TAG}
docker push ${REPOSITORY}/deployster-k8s-daemonset:${TAG}
docker push ${REPOSITORY}/deployster-k8s-deployment:${TAG}
docker push ${REPOSITORY}/deployster-k8s-horizontalpodautoscaler:${TAG}
docker push ${REPOSITORY}/deployster-k8s-ingress:${TAG}
docker push ${REPOSITORY}/deployster-k8s-job:${TAG}
docker push ${REPOSITORY}/deployster-k8s-namespace:${TAG}
docker push ${REPOSITORY}/deployster-k8s-networkpolicy:${TAG}
docker push ${REPOSITORY}/deployster-k8s-node:${TAG}
docker push ${REPOSITORY}/deployster-k8s-persistentvolume:${TAG}
docker push ${REPOSITORY}/deployster-k8s-persistentvolumeclaim:${TAG}
docker push ${REPOSITORY}/deployster-k8s-pod:${TAG}
docker push ${REPOSITORY}/deployster-k8s-replicaset:${TAG}
docker push ${REPOSITORY}/deployster-k8s-replicationcontroller:${TAG}
docker push ${REPOSITORY}/deployster-k8s-role:${TAG}
docker push ${REPOSITORY}/deployster-k8s-rolebinding:${TAG}
docker push ${REPOSITORY}/deployster-k8s-secret:${TAG}
docker push ${REPOSITORY}/deployster-k8s-service:${TAG}
docker push ${REPOSITORY}/deployster-k8s-serviceaccount:${TAG}
docker push ${REPOSITORY}/deployster-k8s-statefulset:${TAG}
docker push ${REPOSITORY}/deployster-k8s-storageclass:${TAG}
docker push ${REPOSITORY}/deployster:${TAG}

# push "latest" images
echo "--- Push \"latest\" images"
docker push ${REPOSITORY}/deployster-dresource:latest
docker push ${REPOSITORY}/deployster-gcp:latest
docker push ${REPOSITORY}/deployster-gcp-cloud-sql:latest
docker push ${REPOSITORY}/deployster-gcp-compute-ip-address:latest
docker push ${REPOSITORY}/deployster-gcp-gke-cluster:latest
docker push ${REPOSITORY}/deployster-gcp-iam-policy:latest
docker push ${REPOSITORY}/deployster-gcp-iam-service-account:latest
docker push ${REPOSITORY}/deployster-gcp-project:latest
docker push ${REPOSITORY}/deployster-k8s:latest
docker push ${REPOSITORY}/deployster-k8s-clusterrole:latest
docker push ${REPOSITORY}/deployster-k8s-clusterrolebinding:latest
docker push ${REPOSITORY}/deployster-k8s-configmap:latest
docker push ${REPOSITORY}/deployster-k8s-cronjob:latest
docker push ${REPOSITORY}/deployster-k8s-daemonset:latest
docker push ${REPOSITORY}/deployster-k8s-deployment:latest
docker push ${REPOSITORY}/deployster-k8s-horizontalpodautoscaler:latest
docker push ${REPOSITORY}/deployster-k8s-ingress:latest
docker push ${REPOSITORY}/deployster-k8s-job:latest
docker push ${REPOSITORY}/deployster-k8s-namespace:latest
docker push ${REPOSITORY}/deployster-k8s-networkpolicy:latest
docker push ${REPOSITORY}/deployster-k8s-node:latest
docker push ${REPOSITORY}/deployster-k8s-persistentvolume:latest
docker push ${REPOSITORY}/deployster-k8s-persistentvolumeclaim:latest
docker push ${REPOSITORY}/deployster-k8s-pod:latest
docker push ${REPOSITORY}/deployster-k8s-replicaset:latest
docker push ${REPOSITORY}/deployster-k8s-replicationcontroller:latest
docker push ${REPOSITORY}/deployster-k8s-role:latest
docker push ${REPOSITORY}/deployster-k8s-rolebinding:latest
docker push ${REPOSITORY}/deployster-k8s-secret:latest
docker push ${REPOSITORY}/deployster-k8s-service:latest
docker push ${REPOSITORY}/deployster-k8s-serviceaccount:latest
docker push ${REPOSITORY}/deployster-k8s-statefulset:latest
docker push ${REPOSITORY}/deployster-k8s-storageclass:latest
docker push ${REPOSITORY}/deployster:latest

exit 0
