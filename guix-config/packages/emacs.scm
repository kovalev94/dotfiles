(define-module (guix-config packages emacs)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix gexp)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages emacs))

(define-public emacs-transparent
  (package/inherit emacs
                   (name "emacs-transparent")
                   (synopsis "The extensible, customizable, self-documenting text
editor (with libxaw for transparency and imagemagick for images)")
                   (inputs
                    (modify-inputs (package-inputs emacs)
                                   (prepend imagemagick libxaw)))
                   (arguments
                    (substitute-keyword-arguments (package-arguments emacs)
                                                  ((#:configure-flags flags #~'())
                                                   #~(cons* "--with-imagemagick"  #$flags))))))

(define-public emacs-exwm-transparent
  (package/inherit emacs-exwm
                   (name "emacs-exwm-transparent")
                   (arguments (append
                               (package-arguments emacs-exwm)
                               (list #:emacs emacs-transparent)))
                   (synopsis "Emacs X window manager(with emacs-transparent use)")))
