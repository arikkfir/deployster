#!/usr/bin/env bash

# fail on first error
set -e

# pull SHA images
echo "+++ Pulling commit SHA images"
docker pull quay.io/kfirs/deployster-dresource:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-gcp:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-gcp-cloud-sql:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-gcp-compute-ip-address:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-gcp-gke-cluster:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-gcp-iam-policy:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-gcp-iam-service-account:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-gcp-project:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-clusterrole:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-clusterrolebinding:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-configmap:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-cronjob:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-daemonset:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-deployment:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-horizontalpodautoscaler:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-ingress:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-job:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-namespace:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-networkpolicy:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-node:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-persistentvolume:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-persistentvolumeclaim:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-pod:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-replicaset:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-replicationcontroller:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-role:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-rolebinding:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-secret:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-service:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-serviceaccount:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-statefulset:${BUILDKITE_COMMIT}
docker pull quay.io/kfirs/deployster-k8s-storageclass:${BUILDKITE_COMMIT}

# build versioned images
echo "+++ Build versioned images"
docker tag quay.io/kfirs/deployster-dresource:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-dresource:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-gcp:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-gcp:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-gcp-cloud-sql:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-gcp-cloud-sql:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-gcp-compute-ip-address:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-gcp-compute-ip-address:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-gcp-gke-cluster:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-gcp-gke-cluster:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-gcp-iam-policy:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-gcp-iam-policy:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-gcp-iam-service-account:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-gcp-iam-service-account:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-gcp-project:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-gcp-project:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-clusterrole:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-clusterrole:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-clusterrolebinding:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-clusterrolebinding:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-configmap:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-configmap:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-cronjob:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-cronjob:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-daemonset:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-daemonset:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-deployment:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-deployment:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-horizontalpodautoscaler:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-horizontalpodautoscaler:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-ingress:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-ingress:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-job:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-job:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-namespace:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-namespace:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-networkpolicy:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-networkpolicy:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-node:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-node:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-persistentvolume:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-persistentvolume:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-persistentvolumeclaim:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-persistentvolumeclaim:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-pod:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-pod:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-replicaset:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-replicaset:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-replicationcontroller:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-replicationcontroller:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-role:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-role:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-rolebinding:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-rolebinding:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-secret:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-secret:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-service:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-service:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-serviceaccount:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-serviceaccount:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-statefulset:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-statefulset:${BUILDKITE_TAG}
docker tag quay.io/kfirs/deployster-k8s-storageclass:${BUILDKITE_COMMIT} quay.io/kfirs/deployster-k8s-storageclass:${BUILDKITE_TAG}
docker build -q --build-arg "VERSION=${BUILDKITE_TAG}" --tag quay.io/kfirs/deployster:${BUILDKITE_TAG} -f ./Dockerfile .

# build "latest" images
echo "+++ Build \"latest\" images"
docker tag quay.io/kfirs/deployster-dresource:${BUILDKITE_TAG} quay.io/kfirs/deployster-dresource:latest
docker tag quay.io/kfirs/deployster-gcp:${BUILDKITE_TAG} quay.io/kfirs/deployster-gcp:latest
docker tag quay.io/kfirs/deployster-gcp-cloud-sql:${BUILDKITE_TAG} quay.io/kfirs/deployster-gcp-cloud-sql:latest
docker tag quay.io/kfirs/deployster-gcp-compute-ip-address:${BUILDKITE_TAG} quay.io/kfirs/deployster-gcp-compute-ip-address:latest
docker tag quay.io/kfirs/deployster-gcp-gke-cluster:${BUILDKITE_TAG} quay.io/kfirs/deployster-gcp-gke-cluster:latest
docker tag quay.io/kfirs/deployster-gcp-iam-policy:${BUILDKITE_TAG} quay.io/kfirs/deployster-gcp-iam-policy:latest
docker tag quay.io/kfirs/deployster-gcp-iam-service-account:${BUILDKITE_TAG} quay.io/kfirs/deployster-gcp-iam-service-account:latest
docker tag quay.io/kfirs/deployster-gcp-project:${BUILDKITE_TAG} quay.io/kfirs/deployster-gcp-project:latest
docker tag quay.io/kfirs/deployster-k8s:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s:latest
docker tag quay.io/kfirs/deployster-k8s-clusterrole:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-clusterrole:latest
docker tag quay.io/kfirs/deployster-k8s-clusterrolebinding:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-clusterrolebinding:latest
docker tag quay.io/kfirs/deployster-k8s-configmap:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-configmap:latest
docker tag quay.io/kfirs/deployster-k8s-cronjob:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-cronjob:latest
docker tag quay.io/kfirs/deployster-k8s-daemonset:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-daemonset:latest
docker tag quay.io/kfirs/deployster-k8s-deployment:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-deployment:latest
docker tag quay.io/kfirs/deployster-k8s-horizontalpodautoscaler:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-horizontalpodautoscaler:latest
docker tag quay.io/kfirs/deployster-k8s-ingress:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-ingress:latest
docker tag quay.io/kfirs/deployster-k8s-job:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-job:latest
docker tag quay.io/kfirs/deployster-k8s-namespace:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-namespace:latest
docker tag quay.io/kfirs/deployster-k8s-networkpolicy:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-networkpolicy:latest
docker tag quay.io/kfirs/deployster-k8s-node:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-node:latest
docker tag quay.io/kfirs/deployster-k8s-persistentvolume:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-persistentvolume:latest
docker tag quay.io/kfirs/deployster-k8s-persistentvolumeclaim:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-persistentvolumeclaim:latest
docker tag quay.io/kfirs/deployster-k8s-pod:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-pod:latest
docker tag quay.io/kfirs/deployster-k8s-replicaset:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-replicaset:latest
docker tag quay.io/kfirs/deployster-k8s-replicationcontroller:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-replicationcontroller:latest
docker tag quay.io/kfirs/deployster-k8s-role:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-role:latest
docker tag quay.io/kfirs/deployster-k8s-rolebinding:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-rolebinding:latest
docker tag quay.io/kfirs/deployster-k8s-secret:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-secret:latest
docker tag quay.io/kfirs/deployster-k8s-service:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-service:latest
docker tag quay.io/kfirs/deployster-k8s-serviceaccount:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-serviceaccount:latest
docker tag quay.io/kfirs/deployster-k8s-statefulset:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-statefulset:latest
docker tag quay.io/kfirs/deployster-k8s-storageclass:${BUILDKITE_TAG} quay.io/kfirs/deployster-k8s-storageclass:latest
docker tag quay.io/kfirs/deployster:${BUILDKITE_TAG} quay.io/kfirs/deployster:latest

# push versioned images
echo "+++ Push versioned images"
docker push quay.io/kfirs/deployster-dresource:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-gcp:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-gcp-cloud-sql:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-gcp-compute-ip-address:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-gcp-gke-cluster:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-gcp-iam-policy:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-gcp-iam-service-account:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-gcp-project:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-clusterrole:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-clusterrolebinding:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-configmap:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-cronjob:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-daemonset:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-deployment:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-horizontalpodautoscaler:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-ingress:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-job:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-namespace:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-networkpolicy:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-node:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-persistentvolume:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-persistentvolumeclaim:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-pod:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-replicaset:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-replicationcontroller:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-role:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-rolebinding:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-secret:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-service:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-serviceaccount:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-statefulset:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster-k8s-storageclass:${BUILDKITE_TAG}
docker push quay.io/kfirs/deployster:${BUILDKITE_TAG}

# push "latest" images
echo "+++ Push \"latest\" images"
docker push quay.io/kfirs/deployster-dresource:latest
docker push quay.io/kfirs/deployster-gcp:latest
docker push quay.io/kfirs/deployster-gcp-cloud-sql:latest
docker push quay.io/kfirs/deployster-gcp-compute-ip-address:latest
docker push quay.io/kfirs/deployster-gcp-gke-cluster:latest
docker push quay.io/kfirs/deployster-gcp-iam-policy:latest
docker push quay.io/kfirs/deployster-gcp-iam-service-account:latest
docker push quay.io/kfirs/deployster-gcp-project:latest
docker push quay.io/kfirs/deployster-k8s:latest
docker push quay.io/kfirs/deployster-k8s-clusterrole:latest
docker push quay.io/kfirs/deployster-k8s-clusterrolebinding:latest
docker push quay.io/kfirs/deployster-k8s-configmap:latest
docker push quay.io/kfirs/deployster-k8s-cronjob:latest
docker push quay.io/kfirs/deployster-k8s-daemonset:latest
docker push quay.io/kfirs/deployster-k8s-deployment:latest
docker push quay.io/kfirs/deployster-k8s-horizontalpodautoscaler:latest
docker push quay.io/kfirs/deployster-k8s-ingress:latest
docker push quay.io/kfirs/deployster-k8s-job:latest
docker push quay.io/kfirs/deployster-k8s-namespace:latest
docker push quay.io/kfirs/deployster-k8s-networkpolicy:latest
docker push quay.io/kfirs/deployster-k8s-node:latest
docker push quay.io/kfirs/deployster-k8s-persistentvolume:latest
docker push quay.io/kfirs/deployster-k8s-persistentvolumeclaim:latest
docker push quay.io/kfirs/deployster-k8s-pod:latest
docker push quay.io/kfirs/deployster-k8s-replicaset:latest
docker push quay.io/kfirs/deployster-k8s-replicationcontroller:latest
docker push quay.io/kfirs/deployster-k8s-role:latest
docker push quay.io/kfirs/deployster-k8s-rolebinding:latest
docker push quay.io/kfirs/deployster-k8s-secret:latest
docker push quay.io/kfirs/deployster-k8s-service:latest
docker push quay.io/kfirs/deployster-k8s-serviceaccount:latest
docker push quay.io/kfirs/deployster-k8s-statefulset:latest
docker push quay.io/kfirs/deployster-k8s-storageclass:latest
docker push quay.io/kfirs/deployster:latest

exit 0
