(define-module (guix-config channels)
  #:use-module (guix channels)
  #:export (%nonguix-channel
            rosenthal-channel
            %my-channels
            %my-pinned-channels)
  #:re-export (%default-guix-channel))


(define %nonguix-channel
  (channel
    (name 'nonguix)
    (url "https://gitlab.com/nonguix/nonguix")
    ;; Enable signature verification:
    (introduction
     (make-channel-introduction
      "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
      (openpgp-fingerprint
       "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5")))))

(define rosenthal-channel
  (channel
    (name 'rosenthal)
    (url "https://codeberg.org/hako/rosenthal.git")
    (branch "trunk")
    (introduction
     (make-channel-introduction
      "7677db76330121a901604dfbad19077893865f35"
      (openpgp-fingerprint
       "13E7 6CD6 E649 C28C 3385  4DF5 5E5A A665 6149 17F7")))))

(define %my-channels
  (list
   %default-guix-channel
   %nonguix-channel
   rosenthal-channel))

(define %my-pinned-channels
  (list (channel
          (inherit %default-guix-channel)
          (commit
           "5e63c9bdb1bf7114d742ba4c07596932e0124188"))
        (channel
          (inherit %nonguix-channel)
          (commit
           "0f68c1684169cbef8824fb246dfefa3e6832225b"))))
