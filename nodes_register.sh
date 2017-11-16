#!/bin/bash

file_ports="ports.file"
template_addr="http://localhost:"
template_path="/nodes/register"
template_resolve="/nodes/resolve"

if [ ! -f $file_ports ]
    then
        echo "nodes not started"
        exit 0
fi

ports_last=`cat $file_ports`
echo $ports_last

ports_last=(`echo ${ports_last}`);

data="{\"nodes\"   :   ["
data=$data\"$template_addr${ports_last[0]}$template_path\"

for (( i=1; i<${#ports_last[@]}; i++))
do
    data=$data", "
    data=$data\"$template_addr${ports_last[$i]}$template_path\"
done

data=$data"] }"
echo
echo 'Data for request:'
echo
echo $data
echo
for (( i=0; i<${#ports_last[@]}; i++))
do
    addr=$template_addr${ports_last[$i]}$template_path
    echo "request to $addr"
    req="curl -X POST -H \"Content-Type:application/json\" -d '$data' $addr" 
    eval $req #! impotant   
done


