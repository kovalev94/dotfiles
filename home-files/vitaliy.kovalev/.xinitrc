#!/bin/sh

WALLPAPER=$HOME/Pictures/japan-city-anime.jpg
ENABLE_PICOM=true

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

feh --no-fehbg --bg-scale $WALLPAPER

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
# Set mouse speed
xinput --set-prop 10 "libinput Accel Speed" -1
exwm -mm
