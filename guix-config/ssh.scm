(define-module (guix-config ssh)
  #:use-module (gnu home services ssh)
  #:export (personal-servers
            ipoint-whites
            ipoint-lan
            akadem
            spd-servers
            spd-routers
            xring-servers
            xring-routers
            xring-general
            mts-gitlab
            general))


(define personal-servers
  (list
   ;; VPN server
   (openssh-host
    (name "vpnserv")
    (host-name "vpnserv")
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
    (host-name "damocles")
    (user "schneizel")
    (port 13131)
    (identity-file "~/.ssh/keys/knightmares"))))

(define ipoint-whites
  (list
   (openssh-host
    (name "ipoint-*")
    (port 57655)
    (user "lanadmin")
    (identity-file "~/.ssh/keys/ipoint"))))

(define ipoint-lan
  (list
   (openssh-host
    (name "*.ipoint-lan")
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


(define spd-servers
  (list
   (openssh-host
    (name "glue")
    (host-name "gluenew.mtu.ru")
    (user "vpkoval4")
    (identity-file "~/.ssh/keys/glue"))))


(define spd-routers
  (list
   (openssh-host
    (name "*.mts-internet.net")
    (user "+vpkoval4")
    (host-key-algorithms '("+ssh-rsa"))
    (extra-content
     "  KexAlgorithms=+diffie-hellman-group1-sha1
  Ciphers=+aes256-cbc"))))


(define xring-servers
  (list
   (openssh-host
    (name "my_vm")
    (host-name "srv-vpkoval4"))

   (openssh-host
    (name "dmiis-telemetry-04.servers.xring")
    (proxy
     (proxy-command
      "ssh -W \"[`getent hosts %h | awk '{print $1}'`]:%p\" glue")))

   (openssh-host
    (name "dmiis-telemetry-05 dmiis-telemetry-05.servers.xring")
    (user "vpkoval4")
    (host-name "10.112.17.139")
    (proxy
     (list
      (proxy-jump
       (host-name "dmiis-telemetry-04")))))

   (openssh-host
    (name "telemetry-bbn-test.servers.xring")
    (proxy
     (proxy-command
      "ssh -W \"[`getent hosts %h | awk '{print $1}'`]:%p\" glue")))

   (openssh-host
    (name "vmx?.routers.xring vmx10.routers.xring")
    (user "root")
    (proxy
     (proxy-command
      "ssh -W \"[`getent hosts %h | awk '{print $1}'`]:%p\" dmiis-telemetry-04")))

   (openssh-host
    (name "*.servers.xring")
    (identity-file "~/.ssh/keys/xring-servs")
    (proxy
     (proxy-command
      "ssh -W \"[`getent hosts %h | awk '{print $1}'`]:%p\" dmiis-telemetry-04")))))


(define xring-routers
  (list
   (openssh-host
    (name "10.249.*")
    (user "vpkoval4"))

   (openssh-host
    (name "*.routers.xring")
    (user "vpkoval4"))))


(define xring-general
  (list
   (openssh-host
    (name "*.xring")
    (user "vpkoval4"))))


(define mts-gitlab
  (list
   (openssh-host
    (name "gitlab.services.mts.ru")
    (user "vpkoval4")
    (identity-file "~/.ssh/keys/gitlab")
    (proxy
     (list
      (proxy-jump
       (host-name "dmiis-telemetry-04")))))))


(define general
  (list
   (openssh-host
    (match-criteria "all")
    (extra-content
     "  CanonicalizeHostname always
  CanonicalDomains mts-internet.net routers.xring servers.xring
  CanonicalizeMaxDots 3"))))
