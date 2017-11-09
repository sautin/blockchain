#!/bin/bash

port=2000
t=1
name=${0##*/}
n=$1
key2=
file='pids.file'

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
    pids_last=`cat $file`
    kill $pids_last
    rm $file;
}

if [ $key2 == "clean" ]
    then
        clean
        exit
else
    if [ ! -f $file ]
        then
            touch $file
    else
        clean
    fi
fi

pids=""

for (( i=0; i<$n; i++))
do
    let p=$port+$i
    echo "start node[$i] on port[$p]"
    pipenv run python blockchain.py -p $p &
    let pid=$!
    echo "runned with pid $pid"
    pids="$pids$pid "
    sleep $t
done
echo $pids
echo " $pids" >> $file
sleep $t
