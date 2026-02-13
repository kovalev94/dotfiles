(define-module (guix-config package-sets))


(define-public base-sys
  (list
   "htop"
   "screen"
   "python"
   "mc"
   "vim"
   "minicom"
   ;;"lrzsz"
   "unzip"
   "zip"
   "7zip"
   "git"))

(define-public laptop
  (list
   "bluez"
   "tlp"))

(define-public base-gui
  (list
   "flameshot"
   "picom"
   "pavucontrol"
   "feh"
   "xrandr"
   "xinput"
   "xrdb"
   "imagemagick"
   "libreoffice"
   "firefox"
   "vlc"
   "x11-ssh-askpass"
   "scrot";; Temporary, I hope replacement for flameshot
   "xdg-utils"))

(define-public fs-tools
  (list
   "lvm2"
   "parted"))

(define-public work-tools
  (list
   "sipp"
   "ffmpeg"
   "audacity"
   "linphone-desktop"
   "ungoogled-chromium"
   "google-chrome-stable"
   "jq"))

(define-public network-tools
  (list
   "tcpdump"
   "wireshark"
   "wireguard-tools"
   "nmap"
   "netcat"
   "iputils"
   "nftables"
   "whois"
   "fping"
   "sshfs"
   "curl"
   "bind:utils"))

(define-public video-tools
  (list
   "obs"
   "kdenlive"))

(define-public emacs-base
  (list
   "emacs-transparent"
   "emacs-rg"
   "ripgrep"
   "emacs-pdf-tools"
   "emacs-vterm"
   "libvterm"
   "markdown"
   "shellcheck"
   "shfmt"
   "font-nerd-symbols-only"
   "emacs-nerd-icons-completion"
   "emacs-dashboard"
   "emacs-org-texlive-collection"
   "texlive-xetex"
   "fd"))

(define-public mail-emacs
  (list
   "mu"
   "isync"))

(define-public python-emacs
  (list
   "python"
   "python-black"
   "python-isort"
   "python-pytest"
   "python-pyflakes"
   "python-pynose"
   "python-pipenv"
   "python-lsp-server"))

(define-public ansible-emacs
  (list
   "ansible"
   "sshpass"
   "emacs-ansible"))

(define-public golang-emacs
  (list
   "go"
   "gopls"
   "gore"
   "go-github-com-cweill-gotests"
   "go-github-com-fatih-gomodifytags-next"))

(define-public virtualization-base
  (list
   "virt-manager"
   "spice-gtk"))

(define-public sys-fonts
  (list
   "font-gnu-freefont"
   "font-gnu-unifont"))

(define-public fira-code-fonts
  (list
   "font-fira-mono"
   "font-fira-sans"
   "font-fira-code"))

(define-public polybar-fonts
  (list
   "font-ubuntu"
   "font-google-noto-emoji"
   "font-awesome"
   "font-awesome-nonfree"))

(define-public herbst-de
  (append
   polybar-fonts
   fira-code-fonts
   (list
    "herbstluftwm"
    "alacritty"
    "polybar"
    "dunst"
    "rofi"
    "rofi-pass"
    "password-store"
    "gnupg"
    "dzen"
    "xftwidth"
    "brightnessctl"
    "pulsemixer")))

(define-public emacs-doom-module-corfu
  (list
   "emacs-corfu"
   "emacs-cape"
   "emacs-orderless"
   "emacs-yasnippet-capf"
   "emacs-nerd-icons-corfu"))

(define-public emacs-doom-module-vertico
  (list
   "emacs-vertico"
   "emacs-consult"
   "emacs-consult-dir"
   "emacs-embark"
   "emacs-marginalia"
   "emacs-wgrep"
   "emacs-consult-yasnippet"
   "embark-consult"
   "nerd-icons-completion"))

(define-public emacs-doom-module-doom
  (list
   "emacs-doom-themes"
   "emacs-solaire-mode"))

(define-public emacs-doom-module-emoji
  (list
   "emacs-emojify"))

(define-public emacs-doom-module-hl-todo
  (list
   "emacs-hl-todo"))
(define-public emacs-doom-module-ligatures
  (list
   "emacs-ligature"))

(define-public emacs-doom-module-modeline
  (list
   "emacs-doom-modeline"
   "emacs-anzu"
   "evil-anzu"))

(define-public emacs-doom-module-ophints
  (list
   "emacs-evil-goggles"
   "emacs-goggles"))

(define-public emacs-doom-module-smooth-scroll
  (list
   "emacs-ultra-scroll"
   "emacs-good-scroll"))

(define-public emacs-doom-module-unicode
  (list
   "emacs-unicode-fonts"))

(define-public emacs-doom-module-vc-gutter
  (list
   "emacs-diff-hl"))

(define-public emacs-doom-module-vi-tilde-fringe
  (list
   "emacs-vi-tilde-fringe"))


(define-public emacs-doom-module-evil
  (list
   "emacs-evil"
   "emacs-evil-args"
   "emacs-evil-escape"
   "emacs-evil-exchange"
   "emacs-evil-indent-plus"
   "emacs-evil-lion"
   "emacs-evil-nerd-commenter"
   "emacs-evil-numbers"
   "emacs-evil-surround"
   "emacs-evil-traces"
   "emacs-evil-visualstar"
   "emacs-evil-collection"
   "emacs-evil-easymotion"
   "emacs-evil-embrace"
   "emacs-evil-snipe"
   "emacs-evil-textobj-anyblock"
   "emacs-exato"
   "emacs-evil-quick-diff"))

(define-public emacs-doom-module-format
  (list
   "emacs-apheleia"))

(define-public emacs-doom-module-snippets
  (list
   "emacs-auto-yasnippet"
   "emacs-doom-snippets"))

(define-public emacs-doom-module-whitespace
  (list
   "emacs-dtrt-indent"
   "emacs-ws-butler"))

(define-public emacs-doom-module-dired
  (list
   "emacs-dirvish"
   "emacs-diredfl"))

(define-public emacs-doom-module-ibuffer
  (list
   "emacs-ibuffer-projectile"
   "emacs-ibuffer-vc"))

(define-public emacs-doom-module-undo
  (list
   "emacs-undo-fu"
   "emacs-undo-fu-session"
   "emacs-vundo"))

(define-public emacs-doom-module-vterm
  (list
   "emacs-vterm"))

(define-public emacs-doom-module-eval
  (list
   "emacs-quickrun"
   "emacs-eros"))

(define-public emacs-doom-module-lookup
  (list
   "emacs-dumb-jump"
   "emacs-request"))

(define-public emacs-doom-module-magit
  (list
   "emacs-transient"
   "emacs-magit"))

(define-public emacs-doom-module-pass
  (list
   "emacs-pass"
   "emacs-password-store"
   "emacs-password-store-otp"))

(define-public emacs-doom-module-pdf
  (list
   "emasc-pdf-tools"
   "emasc-saveplace-pdf-view"))

(define-public emacs-doom-module-json
  (list
   "emacs-json-mode"
   "emacs-json-snatcher"))

(define-public emacs-doom-module-file-templates
  (list
   "emacs-diff-hl"))

(define-public emacs-doom-module-sh
  (list
   "emacs-bash-completion"))

(define-public emacs-doom-module-yaml
  (list
   "emacs-yaml-mode"))

(define-public emacs-doom-module-default
  (list
   "emacs-avy"
   "emacs-link-hint"))

(define-public emacs-exwm
  (list
   "emacs-exwm-transparent"
   "emacs-xdg-launcher"
   "emacs-exwm-modeline"
   "emacs-move-border"))

(define-public emacs-doom-module-magit
  (list
   "emacs-magit"))

(define-public emacs-doom-module-dired
  (list
   "emacs-dirvish"
   "emacs-diredfl"))
