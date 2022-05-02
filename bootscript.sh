#!/bin/bash

TIMEZONE=`cat /etc/timezone`
#Printing out server timezone
echo "This is the server timezone - $TIMEZONE"

#Reading the time from worldtime API for server time zone
WORLDTIMELINK="http://worldtimeapi.org/api/timezone/$TIMEZONE"
WORLD_TIME=$(curl "$WORLDTIMELINK" | jq -r '.unixtime')
LOCAL_TIME=$(date '+%s')
echo "Fetched UNIX Time: $WORLD_TIME"
echo "Server UNIX Time: $LOCAL_TIME"


#Check if local and world times are equal or not
if [ "$WORLD_TIME" = "$LOCAL_TIME" ]; then
    echo "Fetched Time and Server TIme are equal."
else
    echo "Fetched Time and Server TIme are not equal."
fi

#Update index.html with world time and local time
DISPLAY_WORLD_TIME=$(printf '%(%F %T)T\n' $WORLD_TIME)
DISPLAY_LOCAL_TIME=$(printf '%(%F %T)T\n' $LOCAL_TIME)
sed -i "/Fetched time/c\Fetched time: '$DISPLAY_WORLD_TIME'" /usr/share/nginx/html/index.html
sed -i "/Local time/c\Local time: '$DISPLAY_LOCAL_TIME'" /usr/share/nginx/html/index.html


#Checking response code of the server
STATUS_CODE=$(curl --write-out "%{http_code}\n" "http://localhost:80" --output output.txt --silent)
echo "Response Code from web server: $STATUS_CODE"
if [ "$STATUS_CODE" = "200" ]; then
	echo "Web server is responding the status code 200"
else
	echo "Web server is not responding the status code 200"
fi
