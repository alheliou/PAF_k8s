#!/bin/bash

export KUBECONFIG=kube_config_rancher_kubernetes_cluster.yml

helm delete --purge rancher
helm delete --purge cert-manager

