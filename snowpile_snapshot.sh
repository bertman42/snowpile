timestamp=`date | sed -e 's/ /_/g' | sed -e 's/:/_/g'`

/usr/bin/fswebcam -d /dev/video0 -i 0 -S 60 -F 20 --deinterlace -r 1024x768 $timestamp.jpg

#/usr/bin/fswebcam -d /dev/video0 -i 0 -S 5 -F 1 --deinterlace -r 1024x768 $timestamp.jpg


