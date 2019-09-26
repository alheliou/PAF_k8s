#!/bin/bash

# deploy the cluster
rke up --config rancher_kubernetes_cluster.yml

export KUBECONFIG=kube_config_rancher_kubernetes_cluster.yml

# check the cluster
echo "##### CLUSTER CHECK #####"
kubectl  get nodes

#install helm
kubectl --namespace kube-system create serviceaccount tiller
kubectl  create clusterrolebinding tiller --clusterrole cluster-admin --serviceaccount=kube-system:tiller
helm init --service-account tiller --wait
kubectl  -n kube-system  rollout status deploy/tiller-deploy





