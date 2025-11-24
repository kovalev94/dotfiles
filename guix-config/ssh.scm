(define-module (guix-config ssh)
  #:use-module (gnu home services ssh)
  #:export (vpn-servers
            work-machines
            personal-machines
            my-version-control
            ipoint))


(define vpn-servers
  (list
   ;; VPN server
   (openssh-host
    (name "vpnserv")
    (host-name "vpnserv")
    (user "vpn_admin")
    (port 56713)
    (identity-file "~/.ssh/keys/vpnserv"))
   (openssh-host
    (name "vpnserv2")
    (host-name "vpnserv2")
    (user "vpn_admin")
    (port 56713)
    (identity-file "~/.ssh/keys/vpnserv2"))))

(define work-machines
  (list
   ;; Gawain Work PC
   (openssh-host
    (name "gawain")
    (host-name "gawain")
    (user "vitaliy.kovalev")
    (port 13131)
    (identity-file "~/.ssh/keys/gawain"))))

(define personal-machines
  (list
   ;; Orange Pi R1+ LTS
   (openssh-host
    (name "lancelot")
    (host-name "lancelot")
    (user "suzaku")
    (port 57133)
    (identity-file "~/.ssh/keys/lancelot"))
   ;; Syncting and knightmares wireguard
   (openssh-host
    (name "damocles")
    (host-name "damocles")
    (user "schneizel")
    (port 13131)
    (identity-file "~/.ssh/keys/knightmares"))))


(define my-version-control
  (list
   (openssh-host
    (name "github.com")
    (identity-file "~/.ssh/keys/github"))))

(define ipoint
  (list
   (openssh-host
    (name "ipoint-*")
    (port 57655)
    (user "lanadmin")
    (identity-file "~/.ssh/keys/ipoint"))))
