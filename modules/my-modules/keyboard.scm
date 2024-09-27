(define-module (my-modules keyboard)
  #:use-module (gnu system keyboard)
  #:export (kb-layout))


(define kb-layout
  (keyboard-layout
   "us,ru"
   #:options '("grp:win_space_toggle")))
