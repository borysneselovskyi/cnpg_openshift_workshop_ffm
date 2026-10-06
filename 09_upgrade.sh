#!/bin/bash


source ./config.sh

#Doc
echo "09" > ./docs/docid

./show_yaml.sh yaml/cluster-sample.yaml > $TMP/cluster-sample.yaml

if [ "$object_storage_type" == "aws" ]; then
  ./show_yaml.sh ./yaml/cluster-sample-upgrade-minio.yaml > $TMP/cluster-sample-upgrade-minio.yaml
  ./show_yaml.sh ./yaml/cluster-sample-upgrade-aws.yaml > $TMP/cluster-sample-upgrade-aws.yaml
  clear
  print_command "diff -a --suppress-common-lines -y $TMP/cluster-sample.yaml  $TMP/cluster-sample-upgrade-aws.yaml\n"
  diff -a --suppress-common-lines -y $TMP/cluster-sample.yaml  $TMP/cluster-sample-upgrade-aws.yaml
  sleep 8

  print_command "${kubectl_cmd} apply -n ${namespace} -f ./yaml/cluster-sample-upgrade.yaml\n"
  envsubst <  ./yaml/cluster-sample-upgrade-aws.yaml | ${kubectl_cmd} apply -n ${namespace} -f-

elif [ "$object_storage_type" == "minio" ]; then
  ./show_yaml.sh ./yaml/cluster-sample-upgrade-minio.yaml > $TMP/cluster-sample-upgrade-minio.yaml
  clear
  print_command "diff -a --suppress-common-lines -y $TMP/cluster-sample.yaml  $TMP/cluster-sample-upgrade-minio.yaml\n"
  diff -a --suppress-common-lines -y $TMP/cluster-sample.yaml  $TMP/cluster-sample-upgrade-minio.yaml
  sleep 8

  print_command "${kubectl_cmd} apply -n ${namespace} -f ./yaml/cluster-sample-upgrade-minio.yaml\n"
  envsubst <  ./yaml/cluster-sample-upgrade-minio.yaml | ${kubectl_cmd} apply -n ${namespace} -f-
fi
