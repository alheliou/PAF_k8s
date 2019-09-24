#!/bin/bash
export KUBECONFIG=kube_config_rancher_kubernetes_cluster.yml

#install NFS server
helm install stable/nfs-server-provisioner --name nfsprovisioner --namespace nfsprovisioner --set=storageClass.defaultClass=true


