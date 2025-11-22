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
   "xdg-utils"))

(define-public fs-tools
  (list
   "lvm2"
   "parted"))

(define-public network-tools
  (list
   "tcpdump"
   "wireguard-tools"
   "nmap"
   "iputils"
   "iptables"
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
   "emacs-dashboard"
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
   "python-nose"
   "python-pipenv"
   "python-lsp-server"))

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
    "nyxt"
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
