#!/bin/zsh

notify() {
    notify-send -a bluetooth "$1" "$2"
}

if ! systemctl is-active --quiet bluetooth; then
    notify "Bluetooth failed" "Bluetooth service is not running"
    exit 1
fi

if bluetoothctl show | grep -q "Powered: yes"; then
    if bluetoothctl power off >/dev/null 2>&1; then
        notify "Bluetooth disabled" "Bluetooth adapter is powered off"
    else
        notify "Bluetooth failed" "Could not power off the Bluetooth adapter"
        exit 1
    fi
else
    if bluetoothctl power on >/dev/null 2>&1; then
        notify "Bluetooth enabled" "Bluetooth adapter is powered on"
    else
        notify "Bluetooth failed" "Could not power on the Bluetooth adapter"
        exit 1
    fi
fi
