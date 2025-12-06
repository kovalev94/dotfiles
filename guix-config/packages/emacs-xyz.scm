(define-module (guix-config packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (gnu packages emacs-build)
  #:use-module (gnu packages emacs)
  #:use-module (guix download)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (guix-config packages emacs)
  #:use-module (gnu packages emacs-xyz))


(define-public emacs-exwm-transparent
  (package/inherit emacs-exwm
    (name "emacs-exwm-transparent")
    (arguments (append
                (package-arguments emacs-exwm)
                (list #:emacs emacs-transparent)))
    (synopsis "Emacs X window manager(with emacs-transparent use)")))

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

(define-public emacs-nerd-icons-completion
  (package
    (name "emacs-nerd-icons-completion")
    (version "20251029.2106")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/rainstormstudio/nerd-icons-completion")
              (commit "d09ea987ed3d2cc64137234f27851594050e2b64")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "022yfkfvcywgjplvsj5xajmc24q1c7yx0l5mvnzagjfdg4iajidv"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-nerd-icons emacs-compat))
    (home-page "https://github.com/rainstormstudio/nerd-icons-completion")
    (synopsis "Add icons to completion candidates")
    (description
     "Add nerd-icons to completion candidates.  nerd-icons-completion is inspired by
`all-the-icons-completion': https://github.com/iyefrat/all-the-icons-completion.")
    (license license:gpl3)))

(define-public emacs-move-border
  (let ((commit "79787ae93129fd98029c74780a79a2b659803061")
        (revision "0")
        (url "https://github.com/ramnes/move-border"))
    (package
      (name "emacs-move-border")
      (version (git-version "0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
                (url url)
                (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "0syazkswcdf9wv561nlfr9zx32hfwh9mjlbjrqhb5g6l5367f81b"))))
      (build-system emacs-build-system)
      (propagated-inputs
       (list emacs-yasnippet))
      (arguments (list #:tests? #f))      ; no test suite
      (home-page url)
      (synopsis
       "Emacs windows resizing made intuitive.")
      (description
       "Move-border provides functions for resizing Emacs windows,
considering the current window border instead of the window itself.")
      (license license:gpl3))))

(define-public emacs-exwm-modeline
  (package
    (name "emacs-exwm-modeline")
    (version "20250222.1334")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/SqrtMinusOne/exwm-modeline")
              (commit "c933baccb8535a81ebae06a5dc4245b801c47f06")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "19csnf2qgkwy8gpdn1bx5fifw4ibjw3kbjhsabhjbr3j529p5v45"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-exwm-transparent))
    (home-page "https://github.com/SqrtMinusOne/exwm-modeline")
    (synopsis "A modeline segment for EXWM workspaces")
    (description
     "This package provides a modeline segment to display exwm workspaces.  Features:
- Supports `exwm-randr to display only of workspaces related to the the current
monitor. - The segment is clickable.  Take a look at `exwm-modeline-mode for
more info.")
    (license license:gpl3)))

(define-public emacs-perspective-exwm
  (package
    (name "emacs-perspective-exwm")
    (version "20231225.2313")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/SqrtMinusOne/perspective-exwm.el")
              (commit "68fb0ca2d482e0f4a92c4ceb19bf2262ea937e95")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1sq00ifmdf61m3vpj59b2fc14djy1sxqnwk5wjg4zbkvml9hf7d2"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-burly emacs-exwm-transparent emacs-perspective))
    (home-page "https://github.com/SqrtMinusOne/perspective-exwm.el")
    (synopsis "Better integration for perspective.el and EXWM")
    (description
     "This package provides a couple of tricks and fixes to make using EXWM and
perspective.el a better experience.  Most importantly, this package provides
`perspective-exwm-mode', which fixes certain annoying issues between the two
packages.")
    (license license:gpl3)))


(define-public emacs-embark-consult
  (package
    (name "emacs-embark-consult")
    (version "1.1")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://elpa.gnu.org/packages/embark-consult-"
                           version ".tar"))
       (sha256
        (base32 "06yh6w4zgvvkfllmcr0szsgjrfhh9rpjwgmcrf6h2gai2ps9xdqr"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-compat emacs-embark emacs-consult))
    (home-page "https://github.com/oantolin/embark")
    (synopsis "Consult integration for Embark")
    (description
     "Embark makes it easy to choose a command to run based on
what is near point, both during a minibuffer completion session (in a way
familiar to Helm or Counsel users) and in normal buffers.")
    (license license:gpl3+)))
