#!/usr/bin/env bash

# Multi monitor support. Needs MONITOR environment variable to be set for each instance of polybar
# If MONITOR environment variable is not set this will default to monitor 0
# Check https://github.com/polybar/polybar/issues/763
MON_IDX="0"
mapfile -t MONITOR_LIST < <(polybar --list-monitors | cut -d":" -f1)
echo ${MONITOR_LIST[@]}
for (( i=0; i<$((${#MONITOR_LIST[@]})); i++ )); do
  [[ ${MONITOR_LIST[${i}]} == "$MONITOR" ]] && MON_IDX="$i"
done;

herbstclient --idle "tag_*" 2>/dev/null | {

    while true; do
        # Read tags into $tags as array
        IFS=$'\t' read -ra tags <<< "$(herbstclient tag_status "${MON_IDX}")"
        {
            for tag in "${tags[@]}" ; do
                # Read the prefix from each tag and render them according to that prefix
                name=${tag#?}
                case ${tag:0:1} in
                    '.')
                        # the tag is empty
                        # TODO Add your formatting tags
                        echo "%{F#4C566A}%{T2} $name %{T-}%{B-}"
                        ;;
                    ':')
                        # the tag is not empty
                        # TODO Add your formatting tags
                        echo "%{F#5f8787}%{T2} $name %{T-}%{B-}"
                        ;;
                    '+')
                        # the tag is viewed on the specified MONITOR, but this monitor is not focused.
                        # TODO Add your formatting tags
                        ;;
                    '#')
                        # the tag is viewed on the specified MONITOR and it is focused.
                        # TODO Add your formatting tags
                        echo "%{F#9db1f5}%{T2} $name %{T-}%{B-}"
                        ;;
                    '-')
                        # the tag is viewed on a different MONITOR, but this monitor is not focused.
                        # TODO Add your formatting tags
                        echo "%{F#5f81a5}%{T2} $name %{T-}%{B-}"
                        ;;
                    '%')
                        # the tag is viewed on a different MONITOR and it is focused.
                        # TODO Add your formatting tags
                        ;;
                    '!')
                        # the tag contains an urgent window
                        # TODO Add your formatting tags
                        echo "%{F#e78a53}%{T2} $name %{T-}%{B-}" # TODO Add your formatting tags for workspaces with the urgent hint
                        ;;
                esac

                # focus the monitor of the current bar before switching tags
                #echo "%{A1:herbstclient focus_monitor ${MON_IDX}; herbstclient use ${i:1}:}  ${i:1}  %{A -u -o F- B-}"
            done

            # reset foreground and background color to default
            echo "%{F-}%{B-}"
        } | tr -d "\n"

    echo

    # wait for next event from herbstclient --idle
    read -r || break
done
} 2>/dev/null
