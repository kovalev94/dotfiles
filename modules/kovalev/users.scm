(define-module (kovalev users)
  #:use-module (gnu system accounts)
  #:use-module (gnu system shadow)
  #:export (users))


(define users
  (cons*
   (user-account
    (name "kovalev")
    (comment "Виталий Ковалёв")
    (group "users")
    (home-directory "/home/kovalev")
    (supplementary-groups
     '("wheel" "netdev" "audio" "video" "kvm" "libvirt" "docker")))
   %base-user-accounts))
