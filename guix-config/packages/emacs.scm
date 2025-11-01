(define-module (guix-config packages emacs)
  #:use-module (guix packages)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages emacs))

(define-public emacs-transparent
  (package/inherit emacs
    (name "emacs-transparent")
    (synopsis "The extensible, customizable, self-documenting text
editor (with libxaw for transparency)")
    (inputs
     (modify-inputs (package-inputs emacs)
       (prepend libxaw)))))
