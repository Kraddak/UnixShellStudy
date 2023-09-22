#!/bin/bash

src=/home/kr4dd4k/Desktop/BashStuff/conversions/audio
#src="/media/kraddak/PENNA USB/Danmachi/S2"
#dest=/media/kraddak/9C33-6BBD/Anime/SSS/hunterXhunter/S6_Formichimere
dest=/home/kr4dd4k/Desktop/BashStuff/conversions/done

echo MOSTRA PATH: $src

title=
let count=0

for x in $(ls "$src")
do
    let count=$count+1
    s="$src/$x"
    echo Path source: $s

    duration=$(ffmpeg -i "$s" 2>&1 | grep Duration | cut -c 13-23)
    echo Durata episodio: $duration    

    minSec=${duration/??:/}
    minSec=${minSec/\.??/}
    min=${minSec/:??/}
    sec=${minSec/??:/}
    echo Durata frammentata: $minSec $min $sec

    let ending=0
    #sottrarre dalla durata, la durata della ending
    let targetLength=$min*60+$sec-$ending
    let min=$targetLength/60
    let sec=$targetLength-$min*60
    formatLength=00:$min:$sec
    echo Durata target: $formatLength

    echo Comando finale: -i "$s" -to $formatLength $dest/$title_$count.mp3 
    y | ffmpeg -i "$s" $dest/$title_$count.mp3
    #ffmpeg -i "$s" -to $formatLength $dest/$title_$count.mp3

done

#EXECUTE: ./convert.sh
#AkatsukiNoYona_Ep_01_SUB_ITA


#ffmpeg -ss 00:01:00 -i input.mp4 -to 00:02:00 -c copy output.mp4
#-i: This specifies the input file. In that case, it is (input.mp4).
#-ss: Used with -i, this seeks in the input file (input.mp4) to position.
#00:01:00: This is the time your trimmed video will start with.
#-to: This specifies duration from start (00:01:40) to end (00:02:12).
#00:02:00: This is the time your trimmed video will end with.
#-c copy: This is an option to trim via stream copy. (NB: Very fast)




