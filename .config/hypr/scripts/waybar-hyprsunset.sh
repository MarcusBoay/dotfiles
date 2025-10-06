#!/usr/bin/env bash

step=2
command="${1}"
case ${command} in
    + | -)
        hyprctl hyprsunset gamma "${command}${step}"
        ;;
esac
gamma=`hyprctl hyprsunset gamma`
gamma=$( printf "%.0f" $gamma )
echo '{ "percentage":' "$gamma" '}'
