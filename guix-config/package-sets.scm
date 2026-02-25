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
   "emacs-eat"
   "emacs-docker"
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

(define-public emacs-exwm
  (list
   "emacs-exwm-transparent"
   "emacs-xdg-launcher"
   "emacs-exwm-modeline-next"
   "emacs-move-border"))
