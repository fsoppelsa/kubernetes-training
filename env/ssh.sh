#!/bin/bash -eux
docker run \
  -ti \
  -v ~/.ssh/:/root/.ssh \
    jdeathe/centos-ssh \
      ssh \
      -vvv \
    -o Compression=yes \
	-o LogLevel=FATAL \
	-o StrictHostKeyChecking=no \
	-o UserKnownHostsFile=/dev/null \
	-o IdentitiesOnly=yes \
	  "$@"
