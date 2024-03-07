#!/usr/bin/env bash

pkill ydotoold
ydotoold &

# ydotool info
# Uses a bitmask
# 0x00 left
# 0x40 down
# 0x80 up
# Can combine down and up to click
 
libinput debug-events | while read -r event; do
    echo $event | grep ".*TABLET_TOOL_TIP.*down" > /dev/null
    if [[ $? == 0 ]]; then
        ydotool click 0x40
    fi

    echo $event | grep ".*TABLET_TOOL_TIP.*up" > /dev/null
    if [[ $? == 0 ]]; then
        ydotool click 0x80
    fi
done

