(define-module (my-modules packages system mirage)
  #:use-module (gnu system)
  #:use-module (gnu packages)
  #:export (system-packages))


(define system-utils
  (list
   "glibc"
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
   "bind:utils"
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
   "zip"
   "p7zip"
   "git"))

(define base-gui
  (list
   "herbstluftwm"
   "polybar"
   "dzen"
   "xftwidth"
   "flameshot"
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
   (map (compose list specification->package+output)
        (append
         system-utils
         network-utils
         base-toolkit
         base-gui))
   %base-packages))
