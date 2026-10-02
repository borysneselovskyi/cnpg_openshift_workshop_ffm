#!/bin/bash

source ./config.sh > /dev/null 2>&1
source ./env.sh > /dev/null 2>&1

print_command "\n${kubectl_cnp} psql ${cluster_name}-major -- -d app -c \"select version();\"\n"
${kubectl_cnp} psql ${cluster_name}-major -- -d app -c "select version();"

print_command "\n${kubectl_cnp} psql ${cluster_name}-major -- -d app -c \"select count(*) from test;\"\n"
${kubectl_cnp} psql ${cluster_name}-major -- -d app -c "select count(*) from test;"
