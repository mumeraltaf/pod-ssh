#!/bin/bash

set -e

#start dockerd
dockerd > /var/log/dockerd.log 2>&1 &

# Step 1: Do other tasks and write to logs
echo "hi" | tee /proc/1/fd/1

/usr/sbin/sshd -D