(define-module (kovalev package-lists mirage)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages disk)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages curl)
  #:use-module (gnu packages dns)
  #:use-module (gnu packages vpn)
  #:use-module (gnu packages screen)
  #:use-module (gnu packages python)
  #:use-module (gnu packages xorg)
  #:use-module (gnu packages vim)
  #:use-module (gnu packages mc)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages version-control)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages xdisorg)
  #:use-module (gnu packages image)
  #:use-module (gnu packages suckless)
  #:use-module (gnu packages compton)
  #:use-module (gnu packages pulseaudio)
  #:use-module (gnu packages image-viewers)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages freedesktop)
  #:use-module (nongnu packages mozilla)

  #:export (fs-utils
            network-utils
            base-toolkit
            base-gui
            all))


(define fs-utils
  (list
   lvm2
   parted))

(define network-utils
  (list
   tcpdump
   nmap
   iputils
   iptables
   whois
   curl
   '(bind "utils")
   wireguard-tools
   vpnc))

(define base-toolkit
  (list
   htop
   bluez
   screen
   python
   xterm
   firefox
   vim
   mc
   unzip
   zip
   p7zip
   git))

(define base-gui
  (list
   herbstluftwm
   polybar
   dzen
   xftwidth
   flameshot
   dmenu
   picom
   pavucontrol
   feh
   xrandr
   xinput
   xrdb
   font-gnu-freefont
   xdg-utils))


(define all
  (append
   fs-utils
   system-utils
   network-utils
   base-toolkit
   base-gui))
