(define-module (guix-config packages)
  #:use-module (gnu)
  #:use-module (nongnu packages mozilla)
  #:use-module (nongnu packages chrome)
  #:use-module (nongnu packages fonts)
  #:use-module (guix-config packages telephony)
  #:use-module (guix-config packages emacs)
  #:use-module (guix-config packages emacs-xyz)
  #:use-module (guix-config packages fonts)
  #:use-module (guix-config packages python-xyz)
  #:use-module (guix-config packages golang-xyz)
  #:use-module (guix-config packages guix-config)
  #:export (%my-base-packages
            %my-desktop-packages
            %my-emacs-packages))


(use-package-modules admin vpn networking linux curl dns
                     telephony disk compression python
                     screen engineering mc vim version-control
                     web video password-utils gnupg fonts
                     libreoffice chromium image tex
                     kde-multimedia audio linphone wm
                     compton pulseaudio image-viewers xorg
                     imagemagick freedesktop xdisorg ssh
                     terminals virtualization spice emacs-xyz
                     rust-apps markup haskell-apps shellutils
                     mail python-xyz check python-check
                     golang golang-apps)


(define-public %my-base-packages
  (list
   ;; Networking
   tcpdump wireguard-tools nmap netcat
   iputils nftables whois fping sshfs
   curl (list isc-bind "utils") sngrep
   sipp arp-scan
   ;; File-system
   lvm2 parted
   ;; Archive
   unzip zip 7zip
   ;; General
   python htop screen minicom guix-config-tool
   ;;lrzsz
   mc vim git jq ffmpeg password-store
   python gnupg bluez
   ;; Fonts
   font-gnu-freefont font-gnu-unifont))

(define-public %my-desktop-packages
  (list
   ;; Office
   libreoffice
   ;; Browsers
   firefox
   ;;ungoogled-chromium - Disable while will not fix
   google-chrome-stable
   ;; Video
   vlc obs kdenlive
   ;; VoIP
   wireshark audacity linphone-desktop
   ;; GUI
   herbstluftwm flameshot picom
   pavucontrol feh xrandr xinput xrdb
   imagemagick xdg-utils scrot
   x11-ssh-askpass alacritty polybar
   dunst rofi rofi-pass dzen xftwidth
   brightnessctl pulsemixer
   ;; Virtualization
   virt-manager spice-gtk
   ;; Fonts
   font-fira-mono font-fira-sans
   font-fira-code font-ubuntu
   font-google-noto-emoji
   font-awesome font-awesome-nonfree))

(define-public %my-emacs-packages
  (list
   ;; EXWM
   emacs-exwm-transparent emacs-xdg-launcher
   emacs-exwm-modeline-next emacs-move-border
   emacs-transparent
   ;; General
   emacs-rg ripgrep emacs-pdf-tools emacs-vterm
   libvterm emacs-eat emacs-docker markdown
   shellcheck shfmt font-nerd-symbols-only
   emacs-nerd-icons-completion emacs-dashboard
   emacs-org-texlive-collection texlive-xetex
   fd
   ;; Mail
   mu isync
   ;; Python IDE
   python-black python-isort python-pytest
   python-pyflakes python-pynose python-pipenv
   python-lsp-server
   ;; Ansible IDE
   ansible sshpass emacs-ansible
   ;; Golang IDE
   go gopls gore go-github-com-cweill-gotests
   go-github-com-fatih-gomodifytags-next))
