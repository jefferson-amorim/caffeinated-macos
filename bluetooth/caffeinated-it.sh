#!/bin/bash

# Validators: DEVICE_NAME
if [[ -z "$1" ]]; then
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) Device name is not provided"
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) - Set BLUETOOTH_DEVICE_NAME env var"
  exit 1
fi

# Validators: CHECK_INTERVAL
if [[ -z "$1" ]]; then
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) The interval is not provided"
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) - Set BLUETOOTH_CHECK_INTERVAL env var"
  exit 1
fi

DEVICE_NAME=$1
CHECK_INTERVAL=$2
HANDLER_PATH="$(pwd)/bluetooth/handler.sh"

# Validators: blueutil
if ! command -v blueutil &> /dev/null; then
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) blueutil is not installed"
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) - Install blueutil with: brew install blueutil"
  exit 1
fi

# Validators: jq
if ! command -v jq &> /dev/null; then
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) jq is not installed"
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) - Install jq with: brew install jq"
  exit 1
fi

# Change to executable
chmod +x "$HANDLER_PATH"

( crontab -l 2>/dev/null; echo -e "PATH=$PATH \n*/$CHECK_INTERVAL * * * * $HANDLER_PATH '$DEVICE_NAME' >/tmp/stdout.log 2>/tmp/stderr.log") | crontab - || {
  echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) An error occurred while setting up the cron job." >&2
  exit 1
}

echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) Bluetooth is caffeinated now!"
echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) - The script will check and try to connect to $DEVICE_NAME every $CHECK_INTERVAL minutes."
echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) - To stop the script, run 'crontab -r'"
echo "$(tput setaf 2)[caffeinated-macos]$(tput sgr0) - To check the script logs, run 'tail -f /tmp/stdout.log' or 'tail -f /tmp/stderr.log'"
