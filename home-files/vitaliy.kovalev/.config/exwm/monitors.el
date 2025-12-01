(provide 'monitors)

(defvar exwm-randr-plist '(0 "DP-1" 1 "HDMI-2"))
(defun exwm-change-screen ()
  (start-process
   "xrandr" nil "xrandr" "--output" "DP-1" "--left-of" "HDMI-2" "--auto"))
