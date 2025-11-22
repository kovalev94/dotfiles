(define-module (guix-config package-sets)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages disk)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages dns)
  #:use-module (gnu packages vpn)
  #:use-module (gnu packages screen)
  #:use-module (gnu packages python)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages mc)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages mail)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages libreoffice)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages image)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages compton)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages image-viewers)
  #:use-module (gnu packages freedesktop)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages node)
  #:use-module (gnu packages haskell-apps)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages check)
  #:use-module (gnu packages markup)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages web-browsers)
  #:use-module (gnu packages video)
  #:use-module (gnu packages kde-multimedia)
  #:use-module (gnu packages virtualization)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages engineering)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages telegram)
  #:use-module (gnu packages golang)
  #:use-module (gnu packages golang-xyz)
  #:use-module (gnu packages golang-apps)
  #:use-module (gnu packages shellutils)
  #:use-module (nongnu packages mozilla)
  #:use-module (nongnu packages fonts)
  #:use-module (guix-config packages emacs)
  #:use-module (guix-config packages fonts)
  #:use-module (guix-config packages python-xyz)
  #:use-module (guix-config packages golang-xyz))


(define-public base-sys
  (list
   htop
   screen
   python
   mc
   vim
   minicom
   ;;lrzsz
   unzip
   zip
   p7zip
   git))

(define-public laptop
  (list
   bluez
   tlp))

(define-public base-gui
  (list
   flameshot
   picom
   pavucontrol
   feh
   xrandr
   xinput
   xrdb
   imagemagick
   libreoffice
   firefox
   vlc
   xdg-utils))

(define-public fs-tools
  (list
   lvm2
   parted))

(define-public network-tools
  (list
   tcpdump
   wireguard-tools
   nmap
   iputils
   iptables
   whois
   fping
   sshfs
   curl
   (list isc-bind "utils")))

(define-public video-tools
  (list
   obs
   kdenlive))

(define-public emacs-base
  (list
   emacs-transparent
   emacs-rg
   ripgrep
   emacs-pdf-tools
   emacs-vterm
   libvterm
   markdown
   shellcheck
   shfmt
   font-nerd-symbols-only
   emacs-dashboard
   fd))

(define-public mail-emacs
  (list
   mu
   isync))

(define-public python-emacs
  (list
   python
   python-black
   python-isort
   python-pytest
   python-pyflakes
   python-nose
   python-pipenv
   python-lsp-server))

(define-public golang-emacs
  (list
   go
   gopls
   gore
   go-github-com-cweill-gotests
   go-github-com-fatih-gomodifytags-next))

(define-public virtualization-base
  (list
   virt-manager
   spice-gtk))

(define-public sys-fonts
  (list
   font-gnu-freefont
   font-gnu-unifont))

(define-public fira-code-fonts
  (list
   font-fira-mono
   font-fira-sans
   font-fira-code))

(define-public polybar-fonts
  (list
   font-ubuntu
   font-google-noto-emoji
   font-awesome
   font-awesome-nonfree))

(define-public herbst-de
  (append
   polybar-fonts
   fira-code-fonts
   (list
    herbstluftwm
    alacritty
    nyxt
    polybar
    dunst
    rofi
    rofi-pass
    password-store
    gnupg
    dzen
    xftwidth
    brightnessctl
    pulsemixer)))
