(define-module (kovalev keyboard)
  #:use-module (gnu system keyboard)
  #:export (kb-layout))


(define kb-layout
  (keyboard-layout
   "us,ru"
   #:options '("grp:alt_space_toggle" "caps:swapescape")))
