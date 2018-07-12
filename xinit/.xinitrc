wal --backend haishoku -t -i $HOME/wallpapers/
wal --theme random_dark
setxkbmap -option 'caps:ctrl_modifier'
xcape -e 'Caps_Lock=Escape'
xrdb -merge $HOME/.Xresources
urxvtd -q -f -o
exec i3
