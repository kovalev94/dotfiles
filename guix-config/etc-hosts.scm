(define-module (guix-config etc-hosts)
  #:use-module (gnu services base)
  #:export (vpn-servers
            personal-machines
            work-machines
            ipoint))


(define vpn-servers
  (list
   (host "185.164.163.16" "vpnserv")
   (host "185.216.87.176" "vpnserv2")))


(define personal-machines
  (list
   (host "213.87.105.213" "damocles")
   (host "172.16.13.3" "lancelot")))

(define work-machines
  (list
   (host "192.168.114.175" "gawain.tester.uc")
   (host "10.30.101.84" "gawain.eltex.loc")
   (host "172.16.113.0" "mes.kovalev.tester.uc")))

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
