(define-module (kovalev package-lists kovalev)
  #:use-module (gnu packages emacs)
  #:use-module (gnu packages emacs-xyz)
  #:use-module (gnu packages node)
  #:use-module (gnu packages haskell-apps)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages cpp)
  #:use-module (gnu packages check)
  #:use-module (gnu packages markup)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages chromium)
  #:use-module (gnu packages web-browsers)
  #:use-module (gnu packages bittorrent)
  #:use-module (gnu packages video)
  #:use-module (gnu packages kde)
  #:use-module (gnu packages virtualization)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages engineering)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages llvm)
  #:use-module (gnu packages sync)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages libreoffice)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages telegram)

  #:export (emacs-stuff
            fonts
            www
            video
            virtualization
            tools
            work
            all))


(define emacs-stuff
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

(define fonts
  (list
   font-fira-mono
   font-fira-sans
   font-fira-code
   font-google-noto-emoji
   font-gnu-unifont))

(define www
  (list
   ungoogled-chromium
   nyxt
   ;telegram-desktop
   qbittorrent))

(define video
  (list
   vlc
   obs
   kdenlive))

(define virtualization
  (list
   virt-manager
   spice-gtk))

(define tools
  (list
   minicom
   lrzsz
   sshfs
   rclone
   fping
   wireshark
   imagemagick
   brightnessctl
   keepassxc
   pulsemixer))

(define work
  (list
   libreoffice
   alacritty
   dia))

(define all
  (append
   emacs-stuff
   fonts
   www
   video
   virtualization
   tools
   work))
