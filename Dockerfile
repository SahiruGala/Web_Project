FROM nginx:latest

COPY ./web/index.html /usr/share/nginx/html/index.html

# attach the bootstrap script to the docker image
ADD bootscript.sh /mnt/bootscript.sh

# Give execution rights on the cron scripts
RUN chmod 777 /mnt/bootscript.sh

#updating packages
RUN apt-get update
#Installing Cron and JQ
RUN apt-get -y install cron && apt-get -y install jq

ADD crontabconfig /mnt/crontabconfig

RUN crontab /mnt/crontabconfig

CMD [ "sh", "-c", "cron && nginx -g 'daemon off;'" ]