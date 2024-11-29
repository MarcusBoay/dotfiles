#!/usr/bin/env bash
# Credit: danielbeecham
# remove if already known
bluetoothctl devices | grep WH-1000XM5 | cut 1 | xargs --no-run-if-empty bluetoothctl remove

# connect again
timeout --kill=12 10s stdbuf -oL bluetoothctl scan on | sed -n '/WH-1000XM5/{p;q}' | cut 2 | while read addr; do bluetoothctl trust $addr && bluetoothctl connect $addr; done
