#!/bin/bash
. ./config.sh

#Doc
echo "14" > ./docs/docid

i=$1
case $i in
  "out")
    print_command "${kubectl_cmd} scale cluster.postgresql.k8s.enterprisedb.io ${cluster_name} --replicas=4\n"
    ${kubectl_cmd} scale cluster.postgresql.k8s.enterprisedb.io ${cluster_name} --replicas=4
    ;;
  "in")
    print_command "${kubectl_cmd} scale cluster.postgresql.k8s.enterprisedb.io ${cluster_name} --replicas=2\n"
    ${kubectl_cmd} scale cluster.postgresql.k8s.enterprisedb.io ${cluster_name} --replicas=2
    ;;
  *)
    echo "usage: $0 out|in"
    exit
esac
