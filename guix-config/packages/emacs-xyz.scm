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
      (home-page url)
      (synopsis
       "Emacs windows resizing made intuitive.")
      (description
       "Move-border provides functions for resizing Emacs windows,
considering the current window border instead of the window itself.")
      (license license:gpl3))))

(define-public emacs-exwm-modeline-next
  (package
    (name "emacs-exwm-modeline-next")
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

(define-public emacs-good-scroll
  (package
    (name "emacs-good-scroll")
    (version "20211101.942")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/io12/good-scroll.el")
              (commit "a7ffd5c0e5935cebd545a0570f64949077f71ee3")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0f1zs3fjz5yc25qjka5g60018554ssdbp4j7xj275pmzrc78915w"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/io12/good-scroll.el")
    (synopsis "Good pixel line scrolling")
    (description
     "This package implements smooth scrolling by pixel lines.  It attempts to
improve upon `pixel-scroll-mode by adding variable speed.")
    (license license:expat)))

(define-public emacs-unicode-fonts
  (package
    (name "emacs-unicode-fonts")
    (version "v0.4.10")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/rolandwalker/unicode-fonts")
              (commit version)))
       (file-name (git-file-name name version))
       (sha256
        (base32 "07wzcfj92jiadgd6nj5rmxky2aiaxs89j7zywp877xdp4vv0v512"))))
    (build-system emacs-build-system)
    (arguments (list #:tests? #f))      ; no test suite
    (home-page "https://github.com/rolandwalker/unicode-fonts")
    (synopsis "Configure Unicode fonts for Emacs")
    (description
     "This library configures Emacs in a Unicode-friendly way by providing mappings
from each Unicode block to a font with good coverage")
    (license #f)))

(define-public emacs-vi-tilde-fringe
  (package
    (name "emacs-vi-tilde-fringe")
    (version "20141028.242")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/syl20bnr/vi-tilde-fringe")
              (commit "f1597a8d54535bb1d84b442577b2024e6f910308")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0wdm8k49zl6i6wnh7vjkswdh5m9lix56jv37xvc90inipwgs402z"))))
    (build-system emacs-build-system)
    (home-page "https://github.com/syl20bnr/vi-tilde-fringe")
    (synopsis "Displays tildes in the fringe on empty lines a la Vi")
    (description "Displays tildes in the fringe on empty lines a la Vi")
    (license license:gpl3)))


(define-public emacs-evil-easymotion
  (package
    (name "emacs-evil-easymotion")
    (version "20200424.135")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/PythonNut/evil-easymotion")
              (commit "f96c2ed38ddc07908db7c3c11bcd6285a3e8c2e9")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0xsva9bnlfwfmccm38qh3yvn4jr9za5rxqn4pwxbmhnx4rk47cch"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-avy))
    (home-page "https://github.com/pythonnut/evil-easymotion")
    (synopsis "A port of vim's easymotion to emacs")
    (description
     "This is a clone of the popular easymotion package for vim, which describes
itself in these terms:  EasyMotion provides a much simpler way to use
some motions in vim. It takes the <number> out of <number>w or <number>f@{char@}
by highlighting all possible choices and allowing you to press one key  to
jump directly to the target.")
    (license #f)))

(define-public emacs-embrace
  (package
    (name "emacs-embrace")
    (version "20231027.419")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/cute-jumper/embrace.el")
              (commit "c7e748603151d7d91c237fd2d9cdf56e9f3b1ea8")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1c6fbkw1hl9bhdy62g782js8i9kgjr0pr132mpga12jd4cwf8mmz"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-expand-region))
    (home-page "https://github.com/cute-jumper/embrace.el")
    (synopsis "Add/Change/Delete pairs based on `expand-region'")
    (description
     "This package is heavily inspired by evil-surround
(which is a port of the vim plugin surround.vim). But instead of using evil and
its text objects, this package relies on another excellent package expand-region.")
    (license #f)))

(define-public emacs-evil-embrace
  (package
    (name "emacs-evil-embrace")
    (version "20230820.445")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/cute-jumper/evil-embrace.el")
              (commit "3081d37811b6a3dfaaf01d578c7ab7a746c6064d")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "13rqkdhhzvnw3s49zm3v9xska8j8l1mr85czcfaf5vrm99lx8rl3"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-embrace emacs-evil-surround))
    (home-page "https://github.com/cute-jumper/evil-embrace.el")
    (synopsis "Evil integration of embrace.el")
    (description
     "This package provides evil integration of embrace.el.
Since evil-surround provides a similar set of features as embrace.el,
this package aims at adding the goodies of embrace.el to evil-surround
and making evil-surround even better.")
    (license #f)))

(define-public emacs-evil-snipe
  (package
    (name "emacs-evil-snipe")
    (version "20250505.508")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/hlissner/evil-snipe")
              (commit "16317d7e54313490a0fe8642ed9a1a72498e7ad2")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0rg677wdybgjqz8kfr8v7xrcqw53qm1kxcsdsqqq8z0wklb0s29d"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-evil))
    (home-page "https://github.com/hlissner/evil-snipe")
    (synopsis "Emulate vim-sneak & vim-seek")
    (description
     "Evil-snipe emulates vim-seek and/or vim-sneak in evil-mode.  It provides
2-character versions of evil's f/F/t/T motions, for quick and more accurately
jumping around text, plus incremental highlighting (for f/F/t/T as well).  To
enable globally: (require evil-snipe) (evil-snipe-mode 1) To replace evil-mode's
f/F/t/T functionality with (1-character) sniping: (evil-snipe-override-mode 1)
See included README.md for more information.")
    (license license:expat)))

(define-public emacs-evil-textobj-anyblock
  (package
    (name "emacs-evil-textobj-anyblock")
    (version "20170905.1907")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/noctuid/evil-textobj-anyblock")
              (commit "ff00980f0634f95bf2ad9956b615a155ea8743be")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0wn5lp7kh3ip1bmqi12c9ivpjj0x602h8d7ag39qw36smv4jqvnb"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-evil))
    (home-page "https://github.com/noctuid/evil-textobj-anyblock")
    (synopsis "Textobject for the closest user-defined blocks")
    (description
     "This package is a port of vim-textobj-anyblock.
It gives text objects for the closest block of those defined in the
evil-anyblock-blocks alist.  By default it includes (), @{@}, [], <>, , \"\", ``,
and “”.  This is convenient for operating on the closest block without having to
choose between typing something like i@{ or i<.  This package allows for the list
of blocks to be changed.  They can be more complicated regexps.
A simple expand-region like functionality is also provided when in visual mode,
though this is not a primary focus of the plugin and does not exist in
vim-textobj-anyblock.  Also, in the case that the point is not inside of a block,
anyblock will seek forward to the next block.  The required version of evil is
based on the last change I could find to evil-select-paren, but the newest version
of evil is probably preferable.  For more information see the README in the github
repo.")
    (license license:gpl3)))

(define-public emacs-exato
  (package
    (name "emacs-exato")
    (version "20200524.1319")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/ninrod/exato")
              (commit "5e7b5721bf48aa49c6cdb5d41b908ef7d513b2a8")))
       (file-name (git-file-name name version))
       (sha256
        (base32 "0m98bwj8dy90ifck8rsda6zfgbjrv5z0166pp7qzvwls9rqa695m"))))
    (build-system emacs-build-system)
    (propagated-inputs (list emacs-evil))
    (home-page "https://github.com/ninrod/exato")
    (synopsis "EXATO: Evil XML/HTML Attributes Text Object")
    (description
     "This package provides the `x` text object to manipulate html/xml tag attributes.
 it is a port of https://github.com/whatyouhide/vim-textobj-xmlattr vim plugin.")
    (license #f)))

(define-public emacs-evil-quick-diff
  (let ((commit "69c883720b30a892c63bc89f49d4f0e8b8028908")
        (revision "0")
        (url "https://github.com/rgrinberg/evil-quick-diff"))
    (package
      (name "emacs-evil-quick-diff")
      (version (git-version "0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
                (url url)
                (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "15cww264lhddxh0d2ca5qd5nq5pda8hs4nj8mcpb5xlnmkayav50"))))
      (build-system emacs-build-system)
      (arguments (list #:tests? #f))      ; no test suite
      (propagated-inputs
       (list emacs-evil))
      (home-page url)
      (synopsis
       "Completion-At-Point Extension for YASnippet.")
      (description
       "A simple capf (Completion-At-Point Function) for completing yasnippet snippets.")
      (license license:gpl3))))
