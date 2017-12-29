#!/usr/bin/env bash

# setup
[[ -z "${REPOSITORY}" ]] && echo "REPOSITORY environment variable not set" >&2 && exit 1
[[ -z "${TAG}" ]] && echo "TAG environment variable not set" >&2 && exit 1
set -e

echo "--- Updating FROM directives in Dockerfile(s)"
for dockerfile in $(ls -X ./resources/Dockerfile.*); do
    echo "Updating FROM directive in '${dockerfile}'"
    sed "s/^FROM \(eu.gcr.io\/kfirs-gcr\/deployster-[^:]\+\):.\+$/FROM \1:${TAG}/g" ${dockerfile} > ${dockerfile}.local
done

echo "--- Building 'dresource' Docker image"
docker build -t ${REPOSITORY}/deployster-dresource:${TAG} -f ./resources/Dockerfile.dresource.local ./resources
echo "--- Building 'gcp' Docker image"
docker build -t ${REPOSITORY}/deployster-gcp:${TAG} -f ./resources/Dockerfile.gcp.local ./resources
echo "--- Building 'gcp-cloud-sql' Docker image"
docker build -t ${REPOSITORY}/deployster-gcp-cloud-sql:${TAG} -f ./resources/Dockerfile.gcp_cloud_sql.local ./resources
echo "--- Building 'gcp-compute-ip-address' Docker image"
docker build -t ${REPOSITORY}/deployster-gcp-compute-ip-address:${TAG} -f ./resources/Dockerfile.gcp_compute_ip_address.local ./resources
echo "--- Building 'gcp-gke-cluster' Docker image"
docker build -t ${REPOSITORY}/deployster-gcp-gke-cluster:${TAG} -f ./resources/Dockerfile.gcp_gke_cluster.local ./resources
echo "--- Building 'gcp-iam-policy' Docker image"
docker build -t ${REPOSITORY}/deployster-gcp-iam-policy:${TAG} -f ./resources/Dockerfile.gcp_iam_service_account.local ./resources
echo "--- Building 'gcp-iam-service-account' Docker image"
docker build -t ${REPOSITORY}/deployster-gcp-iam-service-account:${TAG} -f ./resources/Dockerfile.gcp_iam_policy.local ./resources
echo "--- Building 'gcp-project' Docker image"
docker build -t ${REPOSITORY}/deployster-gcp-project:${TAG} -f ./resources/Dockerfile.gcp_project.local ./resources
echo "--- Building 'k8s' Docker image"
docker build -t ${REPOSITORY}/deployster-k8s:${TAG} -f ./resources/Dockerfile.k8s.local ./resources

echo "--- Building 'deployster' image"
docker build --build-arg "VERSION=${TAG}" --tag ${REPOSITORY}/deployster:${TAG} -f ./Dockerfile .

echo "--- Tagging Kubernetes resource image aliases"
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-clusterrole:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-clusterrolebinding:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-configmap:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-cronjob:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-daemonset:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-deployment:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-horizontalpodautoscaler:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-ingress:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-job:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-namespace:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-networkpolicy:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-node:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-persistentvolume:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-persistentvolumeclaim:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-pod:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-replicaset:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-replicationcontroller:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-role:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-rolebinding:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-secret:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-service:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-serviceaccount:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-statefulset:${TAG}
docker tag ${REPOSITORY}/deployster-k8s:${TAG} ${REPOSITORY}/deployster-k8s-storageclass:${TAG}

# create k8s docker image aliases
if [[ "${PUSH}" == "1" ]]; then
    echo "--- Pushing resource images to repository"
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

    echo "--- Pushing main Deployster image to repository"
    docker push ${REPOSITORY}/deployster:${TAG}
fi

exit 0
