#!/bin/sh

WALLPAPER=$HOME/Pictures/japan-city-anime.jpg
ENABLE_PICOM=true
TOUCHPAD_DEV_NAME="GXTP7863:00 27C6:01E0 Touchpad"

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

# Set wallpaper
feh --no-fehbg --bg-scale $WALLPAPER

# Setup touchpad
xinput set-prop "$TOUCHPAD_DEV_NAME" "libinput Tapping Enabled" 1
xinput set-prop "$TOUCHPAD_DEV_NAME" "libinput Natural Scrolling Enabled" 1
xinput set-prop "$TOUCHPAD_DEV_NAME" "libinput Click Method Enabled" 0 1

#turn on picom
if $ENABLE_PICOM; then
    picom \
        --blur-method=gaussian \
        --blur-size=20 \
        --blur-deviation=15 \
        --blur-strength=5 \
        --backend=glx \
        --fading \
        --fade-in-step=0.03 \
        --fade-out-step=0.03 \
        --fade-delta=5 \
        -b
fi

xrandr --output eDP-1 --dpi 192
xrdb -merge ~/.Xresources

exwm -mm
