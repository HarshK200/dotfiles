#!/usr/bin/env bash

# turn off the screen saver i.e. screen lock
# i.e. triggered by 
# - `xset s` the timer which invokes 
# - xss-lock which invokes 
# - i3-lock
xset s off

# turn of the display auto turn off (handled by xset dmps)
xset -dmps
