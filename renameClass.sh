#!/bin/bash

src='/tmp/project'

# Select the names to change
original=( "old1" "old2")
substitutes=("new1"  "new2")

exec 3< $src

fileNames=( $(find "$src") )

for ((i=${#fileNames[@]}-1; i>=0; i--)); do

    right="${fileNames[$i]/\/*\//}"    
    left="${fileNames[$i]/${right}/}"

    newRight=$right
    
    echo ${fileNames[$i]}

    for index in ${!original[@]}; do
        if [[ $right =~ ${original[$index]} ]]; then
            newRight=${newRight/${original[$index]}/${substitutes[$index]}}
        fi
    done

    if [[ $right != $newRight ]]; then
        echo " -> $left$newRight"
        echo ""
        #echo ""
        mv ${fileNames[$i]} "$left$newRight"
    fi

done

    
    echo ""
    echo "----------------------------------------- WARNING --------------------------------------------"
    echo " Ho modificato gli array poiché sto differenziando tra fileName e className"
    echo "----------------------------------------- WARNING --------------------------------------------"
    echo ""

original=( "ins\."   "InsReader")
substitutes=("asterx\."  "AsterxReader")


# Convert class names

for path in $(find "$src"); do    
    if [[ -f $path ]]; then


        for index in ${!original[@]}; do

            #grep "${original[$index]}" $path
            tmp=$(grep "${original[$index]}" "$path")
    
            if [[ $tmp =~ ${original[$index]} ]]; then
                echo $path
                echo $tmp
                echo " "
                sed -i s/${original[$index]}/${substitutes[$index]}/ $path   
            fi

            
        [$index]}" $path


        done
    fi
done

