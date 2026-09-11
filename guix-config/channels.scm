(define-module (guix-config channels)
  #:use-module (gnu services base)
  #:use-module (guix gexp)
  #:use-module (guix channels)
  #:export (%distro-root-directory
            %this-channel
            %nonguix-channel
            rosenthal-channel
            %my-channels
            %my-pinned-channels
            %nonguix-authorized-keys
            %guix-moe-authorized-keys
            %my-authorized-keys
            %my-substitutes-urls)
  #:re-export (%default-guix-channel
               %default-authorized-guix-keys))


(define %distro-root-directory
  ;; Absolute file name of the module hierarchy.
  (dirname
   (dirname
    (search-path %load-path "guix-config/channels.scm"))))

(define %this-channel
  (channel
    (name 'dotfiles)
    (url "https://github.com/kovalev94/dotfiles.git")
    (branch "main")))

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

(define %nonguix-authorized-keys
  (list
   (plain-file "non-guix.pub"
               "(public-key (ecc (curve Ed25519)
  (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))")))

(define %guix-moe-authorized-keys
  (list
   (plain-file "guix-moe-old.pub"
               "(public-key (ecc (curve Ed25519)
(q #374EC58F5F2EC0412431723AF2D527AD626B049D657B5633AAAEBC694F3E33F9#)))")
   ;; New key since 2025-10-29.
   (plain-file "guix-moe.pub"
               "(public-key (ecc (curve Ed25519)
(q #552F670D5005D7EB6ACF05284A1066E52156B51D75DE3EBD3030CD046675D543#)))")))

(define %my-authorized-keys
  (append
   %default-authorized-guix-keys
   %nonguix-authorized-keys
   %guix-moe-authorized-keys))

(define %my-channels
  (list
   %default-guix-channel
   %nonguix-channel
   %this-channel
   rosenthal-channel))

(define %my-pinned-channels
  (list (channel
          (inherit %default-guix-channel)
          (commit
           "b383c0ece5501f3f0d75cbb530cedf5141e011ca"))
        (channel
          (inherit %nonguix-channel)
          (commit
           "48a8706d44040cc7014f36873dbd834c048aadd3"))
        %this-channel
        (channel
          (inherit rosenthal-channel)
          (commit
           "128c21d11adb015793a7bc895cbe15ef7aef39c7"))))

(define %my-substitutes-urls
  (list
   "https://bordeaux.guix.gnu.org"
   "https://nonguix-proxy.ditigal.xyz"
   "https://cache-cdn.guix.moe"))
