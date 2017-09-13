#! /bin/bash
img="$(< "${HOME}/.cache/wal/wal")"   
img2="${img%.*}"
DATE=$(date +"%Y%m%d%H%M")
img2="$img2$DATE.png"
#echo $img2
convert $img -blur 0x5 $img2
i3lock -k --timefont="Inconsolata Nerd Font Bold" --datefont="Inconsolata Nerd Font Bold" -i $img2  
rm -f $img2
