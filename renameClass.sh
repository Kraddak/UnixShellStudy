    #!/bin/bash

    src='/tmp/project'

    # Select the names to change
    originals=( "old1" "old2")
    substitutes=("new1"  "new2")

    exec 3< $src

    fileNames=( $(find "$src") )

    for ((i=${#fileNames[@]}-1; i>=0; i--)); do

        pathName="${fileNames[$i]/\/*\//}"    
        fileName="${fileNames[$i]/${pathName}/}"

        newpathName=$pathName
        
        echo ${fileNames[$i]}

        for index in ${!originals[@]}; do
            if [[ $pathName =~ ${originals[$index]} ]]; then
                newpathName=${newpathName/${originals[$index]}/${substitutes[$index]}}
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

    originals=("old1" "old2")
    substitutes=("new1" "new2")

    for path in $(find "$src"); do
        if [[ -f "$path" ]]; then

            for index in "${!originals[@]}"; do

                tmp=$(grep "${originals[$index]}" "$path")

                if [[ $tmp =~ ${originals[$index]} ]]; then
                    echo "File: $path"
                    echo "Matched Line: $tmp"
                    echo " "
                    sed -i "s/${originals[$index]}/${substitutes[$index]}/g" "$path"
                fi
            done
        fi
    done

