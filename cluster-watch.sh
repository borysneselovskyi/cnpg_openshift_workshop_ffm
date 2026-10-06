!/usr/bin/bash
# Depending on the selection, runs the appropriate “watch” command for the CNP cluster status.
 
echo "Which cluster would you like to monitor?"
echo "  1) cluster-sample"
echo "  2) cluster-restore"
echo "  3) cluster-major-upgrade"
read -r -p "Selection [1-3 or Name]: " choice
 
case "$choice" in
  1|cluster-sample)
    # cluster-sample
    cluster="cluster-user2"
    ;;
  2|cluster-restore)
    # cluster-restore
    cluster="cluster-restore-user2"
    ;;
  3|cluster-major)
    # cluster-major
    cluster="cluster-user2-major"
    ;;
  *)
    echo "Invalid selection: $choice" >&2
    exit 1
    ;;
esac
 
exec watch -c -n 2 oc cnp --color always status "$cluster"

