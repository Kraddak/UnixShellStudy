#!/bin/bash

function start_client {
    ./client Cliente${1}A $2 1>>testout.log &
}

./ob_store &
server_pid=$!

pids=
# First kind of test
if [[ -n "$1" && -n "$2" && -n "$3" ]]; then
    flag=1
    while [ $flag -le $1 ]; do
        start_client $flag 1
        pids+=($!)
        let flag++
    done
# Waiting for previus tests to finish
    for item in ${pids[@]}; do
        wait $item
    done
# Second kind of test
    flag=1
    while [ $flag -le $2 ]; do
        start_client $flag 2
        pids+=($!)
        let flag++
    done
# Third kind of test
    let limit=$3+flag-1
    while [ $flag -le $limit ]; do
        start_client $flag 3
        pids+=($!)
        let flag++
    done
# Waiting for all of them to finish
    for item in ${pids[@]}; do
        wait $item
    done
    echo "END"
    ./testsum.sh $server_pid
else
    echo "Provide three numbers as parameters"
fi


exit
