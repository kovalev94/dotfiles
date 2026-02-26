(define-module (guix-config systems gawain)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages package-management)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (gnu services base)
  #:use-module (gnu services dbus)
  #:use-module (gnu services xorg)
  #:use-module (gnu services avahi)
  #:use-module (gnu services desktop)
  #:use-module (gnu services containers)
  #:use-module (gnu services networking)
  #:use-module (gnu services virtualization)
  #:use-module (gnu system)
  #:use-module (gnu system pam)
  #:use-module (gnu system shadow)
  #:use-module (gnu system accounts)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system privilege)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (nongnu packages linux)
  #:use-module (guix-config package-sets)
  #:use-module (guix-config channels)
  #:use-module (guix-config substitutes)
  #:use-module (guix-config common)
  #:use-module (guix-config packages certs)
  #:use-module (guix-config packages telephony)
  #:use-module (guix-config systems desktop)
  #:use-module (srfi srfi-1)
  #:export (gawain-system))
;;Clean imports

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
      (specification->package "eltex-certs")
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
                        (getenv "DOTFILES_DIR");;
                        "/sys-files/gawain/nftables/rules"))))))))));; add dynamic behavior


gawain-system
