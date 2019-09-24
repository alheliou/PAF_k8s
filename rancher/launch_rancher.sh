#!/bin/bash
# proxy and user conf
hostname=$1
export KUBECONFIG=kube_config_rancher_kubernetes_cluster.yml

# add the helm chart repository
helm repo add rancher-stable https://releases.rancher.com/server-charts/stable

#Installing cert manager
helm upgrade --install cert-manager stable/cert-manager \
  --namespace kube-system \
  --version v0.5.2

kubectl -n kube-system rollout status deploy/cert-manager


# Using Ranger Generated Certificates
helm upgrade --install rancher rancher-stable/rancher \
  --namespace cattle-system \
  --set hostname=$hostname

kubectl -n cattle-system rollout status deploy/rancher




