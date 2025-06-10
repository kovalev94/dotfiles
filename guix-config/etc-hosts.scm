(define-module (guix-config etc-hosts)
  #:use-module (gnu services base)
  #:export (personal-machines
            ipoint))


(define personal-machines
  (list
  ;; Orange Pi R1+ LTS
  (host "185.169.107.235" "vpnserv")
  (host "213.87.105.213" "damocles")
  (host "172.16.13.3" "lancelot")
  ;; Mikrotik Hex RB760igs - home router
  (host "172.16.13.5" "gawain")))

(define ipoint
  (list
  ;; iPoint marksa
  (host "109.174.98.182" "ipoint-marksa-white")
  (host "10.10.113.3" "ipoint-marksa-vpn")
  ;; iPoint gogolya
  (host "109.111.191.225" "ipoint-gogolya-white")
  (host "10.10.113.4" "ipoint-gogolya-vpn")
  ;; iPoint gogolya
  (host "10.10.113.2" "ipoint-office-vpn")
  ;; iPoint unifi controller
  (host "176.126.103.60" "ipoint-controller-white")
  (host "10.10.113.1" "ipoint-controller-vpn")))
