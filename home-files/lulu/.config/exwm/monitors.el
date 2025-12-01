(provide 'monitors)

(defvar exwm-randr-plist '(0 "eDP-1"))
(defun exwm-change-screen ()
  (start-process
   "xrandr" nil "xrandr --output eDP-1"))
;;; monitors.el ends here
