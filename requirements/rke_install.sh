#!/bin/bash
wget https://github.com/rancher/rke/releases/download/v0.2.4/rke_linux-amd64
mkdir -p ${HOME}/bin/
mv rke_linux-amd64 ${HOME}/bin/rke
chmod +x ${HOME}/bin/rke
rke --version
