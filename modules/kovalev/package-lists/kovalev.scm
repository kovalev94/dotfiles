(define-module (kovalev package-lists kovalev)
  #:use-module (gnu system)
  #:use-module (gnu packages)
  #:export (emacs-stuff
            fonts
            www
            video
            virtualization
            tools
            work))

(define emacs-stuff
  (list
   "emacs"
   "emacs-rg"
   "emacs-pdf-tools"
   "emacs-clang-format"
   "emacs-vterm"
   "node"
   "shellcheck"
   "python-black"
   "python-isort"
   "python-pytest"
   "python-pyflakes"
   "python-nose"
   "ccls"
   "markdown"
   "libvterm"
   "ripgrep"
   "fd"))

(define fonts
  (list
   "font-fira-mono"
   "font-fira-sans"
   "font-fira-code"
   "font-google-noto-emoji"
   "font-gnu-unifont"))

(define www
  (list
   "ungoogled-chromium"
   "nyxt"
   "telegram-desktop"
   "qbittorrent"))

(define video
  (list
   "vlc"
   "obs"
   "kdenlive"))

(define virtualization
  (list
   "virt-manager"
   "docker-compose"))

(define tools
  (list
   "minicom"
   "lrzsz"
   "sshfs"
   "rclone"
   "fping"
   "wireshark"
   "imagemagick"
   "pulsemixer"))

(define work
  (list
   "libreoffice"
   "alacritty"
   "dia"))
