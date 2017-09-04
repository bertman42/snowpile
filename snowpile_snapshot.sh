#!/bin/bash
#
# Setup variables
TIMELAPSE_VIDEO=snowpile_timelapse.mp4
REMOTESERVER="tsttoolsserver"
REMOTEPATH="/var/www/html/snowpile_timelapse"


#Let's make sure we have the right TimeZone
export TZ=America/Toronto

DIR='/home/pi/snowpile/images_timelapse'
echo -e "\nDIR is: "$DIR

typeset -i N=$(cat /home/pi/snowpile/timerfile.dat)
echo -e "\nOriginal number is: " $N

N=$N+1
echo -e "\nNew number is: " $N
echo $N > /home/pi/snowpile/timerfile.dat

NUMBER=$(printf "%05d.jpg" "$N")

echo -e "\nNew number padded is: " $NUMBER

FILENAME=$NUMBER
echo -e "\nFILENAME is: " $FILENAME

echo -e "\nTaking picture..."

/usr/bin/fswebcam -d /dev/video0 -i 0 -S 60 -F 20 --no-banner --deinterlace -r 1024x768 $DIR/$FILENAME

#/usr/bin/fswebcam -d /dev/video0 -i 0 -S 30 -F 5 --no-banner --deinterlace -r 1024x768 $DIR$FILENAME

echo -e "\nAdding banner..."
#convert $DIR/$FILENAME -pointsize 30 -fill white -stroke black -gravity southeast -annotate +4+0 "$(date +"%D %r")" $DIR$FILENAME
convert $DIR/$FILENAME -pointsize 40 -fill white -undercolor '#00000080' -stroke black -gravity southeast -draw "text 20,0 '$(date +"%D")' " $DIR/$FILENAME

echo -e "\nMaking the timelapse..."
avconv -y -r 5 -i $DIR/%05d.jpg -vcodec libx264 -r 30 $DIR/$TIMELAPSE_VIDEO

echo  -e "\n Transferrring to server... "
scp $DIR/$FILENAME test.lab@$REMOTESERVER:$REMOTEPATH
scp $DIR/$TIMELAPSE_VIDEO test.lab@$REMOTESERVER:$REMOTEPATH
