#!/bin/bash

# Analysis format: name, type of test, number of executed operations, number of succeded, number of failed
# Example: name 1 22 22 0

exec 4<testout.log

test1=0
test2=0
test3=0
success1=0
success2=0
success3=0
failed1=0
failed2=0
failed3=0

# -u => what file descriptor to read from
# -a ANAME => The words are assigned to sequential indexes of the array variable ANAME, starting at 0.
while read -u 4 -a line; do
    if [[ ${line[1]} == "1" ]]; then
        let test1++
        let success1+=${line[3]}
        let failed1+=${line[4]}
    fi
    if [[ ${line[1]} == "2" ]]; then
        let test2++
        let success2+=${line[3]}
        let failed2+=${line[4]}
    fi
    if [[ ${line[1]} == "3" ]]; then
        let test3++
        let success3+=${line[3]}
        let failed3+=${line[4]}
    fi
done

echo "Number of test 1 executed: $test1"
echo "  Number of successes: $success1"
echo "  Number of failures: $failed1" 
echo "Number of test 2 executed: $test2"
echo "  Number of successes: $success2"
echo "  Number of failures: $failed2" 
echo "Number of test 3 executed: $test3"
echo "  Number of successes: $success3"
echo "  Number of failures: $failed3" 

if [[ -n "$1" ]]; then
    kill -USR1 $1
fi

exit
