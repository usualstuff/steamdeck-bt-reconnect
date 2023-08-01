#!/bin/bash -e

REPO_ADDR="https://github.com/usualstuff/steamdeck-bt-reconnect"
DIR_NAME="/opt/steamdeck-bt-reconnect"

# check if we have root permissions
# ref: https://askubuntu.com/a/30157/8698
if ! [ $(id -u) = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

# clone target repo
if [[ ! -d "/opt/steamdeck-bt-reconnect" ]]; then
  cd /opt
  git clone "${REPO_ADDR}"
fi

# check for updates
cd ${DIR_NAME}
git reset --hard
git pull origin main

chmod 755 bt-control.bash uninstall.bash

# copy systemd unit files
cp -f save-bt-devices.service /etc/systemd/system/
cp -f restore-bt-devices.service /etc/systemd/system/

# enable services and reload systemd
systemctl daemon-reload
systemctl enable save-bt-devices.service
systemctl enable restore-bt-devices.service
