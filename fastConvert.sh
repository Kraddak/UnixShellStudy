#!/bin/bash

src='/home/kr4dd4k/Desktop/BashStuff/genericWire'

# Elencare le differenze
#originali=("remotestartup"    "RemoteStartupService"     "RemoteStartupServiceTest")
#sostituti=("everywherecloud"            "EWCService"                  "EWCServiceTest")
originali=( "ins"   "InsReader")
sostituti=("asterx"  "AsterxReader")

exec 3< $src

fileNames=( $(find "$src") )

#for right in $(find "$src"); do
for ((i=${#fileNames[@]}-1; i>=0; i--)); do

    #echo ${fileNames[$i]}

    right="${fileNames[$i]/\/*\//}"    
    left="${fileNames[$i]/${right}/}"
    
    #echo $left
    #echo $right
    #echo ""


    newRight=$right
    
    echo ${fileNames[$i]}

    for index in ${!originali[@]}; do
        if [[ $right =~ ${originali[$index]} ]]; then
            newRight=${newRight/${originali[$index]}/${sostituti[$index]}}
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

originali=( "ins\."   "InsReader")
sostituti=("asterx\."  "AsterxReader")


# Convert class names

for path in $(find "$src"); do    
    if [[ -f $path ]]; then


        for index in ${!originali[@]}; do

            #grep "${originali[$index]}" $path
            tmp=$(grep "${originali[$index]}" "$path")
    
            if [[ $tmp =~ ${originali[$index]} ]]; then
                echo $path
                echo $tmp
                echo " "
                sed -i s/${originali[$index]}/${sostituti[$index]}/ $path   
            fi

            
            #grep "${sostituti[$index]}" $path


        done
    fi
done

