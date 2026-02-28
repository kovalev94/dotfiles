(define-module (guix-config keyboard)
  #:use-module (gnu)
  #:use-module (gnu system keyboard)
  #:use-module (nongnu packages mozilla)
  #:use-module (nongnu packages chrome)
  #:use-module (nongnu packages fonts)
  #:use-module (guix-config packages telephony)
  #:use-module (guix-config packages emacs)
  #:use-module (guix-config packages emacs-xyz)
  #:use-module (guix-config packages fonts)
  #:use-module (guix-config packages python-xyz)
  #:use-module (guix-config packages golang-xyz)
  #:export (%my-kb-layout))


(define %my-kb-layout
  (keyboard-layout
   "us,ru"
   #:options '("grp:alt_space_toggle" "caps:swapescape")))

