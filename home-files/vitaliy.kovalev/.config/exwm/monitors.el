(provide 'monitors)

(defvar exwm-randr-plist '(0 "DP-1"
                           1 "DP-1"
                           2 "DP-1"
                           3 "DP-1"
                           4 "DP-1"
                           5 "HDMI-2"
                           6 "HDMI-2"
                           7 "HDMI-2"
                           8 "HDMI-2"
                           9 "HDMI-2"))
(defun exwm-change-screen ()
  (start-process
   "xrandr" nil "xrandr" "--output" "DP-1" "--left-of" "HDMI-2" "--auto"))
