#!/bin/bash

SCREENSHOTS_DIR=~/Pictures/Screenshots
TIMESTAMP="$(date +%Y.%m.%d-%H.%M.%S)"
FILENAME=$SCREENSHOTS_DIR/$TIMESTAMP.screenshot.png


if [[ "$1" = "-s" ]]; then
    # Area/window selection.
    notify-send 'Select area to capture.' --urgency low 
    maim -u -m 3 -s $FILENAME
    if [[ "$?" = "0" ]]; then
        notify-send "A screenshot has just been saved in the folder: ~/Pictures/Screenshots/" --urgency low -i $PHOTO_ICON_PATH
    fi
else
    # Full screenshot
    maim -u -m 3 $FILENAME
    notify-send "A screenshot has just been saved in the folder: ~/Pictures/Screenshots/" --urgency low -i $FILENAME
fi
