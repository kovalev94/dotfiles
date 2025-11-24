(define-module (guix-config packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz))


(define-public emacs-yasnippet-capf
  (let ((commit "f53c42a996b86fc95b96bdc2deeb58581f48c666")
        (revision "0")
        (url "https://github.com/elken/yasnippet-capf"))
    (package
     (name "emacs-yasnippet-capf")
     (version (git-version "0.1" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url url)
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1hwsra5w150dfswkvw3jryhkg538nm3ig74xzfplzbg0n6v7qs19"))))
     (build-system emacs-build-system)
     (propagated-inputs
      (list emacs-yasnippet))
     (arguments (list #:tests? #f))      ; no test suite
     (home-page url)
     (synopsis
      "Completion-At-Point Extension for YASnippet.")
     (description
      "A simple capf (Completion-At-Point Function) for completing yasnippet snippets.")
     (license license:gpl3))))

(define-public emacs-nerd-icons-corfu
  (package
   (name "emacs-nerd-icons-corfu")
   (version "20250729.1544")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/LuigiPiucco/nerd-icons-corfu")
           (commit "f821e953b1a3dc9b381bc53486aabf366bf11cb1")))
     (file-name (git-file-name name version))
     (sha256
      (base32 "036p45wqwrqhn5xv5sn3gsm2mb79gj6fk24zpkfa7wrv45qqgb21"))))
   (build-system emacs-build-system)
   (propagated-inputs (list emacs-nerd-icons))
   (home-page "https://github.com/LuigiPiucco/nerd-icons-corfu")
   (synopsis "Icons for Corfu via nerd-icons")
   (description
    "Introduces a margin formatter for Corfu which adds icons.  The icons are
configurable, but should be text icons provided by the icons fonts in
`nerd-icons'.  To use, install the package and add the following to your init:
(add-to-list corfu-margin-formatters #'nerd-icons-corfu-formatter).")
   (license license:gpl3)))

;;https://github.com/tumashu/vertico-posframe
;;https://github.com/emacs-exwm/xdg-launcher
(define-public emacs-xdg-launcher
  (let ((commit "251f8cd9f6a83d07e1f4a110142fb4810c94f24a")
        (revision "0")
        (url "https://github.com/emacs-exwm/xdg-launcher"))
    (package
     (name "emacs-xdg-launcher")
     (version (git-version "0.1" revision commit))
     (source
      (origin
       (method git-fetch)
       (uri (git-reference
             (url url)
             (commit commit)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1ymlfza0v5widh4n9abj3pv59b5vn9kvmx79z84xhx86s2a11cw5"))))
     (build-system emacs-build-system)
     (propagated-inputs
      (list emacs-yasnippet))
     (arguments (list #:tests? #f))      ; no test suite
     (home-page url)
     (synopsis
      "Launch application from Emacs.")
     (description
      "XDG launcher implements a dmenu-style XDG application launcher
in Emacs using standard Emacs minibuffer completion.")
     (license license:gpl3))))
