    #!/bin/bash

    src='/tmp/project'

    # Select the names to change
    original=( "old1" "old2")
    substitutes=("new1"  "new2")

    exec 3< $src

    fileNames=( $(find "$src") )

    for ((i=${#fileNames[@]}-1; i>=0; i--)); do

        pathName="${fileNames[$i]/\/*\//}"    
        fileName="${fileNames[$i]/${pathName}/}"

        newpathName=$pathName
        
        echo ${fileNames[$i]}

        for index in ${!original[@]}; do
            if [[ $pathName =~ ${original[$index]} ]]; then
                newpathName=${newpathName/${original[$index]}/${substitutes[$index]}}
            fi
        done

        if [[ $pathName != $newpathName ]]; then
            echo " -> $fileName$newpathName"
            echo ""
            #echo ""
            mv ${fileNames[$i]} "$fileName$newpathName"
        fi

    done

    #######################################################################################

    original=("old1" "old2")
    substitutes=("new1" "new2")

    for path in $(find "$src"); do
        if [[ -f "$path" ]]; then

            for index in "${!original[@]}"; do

                tmp=$(grep "${original[$index]}" "$path")

                if [[ $tmp =~ ${original[$index]} ]]; then
                    echo "File: $path"
                    echo "Matched Line: $tmp"
                    echo " "
                    sed -i "s/${original[$index]}/${substitutes[$index]}/g" "$path"
                fi
            done
        fi
    done

