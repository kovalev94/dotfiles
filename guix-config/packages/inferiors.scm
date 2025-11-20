(define-module (guix-config packages inferiors)
  #:use-module (gnu)
  #:use-module (guix inferior)
  #:use-module (guix channels)
  #:use-module (srfi srfi-1))


;;(define guix-channel-nyxt-commit
;;  (list (channel
;;         (name 'guix)
;;         (url "https://git.guix.gnu.org/guix.git")
;;         (commit
;;          "83e39340eaa416c1fd6a96f0aa95d907af27a05f")
;;         (introduction
;;          (make-channel-introduction
;;           "9edb3f66fd807b096b48283debdcddccfea34bad"
;;           (openpgp-fingerprint
;;            "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))))
;;
;;
;;(define-public nyxt-inferior
;;  (first
;;   (lookup-inferior-packages
;;    (inferior-for-channels guix-channel-nyxt-commit)
;;    "nyxt")))
