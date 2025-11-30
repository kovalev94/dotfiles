#!/usr/bin/env bash

POLYBAR_CONF_PATH=$HOME/.config/polybar/config.ini
POLYBAR_BAR_NAME=mainbar-herbst

#Get the current monitors
ALL_MONITORS=$(polybar -m | awk -F ":" '{print $1}')
# Launch bars
for mon in $ALL_MONITORS; do
  MONITOR=$mon polybar -c $POLYBAR_CONF_PATH $POLYBAR_BAR_NAME 2>&1 &
  disown
done
echo "Bars launched..."
# wait until the panels should be stopped
herbstclient -w '(quit_panel|reload)'
# stopp all started panels
polybar-msg cmd quit
