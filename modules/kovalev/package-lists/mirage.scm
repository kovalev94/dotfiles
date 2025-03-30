(define-module (kovalev package-lists mirage)
  #:use-module (gnu system)
  #:use-module (gnu packages)
  #:export (system-utils
            network-utils
            base-toolkit
            base-gui
            all))


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
   "iptables"
   "whois"
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


(define all
  (append
   system-utils
   network-utils
   base-toolkit
   base-gui))
