#!/bin/bash -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) # get current directory
DEVICE_INFO_FILENAME="${SCRIPT_DIR}/dev.info" # set path for file which will contain device addresses

save_devices() {
  >"${DEVICE_INFO_FILENAME}" # clear the file
  # iterate over all bluetooth devices and filter out connected
  while read -r uuid
  do
    info=`bluetoothctl info $uuid`
    if ! echo "$info" | grep -q "Connected: yes"; then
       continue
    fi
    echo "${uuid}" >> ${DEVICE_INFO_FILENAME} # save connected devices to the file
  done <<<$(bluetoothctl paired-devices | cut -f2 -d' ')

  if [[ ! -s "${DEVICE_INFO_FILENAME}" ]]; then
    # do nothing if no device connected
    echo "Connected audio bluetooth device not found."
    exit 0
  fi
}

restore_device() {
  # if no device were connected, exit normally
  if [[ ! -f "${DEVICE_INFO_FILENAME}" ]]; then
    echo "No saved bluetooth audio device was found."
    exit 0
  fi

  FAILED=0
  # iterate over devices from the file, ignoring errors
  # this is useful if some of the devices couldn't be connected for some reason (e.g. powered off)
  while read -r device
  do
    bluetoothctl connect "${device}" || FAILED=1 
  done <${DEVICE_INFO_FILENAME}
  exit ${FAILED} # inform systemd if we encouter some errors so it would retry this part
}

$@
