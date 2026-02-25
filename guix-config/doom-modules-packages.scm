(define-module (guix-config doom-modules-packages)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (guix-config packages emacs-xyz))


(define-public doom-module-corfu-packages
  (list
   emacs-corfu
   emacs-cape
   emacs-orderless
   emacs-yasnippet-capf
   emacs-nerd-icons-corfu))

(define-public doom-module-vertico-packages
  (list
   emacs-vertico
   emacs-consult
   emacs-consult-dir
   emacs-embark
   emacs-marginalia
   emacs-wgrep
   emacs-consult-yasnippet
   emacs-embark-consult
   emacs-nerd-icons-completion))

(define-public doom-module-doom-packages
  (list
   emacs-doom-themes
   emacs-solaire-mode))

(define-public doom-module-emoji-packages
  (list
   emacs-emojify))

(define-public doom-module-hl-todo-packages
  (list
   emacs-hl-todo))
(define-public doom-module-ligatures-packages
  (list
   emacs-ligature))

(define-public doom-module-modeline-packages
  (list
   emacs-doom-modeline
   emacs-anzu
   emacs-evil-anzu))

(define-public doom-module-ophints-packages
  (list
   emacs-evil-goggles
   emacs-goggles))

(define-public doom-module-smooth-scroll-packages
  (list
   emacs-ultra-scroll
   emacs-good-scroll))

(define-public doom-module-unicode-packages
  (list
   emacs-unicode-fonts))

(define-public doom-module-vc-gutter-packages
  (list
   emacs-diff-hl))

(define-public doom-module-vi-tilde-fringe-packages
  (list
   emacs-vi-tilde-fringe))


(define-public doom-module-evil-packages
  (list
   emacs-evil
   emacs-evil-args
   emacs-evil-escape
   emacs-evil-exchange
   emacs-evil-indent-plus
   emacs-evil-lion
   emacs-evil-nerd-commenter
   emacs-evil-numbers
   emacs-evil-surround
   emacs-evil-traces
   emacs-evil-visualstar
   emacs-evil-collection
   emacs-evil-easymotion
   emacs-evil-embrace
   emacs-evil-snipe
   emacs-evil-textobj-anyblock
   emacs-exato
   emacs-evil-quick-diff))

(define-public doom-module-format-packages
  (list
   emacs-apheleia))

(define-public doom-module-snippets-packages
  (list
   emacs-auto-yasnippet
   emacs-doom-snippets))

(define-public doom-module-whitespace-packages
  (list
   emacs-dtrt-indent
   emacs-ws-butler))

(define-public doom-module-dired-packages
  (list
   emacs-dirvish
   emacs-diredfl))

(define-public doom-module-ibuffer-packages
  (list
   emacs-ibuffer-projectile
   emacs-ibuffer-vc))

(define-public doom-module-undo-packages
  (list
   emacs-undo-fu
   emacs-undo-fu-session
   emacs-vundo))

(define-public doom-module-vterm-packages
  (list
   emacs-vterm))

(define-public doom-module-eval-packages
  (list
   emacs-quickrun
   emacs-eros))

(define-public doom-module-lookup-packages
  (list
   emacs-dumb-jump
   emacs-request))

(define-public doom-module-magit-packages
  (list
   emacs-transient
   emacs-magit))

(define-public doom-module-pass-packages
  (list
   emacs-pass
   emacs-password-store
   emacs-password-store-otp))

(define-public doom-module-pdf-packages
  (list
   emacs-pdf-tools
   emacs-saveplace-pdf-view))

(define-public doom-module-json-packages
  (list
   emacs-json-mode
   emacs-json-snatcher))

(define-public doom-module-file-templates-packages
  (list
   emacs-diff-hl))

(define-public doom-module-sh-packages
  (list
   emacs-bash-completion))

(define-public doom-module-yaml-packages
  (list
   emacs-yaml-mode))

(define-public doom-module-default-packages
  (list
   emacs-avy
   emacs-link-hint))

(define-public doom-module-magit-packages
  (list
   emacs-magit))

(define-public doom-module-dired-packages
  (list
   emacs-dirvish
   emacs-diredfl))
