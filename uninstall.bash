#!/bin/bash -e
# disable systemd services
systemctl disable save-bt-devices.service
systemctl disable restore-bt-devices.service

# remove systemd unit files
rm -f /etc/systemd/system/save-bt-devices.service
rm -f /etc/systemd/system/restore-bt-devices.service

# reload systemd
systemctl daemon-reload

