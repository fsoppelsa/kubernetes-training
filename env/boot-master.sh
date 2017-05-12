#!/bin/bash -eu
disk="kube-master-disk.img"
set -x
rm -f "${disk}"
../../bin/linuxkit run hyperkit -cpus 1 -mem 2048 -disk-size 4096 kube-master
