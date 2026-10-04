#!/bin/bash

source ./config.sh

./show_yaml.sh yaml/cluster-sample-upgrade-minio.yaml > $TMP/cluster-sample-upgrade-minio.yaml 
./show_yaml.sh yaml/cluster-sample-major-upgrade-inplace.yaml > $TMP/cluster-sample-major-upgrade-inplace.yaml 

clear
print_command "diff -a --suppress-common-lines -y $TMP/cluster-sample-upgrade-minio.yaml  $TMP/cluster-sample-major-upgradei-inplace.yaml\n"
diff -a --suppress-common-lines -y $TMP/cluster-sample-upgrade-minio.yaml  $TMP/cluster-sample-major-upgrade-inplace.yaml

sleep 8

print_command "${kubectl_cmd} apply -n ${namespace} -f ./yaml/cluster-sample-major-upgrade-inplace.yaml\n"
envsubst <  ./yaml/cluster-sample-major-upgrade-inplace.yaml | ${kubectl_cmd} apply -n ${namespace} -f-
