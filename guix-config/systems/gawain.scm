(define-module (guix-config systems gawain)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (gnu services base)
  #:use-module (gnu services networking)
  #:use-module (gnu system)
  #:use-module (gnu system pam)
  #:use-module (gnu system shadow)
  #:use-module (guix-config channels)
  #:use-module (guix-config packages certs)
  #:use-module (guix-config systems desktop)
  #:export (gawain-system))


(define gawain-system
  (operating-system
    (inherit %my-desktop-system)
    (host-name "gawain")

    (users
     (cons*
      (user-account
        (name "vitaliy.kovalev")
        (comment "Виталий Ковалёв")
        (uid 1000)
        (group "users")
        (home-directory "/home/vitaliy.kovalev")
        (supplementary-groups
         '("wheel" "netdev" "audio" "video" "kvm" "libvirt" "cgroup")))
      %base-user-accounts))

    (packages
     (cons*
      eltex-certs
      (operating-system-packages %my-desktop-system)))

    (services
     (append
      (list
       (simple-service 'my-env session-environment-service-type
                       `(("DOTFILES_DIR" .
                          "/home/vitaliy.kovalev/.dotfiles")
                         ("TZ" .
                          ,(operating-system-timezone %my-desktop-system))
                         ("GUIX_PACKAGE_PATH" .
                          "/home/vitaliy.kovalev/.dotfiles"))));; add dynamic behavior
      (modify-services (operating-system-user-services %my-desktop-system)
        (openssh-service-type
         config => (openssh-configuration
                     (extra-content "PermitTunnel yes")))
        (nftables-service-type
         config => (nftables-configuration
                     (ruleset
                      (local-file
                       (string-append
                        %distro-root-directory
                        "/sys-files/gawain/nftables/rules"))))))))));; add dynamic behavior


gawain-system
