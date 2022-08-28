#!/bin/bash
sudo apt install etcd-client
export advertise_url=$( kubectl -n kube-system get po/etcd-main.easypay.com -o yaml | awk '/kubeadm.kubernetes.io\/etcd.advertise-client-urls:/{ print $2 }' )
sudo ETCDCTL_API=3 etcdctl --endpoints $advertise_url --cacert /etc/kubernetes/pki/etcd/ca.crt --key /etc/kubernetes/pki/etcd/server.key --cert /etc/kubernetes/pki/etcd/server.crt snapshot save etcd_backup.db
