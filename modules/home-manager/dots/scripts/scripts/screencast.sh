DATE=$(date +"%Y%m%d%H%M%S")
filename="$HOME/screencasts/screencast$DATE.mkv"
#ffmpeg -f x11grab -r 25 -s 1280x720 -i :0.0+0,24 -vcodec libx264 -vpre lossless_ultrafast -threads 0 video.mkv
ffmpeg -f x11grab -video_size 1920x1080 -framerate 25 -i $DISPLAY -f alsa -i default -r 30 -s 1280x720 -c:v libx264 -preset:v ultrafast -b:v 2000k -c:a libopus -b:a 128k $filename

