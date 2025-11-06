#!/run/current-system/profile/bin/bash


## If alacritty.yml does not exist, raise an alert
## Notify-send не установлен и требует настройки
[[ ! -f ~/.config/alacritty/alacritty.toml ]] && \
        notify-send "alacritty.toml does not exist" && exit 0
        
## Fetch background_opacity from alacritty.yml
opacity=$(awk '$1 == "opacity" {print $3; exit}' \
        ~/.config/alacritty/alacritty.toml)
echo $opacity

## Assign toggle opacity value
case $opacity in
      1)
        toggle_opacity=0.75
        ;;
      *)
        toggle_opacity=1
        ;;
esac
                        
## Replace opacity value in alacritty.toml
sed -i -- "s/opacity = $opacity/opacity = $toggle_opacity/" \
                                ~/.config/alacritty/alacritty.toml
