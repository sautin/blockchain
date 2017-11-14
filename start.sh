#!/bin/bash

port=5000
t=1
name=${0##*/}
n=$1
key2=
file_pids='pids.file'
file_ports='ports.file'

if [ $# -eq 0 ]
    then
        echo "use: $name <number_of_nodes>"
        exit 0
fi

if [ $n -lt 0 ]
    then
        echo "number_of_nodes would be more than 0"
    exit 0
fi

if [ -z "$2" ]
    then
        key2="run"
else
    key2="clean"
fi

function clean() {
    pids_last=`cat $file_pids`
    kill $pids_last
    rm $file_pids $file_ports
}

if [ $key2 == "clean" ]
    then
        echo 'cleaning'
        clean
        exit
else
    if [ ! -f $file_pids ]
        then
            echo "create $file_pids"
            touch $file_pids
        else
            echo "clean $file_pids"
            clean
    fi

    if [ ! -f $file_ports ]
        then
            echo "create $file_ports"
            touch $file_ports
        else
            echo "clean $file_ports"
            clean
    fi
fi

pids=""
ports=""
echo 'launch'
for (( i=0; i<$n; i++))
do
    let p=$port+$i
    echo "start node[$i] on port[$p]"
    pipenv run python blockchain.py -p $p &
    let pid=$!
    echo "runned with pid $pid"
    pids="$pids$pid "
    ports="$ports$p "
    sleep $t
done
echo $pids
echo $ports
echo " $pids" >> $file_pids
echo " $ports" >> $file_ports
sleep $t
