(define-module (my-modules hosts other)
  #:use-module (gnu services base)
  #:export (other-hosts))


(define ipoint
  (list
  ;; iPoint marksa
  (host "109.174.98.182" "ipoint-marksa")
  ;; iPoint gogolya
  (host "109.111.191.225" "ipoint-gogolya")
  ;; iPoint office controller
  (host "176.126.103.60" "ipoint-controller")))

(define akadem
  (list
   ;; Kiosk for bread
   (host "192.168.114.11" "breadrobot")
   ;; Targets Soft
   (host "192.168.114.17" "orangepi3")))


(define other-hosts
  (append
   ipoint
   akadem))
