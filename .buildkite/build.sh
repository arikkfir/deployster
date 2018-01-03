#!/usr/bin/env bash

set -euo pipefail

# run tests
source $(pwd)/.buildkite/test.sh

RELEASE_AND_SHA="${RELEASE}-${BUILDKITE_COMMIT}"

echo "--- Login to Docker Hub"
cat ${DOCKERHUB_PASSWORD_FILE} | docker login -u ${DOCKERHUB_USERNAME} --password-stdin

echo "--- Updating FROM directives in Dockerfile(s)"
for dockerfile in $(ls -X ./resources/Dockerfile.*); do
    echo "Updating FROM directive in '${dockerfile}'"
    sed "s/^FROM \(kfirz\/deployster-[^:]\+\):.\+$/FROM \1:${RELEASE_AND_SHA}/g" ${dockerfile} > ${dockerfile}.local
done

echo "--- Building 'dresource' Docker image"
docker build -t kfirz/deployster-dresource:${RELEASE_AND_SHA} -f ./resources/Dockerfile.dresource.local ./resources
echo "--- Building 'gcp' Docker image"
docker build -t kfirz/deployster-gcp:${RELEASE_AND_SHA} -f ./resources/Dockerfile.gcp.local ./resources
echo "--- Building 'gcp-cloud-sql' Docker image"
docker build -t kfirz/deployster-gcp-cloud-sql:${RELEASE_AND_SHA} -f ./resources/Dockerfile.gcp_cloud_sql.local ./resources
echo "--- Building 'gcp-compute-ip-address' Docker image"
docker build -t kfirz/deployster-gcp-compute-ip-address:${RELEASE_AND_SHA} -f ./resources/Dockerfile.gcp_compute_ip_address.local ./resources
echo "--- Building 'gcp-gke-cluster' Docker image"
docker build -t kfirz/deployster-gcp-gke-cluster:${RELEASE_AND_SHA} -f ./resources/Dockerfile.gcp_gke_cluster.local ./resources
echo "--- Building 'gcp-iam-policy' Docker image"
docker build -t kfirz/deployster-gcp-iam-policy:${RELEASE_AND_SHA} -f ./resources/Dockerfile.gcp_iam_service_account.local ./resources
echo "--- Building 'gcp-iam-service-account' Docker image"
docker build -t kfirz/deployster-gcp-iam-service-account:${RELEASE_AND_SHA} -f ./resources/Dockerfile.gcp_iam_policy.local ./resources
echo "--- Building 'gcp-project' Docker image"
docker build -t kfirz/deployster-gcp-project:${RELEASE_AND_SHA} -f ./resources/Dockerfile.gcp_project.local ./resources
echo "--- Building 'k8s' Docker image"
docker build -t kfirz/deployster-k8s:${RELEASE_AND_SHA} -f ./resources/Dockerfile.k8s.local ./resources
echo "--- Building 'deployster' image"
docker build --build-arg "VERSION=${RELEASE_AND_SHA}" --tag kfirz/deployster:${RELEASE_AND_SHA} -f ./Dockerfile .

echo "--- Tagging Kubernetes resource image aliases"
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-clusterrole:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-clusterrolebinding:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-configmap:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-cronjob:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-daemonset:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-deployment:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-horizontalpodautoscaler:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-ingress:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-job:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-namespace:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-networkpolicy:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-node:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-persistentvolume:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-persistentvolumeclaim:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-pod:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-replicaset:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-replicationcontroller:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-role:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-rolebinding:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-secret:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-service:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-serviceaccount:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-statefulset:${RELEASE_AND_SHA}
docker tag kfirz/deployster-k8s:${RELEASE_AND_SHA} kfirz/deployster-k8s-storageclass:${RELEASE_AND_SHA}

if [[ -z "${LOCAL+x}" ]]; then
    echo "--- Pushing images"
    docker push kfirz/deployster-dresource:${RELEASE_AND_SHA}
    docker push kfirz/deployster-gcp:${RELEASE_AND_SHA}
    docker push kfirz/deployster-gcp-cloud-sql:${RELEASE_AND_SHA}
    docker push kfirz/deployster-gcp-compute-ip-address:${RELEASE_AND_SHA}
    docker push kfirz/deployster-gcp-gke-cluster:${RELEASE_AND_SHA}
    docker push kfirz/deployster-gcp-iam-policy:${RELEASE_AND_SHA}
    docker push kfirz/deployster-gcp-iam-service-account:${RELEASE_AND_SHA}
    docker push kfirz/deployster-gcp-project:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-clusterrole:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-clusterrolebinding:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-configmap:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-cronjob:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-daemonset:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-deployment:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-horizontalpodautoscaler:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-ingress:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-job:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-namespace:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-networkpolicy:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-node:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-persistentvolume:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-persistentvolumeclaim:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-pod:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-replicaset:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-replicationcontroller:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-role:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-rolebinding:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-secret:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-service:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-serviceaccount:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-statefulset:${RELEASE_AND_SHA}
    docker push kfirz/deployster-k8s-storageclass:${RELEASE_AND_SHA}

    echo "--- Pushing main Deployster image"
    docker push kfirz/deployster:${RELEASE_AND_SHA}
fi

exit 0
