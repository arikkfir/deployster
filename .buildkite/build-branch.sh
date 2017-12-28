#!/usr/bin/env bash

# fail on first error
set -e

# process Dockerfile files and replace ":local" in "FROM" clauses with actual tag
echo "+++ Updating FROM directives in Dockerfile(s)"
for dockerfile in $(ls -X ./resources/Dockerfile.*); do
    echo "Updating FROM directive in '${dockerfile}'"
    sed -i "s/^FROM \(eu.gcr.io\/kfirs-gcr\/deployster-[^:]\+\):.\+$/FROM \1:${BUILDKITE_COMMIT}/g" ${dockerfile}
done

# build resource images
echo "+++ Building resource images"
docker build --tag eu.gcr.io/kfirs-gcr/deployster-dresource:${BUILDKITE_COMMIT} -f ./resources/Dockerfile.dresource ./resources
docker build --tag eu.gcr.io/kfirs-gcr/deployster-gcp:${BUILDKITE_COMMIT} -f ./resources/Dockerfile.gcp ./resources
docker build --tag eu.gcr.io/kfirs-gcr/deployster-gcp-cloud-sql:${BUILDKITE_COMMIT} -f ./resources/Dockerfile.gcp_cloud_sql ./resources
docker build --tag eu.gcr.io/kfirs-gcr/deployster-gcp-compute-ip-address:${BUILDKITE_COMMIT} -f ./resources/Dockerfile.gcp_compute_ip_address ./resources
docker build --tag eu.gcr.io/kfirs-gcr/deployster-gcp-gke-cluster:${BUILDKITE_COMMIT} -f ./resources/Dockerfile.gcp_gke_cluster ./resources
docker build --tag eu.gcr.io/kfirs-gcr/deployster-gcp-iam-policy:${BUILDKITE_COMMIT} -f ./resources/Dockerfile.gcp_iam_service_account ./resources
docker build --tag eu.gcr.io/kfirs-gcr/deployster-gcp-iam-service-account:${BUILDKITE_COMMIT} -f ./resources/Dockerfile.gcp_iam_policy ./resources
docker build --tag eu.gcr.io/kfirs-gcr/deployster-gcp-project:${BUILDKITE_COMMIT} -f ./resources/Dockerfile.gcp_project ./resources
docker build --tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} -f ./resources/Dockerfile.k8s ./resources
docker build --build-arg "VERSION=${BUILDKITE_COMMIT}" --tag eu.gcr.io/kfirs-gcr/deployster:${BUILDKITE_COMMIT} -f ./Dockerfile .
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-clusterrole:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-clusterrolebinding:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-configmap:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-cronjob:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-daemonset:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-deployment:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-horizontalpodautoscaler:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-ingress:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-job:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-namespace:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-networkpolicy:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-node:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-persistentvolume:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-persistentvolumeclaim:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-pod:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-replicaset:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-replicationcontroller:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-role:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-rolebinding:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-secret:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-service:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-serviceaccount:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-statefulset:${BUILDKITE_COMMIT}
docker tag eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT} eu.gcr.io/kfirs-gcr/deployster-k8s-storageclass:${BUILDKITE_COMMIT}

# create k8s docker image aliases
echo "+++ Pushing resource images to registry"
docker push eu.gcr.io/kfirs-gcr/deployster-dresource:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-gcp:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-gcp-cloud-sql:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-gcp-compute-ip-address:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-gcp-gke-cluster:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-gcp-iam-policy:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-gcp-iam-service-account:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-gcp-project:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-clusterrole:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-clusterrolebinding:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-configmap:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-cronjob:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-daemonset:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-deployment:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-horizontalpodautoscaler:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-ingress:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-job:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-namespace:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-networkpolicy:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-node:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-persistentvolume:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-persistentvolumeclaim:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-pod:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-replicaset:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-replicationcontroller:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-role:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-rolebinding:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-secret:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-service:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-serviceaccount:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-statefulset:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster-k8s-storageclass:${BUILDKITE_COMMIT}
docker push eu.gcr.io/kfirs-gcr/deployster:${BUILDKITE_COMMIT}

exit 0
