(provide 'exwm-keybinding)

;;These keybindings always handled by exwm
(setq exwm-input-prefix-keys '(?\M-x
                               ?\M-:
                               ?\s))

(setq  exwm-input-global-keys
       `(
         ;; XF86Kes map
         (,(kbd "<XF86MonBrightnessDown>") . (lambda () (interactive) (start-process "brightnessctl" nil "brightnessctl" "s" "10%-")))
         (,(kbd "<XF86MonBrightnessUp>") . (lambda () (interactive) (start-process "brightnessctl" nil "brightnessctl" "s" "+10%")))
         (,(kbd "<XF86AudioMute>") . (lambda () (interactive) (start-process "pulsemixer" nil "pulsemixer" "--toggle-mute")))
         (,(kbd "<XF86AudioLowerVolume>") . (lambda () (interactive) (start-process "pulsemixer" nil "pulsemixer" "--change-volume" "-10")))
         (,(kbd "<XF86AudioRaiseVolume>") . (lambda () (interactive) (start-process "pulsemixer" nil "pulsemixer" "--change-volume" "+10" "--max-volume" "120")))
         (,(kbd "<XF86AudioMicMute>") . (lambda () (interactive) (start-process "pulsemixer" nil "pulsemixer" "--toggle-mute" "--id" "source-5")))
         ;; issue
         (,(kbd "<XF86WLAN>") . (lambda () (interactive) (start-process-shell-command "rfkill" nil "rfkill toggle wlan")))
         (,(kbd "<print>") . (lambda () (interactive) (start-process "flameshot" nil "flameshot" "screen")))
         (,(kbd "S-<print>") . (lambda () (interactive) (start-process "flameshot" nil "flameshot" "gui")))


         ([?\s-R] . exwm-reset)
         ([?\s-b] . exwm-workspace-switch-to-buffer)
         ([?\s-C] . kill-buffer-and-window)
         ([?\s-d] . xdg-launcher-run-app)
         ([?\s-f] . exwm-layout-toggle-fullscreen)
         ([?\s-n] . (lambda () (interactive) (start-process "nyxt" nil "nyxt")))

         ;; change to something like emacs-pass
         ([?\s-y] . (lambda () (interactive) (start-process "rofi-pass" nil "rofi-pass")))
         ([?\s-`] . (lambda () (interactive) (start-process "xlock" nil "xlock")))
         ([s-return] . +vterm/here)
         ([?\s-m] . exwm-workspace-move-window)

         ;; Bind "s-0" to "s-9" to switch to a workspace by its index.
         ,@(mapcar (lambda (i)
                     `(,(kbd (format "s-%d" i)) .
                       (lambda ()
                         (interactive)
                         (exwm-workspace-switch-create ,i))))
                   (number-sequence 0 9))


         ;; movement between windows
         ([s-left]  . windmove-left)
         ([s-down]  . windmove-down)
         ([s-up]    . windmove-up)
         ([s-right] . windmove-right)
         ([?\s-h]     . windmove-left)
         ([?\s-j]     . windmove-down)
         ([?\s-k]     . windmove-up)
         ([?\s-l]     . windmove-right)

         ;; split windows(ex frames)
         ([?\s-o] . my-split-window-right)
         ([?\s-u] . my-split-window-below)
         ([?\s-r] . delete-window)

         ;; moving windows
         ([s-S-left] . +evil/window-move-left)
         ([s-S-down]. +evil/window-move-down)
         ([s-S-up] . +evil/window-move-up)
         ([s-S-right] . +evil/window-move-right)
         ([?\s-H] . +evil/window-move-left)
         ([?\s-J] . +evil/window-move-down)
         ([?\s-K] . +evil/window-move-up)
         ([?\s-L] . +evil/window-move-right)

         ;; resizing frames and floating clients
         ([?\s-\C-h]   .  move-border-left)
         ([?\s-\C-j]   .   move-border-down)
         ([?\s-\C-k]   .   move-border-up)
         ([?\s-\C-l]   .  move-border-right)
         ([s-C-left]   .  move-border-left)
         ([s-C-down]   .   move-border-down)
         ([s-C-up]   .   move-border-up)
         ([s-C-right]   .  move-border-right)

         ([?\s-i]   .  exwm-input-release-keyboard)
         ([s-escape]   .  exwm-input-grab-keyboard)

         ([s-tab]   .  evil-window-next)
         ([s-iso-lefttab]   .  evil-window-prev)))



;; cycle through workspaces
;;hc keybind $Mod-period use_index +1 --skip-visible
;;hc keybind $Mod-comma  use_index -1 --skip-visible
;;
;;
;;;; layouting
;;hc keybind $Mod-s floating toggle
;;hc keybind $Mod-f fullscreen toggle
;;hc keybind $Mod-Shift-f set_attr clients.focus.floating toggle
;;# The following cycles through the available layouts within a frame, but skips
;;# layouts, if the layout change wouldn't affect the actual window positions.
;;# I.e. if there are two windows within a frame, the grid layout is skipped.
;;#hc keybind $Mod-space                                                           \
;;
;;
;;# focus
;;hc keybind $Mod-BackSpace   cycle_monitor
;;hc keybind $Mod-Tab         cycle_all +1
;;hc keybind $Mod-Shift-Tab   cycle_all -1
;;hc keybind $Mod-Shift-backslash cycle
;;hc keybind $Mod-i jumpto urgent
;;
;;hc keybind $Mod-backslash                                                               \
;;            or , and . compare tags.focus.curframe_wcount = 2                   \
;;                     . cycle_layout +1 vertical horizontal max vertical grid    \
;;               , cycle_layout +1






;; hc keybind Print spawn flameshot screen
;; hc keybind Shift-Print spawn flameshot gui
;;
;; # basic movement in tiling and floating mode
;; # focusing clients
;; hc keybind $Mod-Left  focus left
;; hc keybind $Mod-Down  focus down
;; hc keybind $Mod-Up    focus up
;; hc keybind $Mod-Right focus right
;; hc keybind $Mod-h     focus left
;; hc keybind $Mod-j     focus down
;; hc keybind $Mod-k     focus up
;; hc keybind $Mod-l     focus right
;;
;;
;; # moving clients in tiling and floating mode
;; hc keybind $Mod-Shift-Left  shift left
;; hc keybind $Mod-Shift-Down  shift down
;; hc keybind $Mod-Shift-Up    shift up
;; hc keybind $Mod-Shift-Right shift right
;; hc keybind $Mod-Shift-h     shift left
;; hc keybind $Mod-Shift-j     shift down
;; hc keybind $Mod-Shift-k     shift up
;; hc keybind $Mod-Shift-l     shift right
;;
;; # splitting frames
;; # create an empty frame at the specified direction
;; hc keybind $Mod-u       split   bottom  0.5
;; hc keybind $Mod-o       split   right   0.5
;; # let the current frame explode into subframes
;; #hc keybind $Mod-Control-space split explode
;; hc keybind $Mod-Control-z split explode
;;
;;
;; # resizing frames and floating clients
;; resizestep=0.02
;; hc keybind $Mod-Control-h       resize left +$resizestep
;; hc keybind $Mod-Control-j       resize down +$resizestep
;; hc keybind $Mod-Control-k       resize up +$resizestep
;; hc keybind $Mod-Control-l       resize right +$resizestep
;; hc keybind $Mod-Control-Left    resize left +$resizestep
;; hc keybind $Mod-Control-Down    resize down +$resizestep
;; hc keybind $Mod-Control-Up      resize up +$resizestep
;; hc keybind $Mod-Control-Right   resize right +$resizestep
;;
;;
;; # cycle through tags
;; hc keybind $Mod-period use_index +1 --skip-visible
;; hc keybind $Mod-comma  use_index -1 --skip-visible
;;
;;
;;# layouting
;;hc keybind $Mod-r remove
;;hc keybind $Mod-s floating toggle
;;hc keybind $Mod-f fullscreen toggle
;;hc keybind $Mod-Shift-f set_attr clients.focus.floating toggle
;;
;;
;;
;;
;;for i in "${!tag_names[@]}" ; do
;;key="${tag_keys[$i]}"
;;if [ -n "$key" ] ; then
;;hc keybind "$Mod-$key" use_index "$i"
;;hc keybind "$Mod-Shift-$key" move_index "$i"
;;fi
;;done
