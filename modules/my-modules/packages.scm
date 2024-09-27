(define-module (my-modules packages)
  #:use-module (gnu system)
  #:use-module (gnu packages)
  #:export (system-packages))


(define system-utils
  (list
   "htop"
   "lvm2"
   "bluez"
   "spice-gtk"
   "screen"))

(define network-utils
  (list
   "tcpdump"
   "nmap"
   "iputils"
   "curl"
   "wireguard-tools"
   "vpnc"))

(define base-toolkit
  (list
   "python"
   "xterm"
   "firefox"
   "vim"
   "mc"
   "unzip"
   "git"))

(define base-gui
  (list
   "herbstluftwm"
   "polybar"
   "dmenu"
   "picom"
   "pavucontrol"
   "feh"
   "xrandr"
   "xinput"
   "xrdb"
   "font-gnu-freefont"
   "xdg-utils"))

(define system-packages
  (append
   (map specification->package
        (append
         system-utils
         network-utils
         base-toolkit
         base-gui))
   %base-packages))
