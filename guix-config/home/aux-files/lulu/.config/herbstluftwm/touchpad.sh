#!/usr/bin/env sh
TOUCHPAD_DEV_NAME="GXTP7863:00 27C6:01E0 Touchpad"

xinput set-prop "$TOUCHPAD_DEV_NAME" "libinput Tapping Enabled" 1
xinput set-prop "$TOUCHPAD_DEV_NAME" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$TOUCHPAD_DEV_NAME" "libinput Click Method Enabled" 0 1
