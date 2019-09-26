#!/bin/bash

export KUBECONFIG=kube_config_rancher_kubernetes_cluster.yml

kubectl delete -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml

kubectl delete -f dashboard-adminuser.yaml

