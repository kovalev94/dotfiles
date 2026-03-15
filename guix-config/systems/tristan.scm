(define-module (guix-config systems tristan)
  #:use-module (gnu)
  #:use-module (gnu bootloader u-boot)
  #:use-module (gnu packages base)
  #:use-module (gnu packages linux)
  #:use-module (gnu services ssh)
  #:use-module (gnu services guix)
  #:use-module (gnu services linux)
  #:use-module (gnu services admin)
  #:use-module (gnu services networking)
  #:use-module (nongnu packages linux)
  #:use-module (guix-config packages linux)
  #:use-module (guix-config systems base)
  #:use-module (guix-config homes gino)
  #:export (tristan-system))


(define tristan-root-filesystem
  (file-system
    (mount-point "/")
    (device (file-system-label "Root"))
    (type "ext4")
    (options "compress=zstd:3,noatime,discard")))

(define tristan-system
  (operating-system
    (inherit %my-base-system)
    (host-name "tristan")

    (bootloader
      (bootloader-configuration
        (bootloader
          u-boot-orangepi-r1-plus-lts-rk3328-bootloader)
        (targets '("/dev/mmcblk0"))))

    (kernel linux-arm64-full-nonguix)
    (initrd-modules '("btrfs"))

    (users
     (cons*
      (user-account
        (name "gino")
        (comment "Джино Вайнберг")
        (uid 1000)
        (group "users")
        (home-directory "/home/gino")
        (supplementary-groups
         '("wheel" "netdev" "audio" "video" "kvm")))
      %base-user-accounts))

    (packages (cons* btrfs-progs
                     (operating-system-packages %my-base-system)))

    (services
     (cons*
      (service guix-home-service-type
               (list (list
                      (user-account-name
                       (car users))
                      gino-home)))
      (service zram-device-service-type
               (zram-device-configuration
                 (compression-algorithm 'zstd)))
      (service static-networking-service-type
               (list
                (static-networking
                  (addresses
                   (list
                    (network-address
                      (device "eth1")
                      (value "192.168.13.1/24")))))))
      (service dhcpd-service-type
               (dhcpd-configuration
                 (interfaces '("eth0"))
                 (config-file
                  (local-file
                   (string-append
                    (getenv "DOTFILES_DIR");;
                    "/sys-files/tristan/dhcpd/dhcpd.conf")))));; add dynamic behavior
      (modify-services (operating-system-user-services %my-base-system)
        (delete network-manager-service-type)
        (openssh-service-type
         config => (openssh-configuration
                     (port-number 13131)))
        (nftables-service-type
         config => (nftables-configuration
                     (ruleset
                      (local-file
                       (string-append
                        (getenv "DOTFILES_DIR");;
                        "/sys-files/tristan/nftables/rules"))))))));; add dynamic behavior

    (mapped-devices '())

    (file-systems (cons*
                   tristan-root-filesystem
                   %base-file-systems))

    (swap-devices
     (list (swap-space
             (target
              (file-system-label "Swap"))
             (priority 1))))))


tristan-system
