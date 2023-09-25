#!/bin/bash

src=/tmp/original
dest=/tmp/done

title=
let count=0

for x in $(ls "$src")
do
    let count=$count+1
    s="$src/$x"
    echo Path source: $s

    duration=$(ffmpeg -i "$s" 2>&1 | grep Duration | cut -c 13-23)
    echo Video length: $duration    

    minSec=${duration/??:/}
    minSec=${minSec/\.??/}
    min=${minSec/:??/}
    sec=${minSec/??:/}
    echo Duration expressed as minutes and seconds : $minSec $min $sec

    let ending=0
    #subtract the ending duration from the whole video duration
    let targetLength=$min*60+$sec-$ending
    let min=$targetLength/60
    let sec=$targetLength-$min*60
    formatLength=00:$min:$sec
    echo Target length: $formatLength

    y | ffmpeg -i "$s" $dest/${title}${count}
    # y | ffmpeg -i "$s" -to $formatLength $dest/$title_$count.mp3

done





