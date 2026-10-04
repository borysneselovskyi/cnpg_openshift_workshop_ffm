#!/bin/bash

. ./config.sh

#Doc
echo "20" > ./docs/docid

print_command "${kubectl_cmd} apply -f cluster-sample-major-upgrade-by-copy.yaml\n"

envsubst < ./yaml/cluster-sample-major-upgrade-by-copy.yaml | ${kubectl_cmd} apply -n ${namespace} -f-
