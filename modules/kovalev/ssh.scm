(define-module (kovalev ssh)
  #:use-module (gnu home services ssh)
  #:export (personal-servers
            ipoint
            akadem))


(define personal-servers
  (list
   ;; VPN server
   (openssh-host
    (name "vpnserv")
    (host-name "vpn.web-wyrd.space")
    (user "vpn_admin")
    (port 56713)
    (identity-file "~/.ssh/keys/vpnserv"))
   ;; Orange Pi R1+ LTS
   (openssh-host
    (name "lancelot")
    (host-name "lancelot")
    (user "suzaku")
    (port 57133)
    (identity-file "~/.ssh/keys/lancelot"))
   ;; Mikrotik Hex RB760igs - home router
   (openssh-host
    (name "gawain")
    (host-name "gawain")
    (user "lanadmin")
    (port 57133)
    (identity-file "~/.ssh/keys/gawain"))
   ;; Syncting and knightmares wireguard
   (openssh-host
    (name "damocles")
    (host-name "damocles.web-wyrd.space")
    (user "schneizel")
    (port 53622)
    (identity-file "~/.ssh/keys/damocles"))))

(define ipoint
  (list
   (openssh-host
    (name "ipoint-*")
    (port 57655)
    (user "lanadmin")
    (identity-file "~/.ssh/keys/ipoint"))))

(define akadem
  (list
   (openssh-host
    (name "breadrobot")
    (user "breadrobot"))
   (openssh-host
    (name "orangepi3")
    (user "admin"))))
