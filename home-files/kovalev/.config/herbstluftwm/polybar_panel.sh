#!/usr/bin/env bash

POLYBAR_CONF_PATH=$HOME/.config/polybar/config.ini
POLYBAR_BAR_NAME=mainbar-herbst
LOG_DIR=/var/log

#Get the current monitors
ALL_MONITORS=$(polybar -m | awk -F ":" '{print $1}')
# Launch bars
for mon in $ALL_MONITORS; do
  echo "---" | tee -a $LOG_DIR/.polybar-$mon.log
  MONITOR=$mon polybar -c $POLYBAR_CONF_PATH $POLYBAR_BAR_NAME 2>&1 |\
  tee -a $LOG_DIR/.polybar-$mon.log &\
  disown
done
echo "Bars launched..."
# wait until the panels should be stopped
herbstclient -w '(quit_panel|reload)'
# stopp all started panels
polybar-msg cmd quit

