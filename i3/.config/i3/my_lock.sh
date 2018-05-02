#! /bin/bash
img="$(< "${HOME}/.cache/wal/wal")"   
img2="${img%.*}"
DATE=$(date +"%Y%m%d%H%M")
img2="$img2$DATE.png"
#echo $img2
convert $img -resize 1920x1080\! -blur 0x5 $img2
i3lock -k --time-font="Iosevka Nerd Font Bold" --date-font="Iosevka Nerd Font Bold" -i $img2 
rm -f $img2
