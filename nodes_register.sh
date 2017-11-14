#!/bin/bash

file_ports="ports.file"
template_addr="http://localhost:"
template_path="/nodes/register"
ports_last=`cat $file_ports`
echo $ports_last
for e in $ports_last
do
    let addr=$template_addr$e$template_path
    echo "{ \"nodes\":[\"$addr\"]}"
done
