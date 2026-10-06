#!/usr/bin/bash
# Runs watch on the CNP cluster status.
#
# Usage:
#   ./watch-cluster.sh                      # interactive selection
#   ./watch-cluster.sh cluster-user2-major  # use the given cluster directly
#
# In interactive mode, cluster names are determined via "oc get clusters"
# (the userN part differs per environment).
 
if [ -n "$1" ]; then
  cluster="$1"
else
  names=$(oc get clusters --no-headers -o custom-columns=NAME:.metadata.name) || exit 1
 
  sample="" restore="" major=""
  for n in $names; do
    case "$n" in
      *restore*) restore="$n" ;;   # cluster-restore-userN
      *-major)   major="$n" ;;     # cluster-userN-major
      *)         sample="$n" ;;    # cluster-userN
    esac
  done
 
  echo "Which cluster do you want to watch?"
  echo "  1) cluster-sample  (${sample:-not found})"
  echo "  2) cluster-restore (${restore:-not found})"
  echo "  3) cluster-major   (${major:-not found})"
  read -r -p "Choice [1-3 or name]: " choice
 
  if [ -z "$choice" ]; then
    echo "No input." >&2
    exit 1
  fi
 
  # Accepts 1-3, the generic names, or the actual cluster names shown in parentheses
  case "$choice" in
    1|cluster-sample|"$sample")   cluster="$sample" ;;
    2|cluster-restore|"$restore") cluster="$restore" ;;
    3|cluster-major|"$major")     cluster="$major" ;;
    *) echo "Invalid input: $choice" >&2; exit 1 ;;
  esac
 
  if [ -z "$cluster" ]; then
    echo "Cluster for '$choice' not found." >&2
    exit 1
  fi
fi
 
exec watch -c -n 2 oc cnp --color always status "$cluster"
