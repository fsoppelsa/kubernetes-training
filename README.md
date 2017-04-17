Vagrantfile
===========

HA Kubernetes local prototype installation with Vagrant
Created on and for Mac OS X 10.12.4, but things should not vary much

Facts:
* CentOS 7
* Kubernetes 1.5.2
* 3 Kubernetes master nodes with:
  * kube-apiserver
  * kube-scheduler
  * kube-controller-manager
  * kubelet
  * Containerized etcd
  * Containerized Calico with Bird and Felix
  * Docker 1.12.6

* 2 Kubernetes minions with:
  * kubelet
  * Docker 1.12.6

* 1 Load Balancer
