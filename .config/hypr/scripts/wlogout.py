#!/usr/bin/env python3

import json
import subprocess

# Calculates the margins needed to size the wlogout buttons such that buttons
# have the same width and height.
# width: 2560 = 2w + 4b + 8m
# height: 1440 = 2h + b + 2m
# b = width/height of button
# m = margin of one side

j = subprocess.run(["hyprctl", "-j", "monitors"], capture_output=True)
j = json.loads(j.stdout)

monitor_width = 0
monitor_height = 0
for m in j:
    if m["focused"]:
        monitor_width = m["width"]
        monitor_height = m["height"]

button_size = 250
button_margin = 8
margin_left = str((monitor_width - 4*button_size - 8*button_margin)//2)
margin_top = str((monitor_height - button_size - 2*button_margin)//2)

print("margin_top=", margin_top,", margin_left=", margin_left)

subprocess.run([
    "wlogout",
    "-b", "4",
    "-B", margin_top,
    "-T", margin_top,
    "-L", margin_left,
    "-R", margin_left
])
