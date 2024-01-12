#!/bin/bash

DESTINATION=$1
PORT=$2
CHAT=$3

# clone Flectra directory
git clone --depth=1 https://github.com/6Ministers/flectra-2.0dev-docker-compose $DESTINATION
rm -rf $DESTINATION/.git

# set permission
mkdir -p $DESTINATION/postgresql
sudo chmod -R 777 $DESTINATION

# config
if grep -qF "fs.inotify.max_user_watches" /etc/config/sysctl.conf; then echo $(grep -F "fs.inotify.max_user_watches" /etc/config/sysctl.conf); else echo "fs.inotify.max_user_watches = 524288" | sudo tee -a /etc/config/sysctl.conf; fi
sudo sysctl -p
sed -i 's/10020/'$PORT'/g' $DESTINATION/docker-compose.yml
sed -i 's/20020/'$CHAT'/g' $DESTINATION/docker-compose.yml

# run Flectra
docker-compose -f $DESTINATION/docker-compose.yml up -d

echo 'Started Flectra @ http://ip:'$PORT' | Master Password: master.password | Live chat port: '$CHAT
