#!/bin/bash
. ./config.sh

#Doc
echo "32" > ./docs/docid

i=$1
case $i in
  "on")
    print_command "${kubectl_cnp} hibernate on ${cluster_name}\n"
    ${kubectl_cnp} hibernate on ${cluster_name}
    ;;
  "off")
    print_command "${kubectl_cnp} hibernate off ${cluster_name}\n"
    ${kubectl_cnp} hibernate off ${cluster_name}
    ;;
  *)
    echo "usage: $0 on|off"
    exit
esac

