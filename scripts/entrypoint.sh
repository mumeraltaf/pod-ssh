#!/bin/bash


cp /pod-ssh/data/authorized_keys /home/ubuntu/.ssh/authorized_keys



if [[ -z "${GIT_REPO}" ]]; then
  echo "No repo given so will not clone anything."
else
  ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
  export GIT_SSL_NO_VERIFY=1
  cd /home/ubuntu
  git clone ${GIT_REPO}
fi



exec ssh-start ssh-server