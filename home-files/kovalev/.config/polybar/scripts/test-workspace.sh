#!/usr/bin/env sh

MON_IDX="0"
mapfile -t MONITOR_LIST < <(polybar --list-monitors | cut -d":" -f1)
echo ${MONITOR_LIST[@]}
for (( i=0; i<$((${#MONITOR_LIST[@]})); i++ )); do
  [[ ${MONITOR_LIST[${i}]} == "$MONITOR" ]] && MON_IDX="$i"
done;

touch  ~/$MONITOR.test.hlwm
herbstclient tag_status ${MON_IDX} >> ~/$MONITOR.test.hlwm
herbstclient --idle "tag_*" 2>/dev/null >> ~/$MONITOR.test.hlwm

while true; do
    echo "test"
done
