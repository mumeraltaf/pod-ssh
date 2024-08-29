#!/bin/bash

# Step 1: Do other tasks and write to logs
echo "hi" | tee /proc/1/fd/1

/usr/sbin/sshd -D