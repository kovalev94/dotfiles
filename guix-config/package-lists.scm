(define-module (guix-config package-lists)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages disk)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages dns)
  #:use-module (gnu packages screen)
  #:use-module (gnu packages python)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages mc)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages compression)
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
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages check)
  #:use-module (gnu packages markup)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages web-browsers)
  #:use-module (gnu packages video)
  #:use-module (gnu packages kde)
  #:use-module (gnu packages virtualization)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages engineering)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages telegram)
  #:use-module (nongnu packages mozilla)

  #:export (base-sys-toolkit
            base-gui-toolkit
            tiled-wm-toolkit
            emacs-toolkit
            fs-tools
            network-tools
            video-tools
            virtualization-tools
            sys-fonts))


(define base-sys-toolkit
  (list
   htop
   screen
   python
   mc
   vim
   minicom
   lrzsz
   unzip
   zip
   p7zip
   git))

(define base-gui-toolkit
  (list
   flameshot
   picom
   pavucontrol
   feh
   xrandr
   xinput
   xrdb
   xterm
   firefox
   xdg-utils))

(define tiled-wm-toolkit
  (list
   polybar
   dmenu
   dzen
   xftwidth
   brightnessctl
   pulsemixer))

(define emacs-toolkit
  (list
   emacs
   emacs-rg
   emacs-pdf-tools
   emacs-clang-format
   emacs-vterm
   node
   shellcheck
   python-black
   python-isort
   python-pytest
   python-pyflakes
   python-nose
   ccls
   markdown
   libvterm
   ripgrep
   fd))

(define fs-tools
  (list
   lvm2
   parted))

(define network-tools
  (list
   tcpdump
   nmap
   iputils
   iptables
   whois
   fping
   sshfs
   curl
   (list isc-bind "utils")))

(define video-tools
  (list
   vlc
   obs
   kdenlive))

(define virtualization-tools
  (list
   virt-manager
   spice-gtk))

(define sys-fonts
  (list
   font-gnu-freefont
   font-gnu-unifont))
