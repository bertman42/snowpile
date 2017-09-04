DIR='/home/pi/snowpile/images/'
echo "DIR is: "$DIR

FILENAME=`date | sed -e 's/ /_/g' | sed -e 's/:/_/g'.jpg`
echo "FILENAME is: $FILENAME

echo "Taking picture..."
#/usr/bin/fswebcam -d /dev/video0 -i 0 -S 60 -F 20 --deinterlace -r 1024x768 $DIR$FILENAME
/usr/bin/fswebcam -d /dev/video0 -i 0 -S 5 -F 1 --deinterlace --no-banner -r 1024x768 $DIR$FILENAME

echo 'Adding banner..."
convert $DIR$FILENAME -pointsize 30 -fill white -stroke black -gravity southeast -annotate +4+0 "$(date +"%D %r")" $DIR$FILENAME


