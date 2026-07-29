;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Vitaliy Kovalev"
      user-mail-address "vitaliy.kovalev@eltex.loc")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Fira Mono" :size 11.0 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 11.0))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-dracula)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Set dired work in async mode
(dired-async-mode 1)

;; Set evil work in minibuffer too
(setq evil-want-minibuffer t)

;; Set printing program
(setq pdf-misc-print-program-executable "lpr")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(after! vterm
  (setq vterm-max-scrollback 100000))

;; Fix guix emacs pinned find path.
(setopt find-program "find")

(set-frame-parameter nil 'alpha-background 75)
(add-to-list 'default-frame-alist '(alpha-background . 75))

(defun toggle-background-transparency ()
  "Toggle background transparency of the current Emacs frame."
  (interactive)
  (let ((current-alpha (cdr (assoc 'alpha-background (frame-parameters)))))
    (if (/= current-alpha 100)
        (set-frame-parameter nil 'alpha-background 100) ; Set opaque
      (set-frame-parameter nil 'alpha-background 75)))) ; Set transparent (e.g., 75%)

(evil-define-key 'normal 'global (kbd "M-o") 'toggle-background-transparency)

(set-email-account! "Eltex"
                    '((mu4e-sent-folder       . "/Eltex/Отправленные")
                      (mu4e-drafts-folder     . "/Eltex/Черновики")
                      (mu4e-change-filenames-when-moving t)
                      (mu4e-update-interval (* 10 60))
                      (mu4e-trash-folder      . "/Eltex/Корзина")
                      (mu4e-refile-folder     . "/Eltex/Вся\ почта")
                      (smtpmail-smtp-user     . "vitaliy.kovalev@eltex.loc")
                      (mu4e-compose-signature . "---\nVitaliy Kovalev"))
                    t)

(setq mu4e-context-policy 'ask-if-none
      mu4e-compose-context-policy 'always-ask)

(after! mu4e
  (setq sendmail-program (executable-find "msmtp")
	send-mail-function #'smtpmail-send-it
	message-sendmail-f-is-evil t
	message-sendmail-extra-arguments '("--read-envelope-from")
	message-send-mail-function #'message-send-mail-with-sendmail))

(after! docker
  (require 'evil-collection-docker)
  (evil-collection-docker-setup)
  (setq display-buffer-alist
        (cons '("\\*docker-" display-buffer-same-window)
              display-buffer-alist)))
