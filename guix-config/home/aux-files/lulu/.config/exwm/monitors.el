(provide 'monitors)

(defvar exwm-randr-plist '(0 "eDP-1"
                           1 "eDP-1"
                           2 "eDP-1"
                           3 "eDP-1"
                           4 "eDP-1"
                           5 "eDP-1"
                           6 "eDP-1"
                           7 "eDP-1"
                           8 "eDP-1"
                           9 "eDP-1"))
(defun exwm-change-screen ()
  (start-process
   "xrandr" nil "xrandr" "--output" "eDP-1" "--auto"))
;;; monitors.el ends here
