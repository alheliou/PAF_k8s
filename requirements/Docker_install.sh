#!/bin/bash
#Installation of Docker
sudo yum install -y yum-utils \
device-mapper-persistent-data \
lvm2

sudo yum-config-manager \
--add-repo \
https://download.docker.com/linux/centos/docker-ce.repo

sudo yum install -y docker-ce-18.09.9-3.el7.x86_64 docker-ce-cli-18.09.9-3.el7.x86_64 containerd.io

sudo systemctl start docker
sudo usermod -aG docker ${USER}
sudo systemctl enable docker
sudo newgrp docker
docker run hello-world
