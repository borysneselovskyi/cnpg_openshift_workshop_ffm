source ./config.sh
source ./replica.sh


#Doc
echo "30" > ./docs/docid

i=$1
case $i in
  "on")
    print_command "${kubectl_cnp} fencing on ${cluster_name} ${replica}\n"
    ${kubectl_cnp} fencing on ${cluster_name} ${cluster_name}-2
    ;;
  "off")
    print_command "${kubectl_cnp} fencing off ${cluster_name} ${replica}\n"
    ${kubectl_cnp} fencing off ${cluster_name} ${replica}
    ;;
  *)
    echo "usage: $0 on|off"
    exit
esac
