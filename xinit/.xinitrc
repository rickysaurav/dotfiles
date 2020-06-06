wal --backend haishoku -t -i $HOME/wallpapers/ &
wal --theme random_dark&
xrdb -merge $HOME/.Xresources
exec i3
