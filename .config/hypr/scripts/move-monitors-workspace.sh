#!/bin/sh

if [ $# -eq 0 ]; then
    echo '''
Moves the workspace for multiple monitors by one.

Usage:
  ./move-monitors-workspaces.sh [ action ]
  -> action: "-" or "+"

  In hyprland:
  bind = $mainMod, mouse:275, exec, ~/.config/hypr/scripts/move-monitors-workspace.sh -

Assumption:
  Each monitor has 5 workspaces in the following configuration:
  Monitor 1: workspaces 1 2 3 4 5
  Monitor 2: workspaces 6 7 8 9 10

Note: this script has only been tested with two monitors.

Created by Marcus Boay.
    '''
    exit 1
fi

action=$1
monitor_workspaces=$(hyprctl monitors | grep -Po 'active workspace: (\d+)' | sed 's/active workspace: //g')

for i in $monitor_workspaces; do
    if [[ "$action" == "-" ]]; then
        # Ensure workspace is not the minimal for the monitor.
        if [[ "$i" != "1" && "$i" != "6" ]]; then
            hyprctl dispatch workspace "$(($i - 1))"
        fi
    elif [[ "$action" == "+" ]]; then
        # Ensure workspace is not the maximal for the monitor.
        if [[ "$i" != "5" && "$i" != "10" ]]; then
            hyprctl dispatch workspace "$(($i + 1))"
        fi
    fi
done