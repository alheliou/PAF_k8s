#!/bin/bash
wget https://get.helm.sh/helm-v2.14.1-linux-amd64.tar.gz
tar -zxvf helm-v2.14.1-linux-amd64.tar.gz
mkdir -p ${HOME}/bin/
mv linux-amd64/helm ${HOME}/bin/helm
helm help
