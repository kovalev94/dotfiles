(define-module (guix-config substitutes)
  #:use-module (gnu services base)
  #:use-module (guix gexp)
  #:export (%nonguix-authorized-keys
            %my-authorized-keys
            %my-substitutes-urls)
  #:re-export (%default-authorized-guix-keys))


(define %nonguix-authorized-keys
  (list
   (plain-file "non-guix.pub"
               "(public-key (ecc (curve Ed25519)
  (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))")))

(define %my-authorized-keys
  (append
   %default-authorized-guix-keys
   %nonguix-authorized-keys))

(define %my-substitutes-urls
  (list
   "https://bordeaux.guix.gnu.org"
   "https://substitutes.nonguix.org"))
