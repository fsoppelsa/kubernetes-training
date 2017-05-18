Kubernetes-training
===================

Use ***env***

Prerequisites:
==============

* Docker 17.05+ from the edge channel
* Go 1.6 (better 1.7) if you do not use Mac
* The `moby` and `linuxkit` binaries. In ***bin/*** the versions for OS X. To build them (i.e. who's on Linux):

```
git clone github.com:linuxkit/linuxkit $GOPATH/src/github.com/linuxkit/linuxkit
cd $GOPATH/src/github.com/linuxkit/linuxkit
make
cp bin/* $THIS-LOCAL-REPO/bin
```

Build a K8s env
===============

* `git clone git@github.com:fsoppelsa/kubernetes-training.git`
* `cd kubernetes-training/env`
* Paste your SSH `id_rsa.pub` key file content in .yml files around the end, substitute ***# Your ssh key goes here***
* `cd .. ; mv bin ..` # hardcoded stuff, because `../../bin/moby` is invoked
* `cd env ; make build-vm-images` # may take up to 10 minutes
* `./boot-master.sh` # This starts a master via hyperkit on OS X, on Qemu on Linux
* This will be up in 2 or 3 seconds. Type ENTER and then get the eth0 address: `ip addr show dev eth0`
* Open a new shell and: `./ssh_into_kubelet.sh <IP>`
* In this new shell: `kubeadm-init.sh` # Takes 1, 2 minutes.
* Wait until the master is Ready!!! Check with `kubectl get nodes` until you see `moby-xxxxx Ready`
* Take note of the token in output, something like ***cd9b45.501fc7d4fc481545***
* Only when the Master node is Ready, open a new shell and join a node: `./boot-node.sh 1 --token <T> <IP>:6443`
* Open an extra new shell and join another node: `./boot-node.sh 2 --token <T> <IP>:6443`
* For example `./boot-node.sh 1 --token cd9b45.501fc7d4fc481545 192.168.0.5:6443`
* You can add as many minions as you want. For training, 2 are ok

Now you have 4 shells: 1 for Master boot, 1 is SSH to Master, 1 is Node1 boot, 1 is Node2 boot.

For the training tests we'll use ***always the one with SSH into the Kubelet, the second in order***.
Do not close others.
To shutdown a machine in the other 3 shells at the end of training, just type `halt` in it.
