#!/bin/bash

set -e

# Scripts
BLUETOOTH_SCRIPT="$(pwd)/bluetooth/caffeinated-it.sh"

# Set BLUETOOTH_DEVICE_NAME to keep alive
# BLUETOOTH_DEVICE_NAME="<YOUR BT DEVICE NAME>"

# Set BLUETOOTH_CHECK_INTERVAL in minutes (between 1 and 59)
BLUETOOTH_CHECK_INTERVAL=5

# Change to executable
chmod +x "$BLUETOOTH_SCRIPT"

($BLUETOOTH_SCRIPT "$BLUETOOTH_DEVICE_NAME" $BLUETOOTH_CHECK_INTERVAL)
