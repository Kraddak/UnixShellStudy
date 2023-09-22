#!/bin/bash

exec 3< path
read -u 3 perc
#echo $perc

cont=499

back=*.

front=.*


for i in $(ls $perc)
do
    ((cont++))
    newBack=tep
    newFront=.mp3

    var=${i//$back/$newBack$cont}
    var=${var//$front/$newFront}
    echo $perc/${var}

    #mv $perc/${i} $perc/${var}
done


#/home/kraddak/Documenti/Altro/日本語/intermediate/dialog





