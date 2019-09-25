#!/bin/bash
export KUBECONFIG=kube_config_rancher_kubernetes_cluster.yml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml
kube proxy
