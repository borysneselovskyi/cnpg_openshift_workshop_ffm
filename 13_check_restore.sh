#!/bin/bash

source ./config.sh

print_command "echo \"select version();\" | ${kubectl_cnp} psql ${cluster_restore}\n"
print_command "echo \"select * from test;\" | ${kubectl_cnp} psql ${cluster_restore}\n"

#cat sql/verify_data.sql | ${kubectl_cnp} psql ${cluster_restore} # will throw "Unable to use a TTY" and we want omit a "2>/dev/null"
${kubectl_cnp} psql ${cluster_restore} -- -c "$(cat sql/verify_data.sql)"

