# caffeinated-macos

An anti-sleep utils for macOS.

> At the moment this is just a little workaround to h**k the [Kandji](https://www.kandji.io/), joining [mac-blue-keep-alive](https://github.com/MendyLanda/mac-blue-keep-alive) and [system_profiler SPBluetoothDataType](https://stackoverflow.com/questions/38116299/is-there-a-command-line-interface-to-list-all-bluetooth-devices-in-range-on-mac) to keep my "lovely" macOS bluetooth awake.
> 
> It works with:
> - Logitech MX Keys Mini
> - Logitech MX Vertical
> - Sony WH-1000XM3+

# How to use

## Requirements
- Install  [blueutil](https://github.com/toy/blueutil)  with  `brew install blueutil`
- Install  [jq](https://stedolan.github.io/jq/)  with  `brew install jq`

## Git clone & chmod
1. Clone this repo  `git clone https://github.com/jefferson-amorim/caffeinated-macos.git && cd caffeinated-macos`
2. Run  `chmod +x ./caffeine.sh`


## Start the script
- Pair your bluetooth device with your mac and get the device name
- Run  `BLUETOOTH_DEVICE_NAME=<YOUR_DEVICE_NAME> ./caffeine.sh` 

## Stop the script

- Run  `crontab -e`  and remove the line that was added by the script or clear all cron jobs by running  `crontab -r`

## Troubleshooting

- To check the script logs, run:
    - `tail -f /tmp/stdout.log`
    -   `tail -f /tmp/stderr.log`  for errors
