(define-module (guix-config channels)
  #:use-module (guix channels)
  #:export (%distro-root-directory
            %this-channel
            %nonguix-channel
            rosenthal-channel
            %my-channels
            %my-pinned-channels)
  #:re-export (%default-guix-channel))


(define %distro-root-directory
  ;; Absolute file name of the module hierarchy.
  (dirname
   (dirname
    (search-path %load-path "guix-config/channels.scm"))))

(define %this-channel
  (channel
    (name 'dotfiles)
    (url "git@github.com:kovalev94/dotfiles.git")
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
