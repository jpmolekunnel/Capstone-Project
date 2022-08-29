#!/bin/bash
log=${HOME}/install-leader.log
pod_network_cidr=192.168.0.0/16
sudo kubeadm init --pod-network-cidr ${pod_network_cidr} --ignore-preflight-errors all 2>&1 | tee ${log}

sleep 20

mkdir -p ${HOME}/.kube
sudo cp /etc/kubernetes/admin.conf ${HOME}/.kube/config
sudo chown -R $( id -u ):$( id -g ) ${HOME}/.kube/

echo 'source <(kubectl completion bash)' | tee --append ${HOME}/.bashrc
source ${HOME}/.bashrc

kubectl apply -f https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')

sudo kubeadm token create --print-join-command

