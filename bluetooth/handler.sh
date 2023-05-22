#!/bin/bash

# Check bluetooth state
BLUETOOTH_STATUS=$(system_profiler SPBluetoothDataType -json | jq ".[]" | jq ".[]" | jq ."controller_properties.controller_state")
if [[ $BLUETOOTH_STATUS == "\"attrib_off\""  ]]; then
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) Bluetooth is disconnected"
  exit 1
elif [[ $BLUETOOTH_STATUS != "\"attrib_on\"" ]]; then
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) Bluetooth status is unknow: ${BLUETOOTH_STATUS}"
  exit 1
fi

# Find device
DEVICE=$(system_profiler SPBluetoothDataType -json | jq ".[]" | jq ".[]" | jq ."device_connected" | jq ".[] | to_entries[]" | jq "select(.key == \"$1\")")

# Check if device is connected
if [[ "$DEVICE" != "" ]]; then
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) Device '$1' is already connected"
  exit 0
fi

# Connect to device
DEVICE_TO_CONNECT=$(system_profiler SPBluetoothDataType -json | jq ".[]" | jq ".[]" | jq ."device_not_connected" | jq ".[] | to_entries[]" | jq "select(.key == \"$1\")")
echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) Connecting to $1..."
if ! blueutil --connect "$(echo "$DEVICE_TO_CONNECT" | jq -r '.value.device_address')"; then
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) Failed to connect to device"
  exit 1
fi

echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) Device is connected"
