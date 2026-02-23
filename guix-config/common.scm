(define-module (guix-config common)
  #:use-module (gnu system keyboard)
  #:export (%my-kb-layout))

(define %my-kb-layout
  (keyboard-layout
   "us,ru"
   #:options '("grp:alt_space_toggle" "caps:swapescape")))
