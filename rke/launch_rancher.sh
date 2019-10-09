#!/bin/bash
# proxy and user conf
if [ $# -eq 0 ]
then hostname=$1
else hostname=$HOSTNAME
fi

export KUBECONFIG=kube_config_rancher_kubernetes_cluster.yml

# add the helm chart repository
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

#Installing cert manager
helm install --name cert-manager stable/cert-manager \
  --namespace kube-system \
  --set proxy=$http_proxy\
  --version v0.5.2

kubectl -n kube-system rollout status deploy/cert-manager


# Using Ranger Generated Certificates
helm install --name rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=$hostname \
  --set proxy=$http_proxy
 

kubectl -n cattle-system rollout status deploy/rancher




