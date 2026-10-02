#!/bin/bash

#crc delete -f
#crc cleanup

if [ ! -f "pull_secret.txt" ]; then
  echo ""
  echo "Error starting CRC."
  echo "Error: pull_secret.txt not found"
  echo "Please, create file with Red Hat secret."
  echo "Check this link: https://www.redhat.com/en/blog/install-openshift-local"
  exit 1
fi

crc setup
crc config set cpus 10
crc config set consent-telemetry no
crc config set memory 20480
crc config set preset openshift
crc config set disk-size 60
crc stop
#crc config set disk-size 100

crc start -p ./pull_secret.txt

eval $(crc oc-env)
crc console --credentials

kubectl config set-context --current --namespace=openshift-operators

echo ""
echo ""
echo "eval $(crc oc-env)"
echo "oc login -u kubeadmin https://api.crc.testing:6443"
echo ""
