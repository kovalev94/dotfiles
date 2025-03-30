#!/usr/bin/env sh
TouchpadDeviceID=9
EnableTappingCode=$(xinput list-props "$TouchpadDeviceID"  \
    |  grep  "libinput Tapping Enabled ([0-9][0-9][0-9])" \
    | grep -oE "[0-9]{2,4}")
xinput set-prop "$TouchpadDeviceID" $EnableTappingCode 1
