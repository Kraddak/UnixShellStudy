#!/bin/bash

src=/home/kr4dd4k/Desktop/OLDPC/BackUpLinux
dest=$src


let count=11
for i in $(ls $src)
do
    
    echo $src/${i} $src/$count.mp3
    #mv $src/${i} $src/$count.mp3
    let count=$count+1
done

#/home/kraddak/Scrivania
#/home/kraddak/Documenti/Altro/日本語/intermediate/dialog





