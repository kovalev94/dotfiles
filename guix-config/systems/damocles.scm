(define-module (guix-config systems damocles)
  #:use-module (guix gexp)
  #:use-module (gnu system)
  #:use-module (gnu system pam)
  #:use-module (gnu system shadow)
  #:use-module (gnu system privilege)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system linux-initrd)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (gnu services guix)
  #:use-module (gnu services base)
  #:use-module (gnu services networking)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages package-management)
  #:use-module (guix-config package-lists)
  #:use-module (guix-config services)
  #:use-module (guix-config keyboard)
  #:use-module (guix-config homes schneizel))

(define-public damocles-system
  (operating-system
   (host-name "damocles")
   (timezone "Asia/Novosibirsk")
   (locale "ru_RU.utf8")

   (bootloader
    (bootloader-configuration
     (bootloader grub-bootloader)
     (targets '("/dev/sda"))
     (keyboard-layout kb-layout)))

   (initrd-modules
    (cons "virtio_scsi" %base-initrd-modules))


   (keyboard-layout kb-layout)


   (users
    (cons*
     (user-account
      (name "schneizel")
      (group "users")
      (home-directory "/home/schneizel")
      (supplementary-groups '("wheel" "netdev"
                              "audio" "video")))
     %base-user-accounts))

   ;Globaly installed packages(e.g. for all users)
   (packages
    (append
     base-sys-toolkit
     fs-tools
     network-tools
     sys-fonts
     %base-packages))

   ;Installed and enabled services(like ssh-server,docker, etc.)
   (services
    (append
     (list
      (service guix-home-service-type
            `(("schneizel" ,schneizel-home)))
      (service static-networking-service-type
               (list
                (static-networking
                 (addresses
                  (list (network-address
                         (device "eth0")
                         (value "10.220.120.11/25"))))
                (routes
                 (list (network-route
                        (destination "default")
                        (gateway "10.220.120.1"))))
                (name-servers '("8.8.8.8")))))
      (service iptables-service-type
               (iptables-configuration
                (ipv4-rules
                 (local-file
                  (string-append
                   (getenv "DOTFILES_DIR")
                   "/sys-files/iptables/damocles.rules")))
                (ipv6-rules
                 (local-file
                  (string-append
                   (getenv "DOTFILES_DIR")
                   "/sys-files/iptables/damocles.rules")))))
      (simple-service 'dotfiles-and-guix-env session-environment-service-type
                     `(("DOTFILES_DIR" .
                        "/home/kovalev/.dotfiles")
                       ("GUIX_PACKAGE_PATH" .
                        "/home/kovalev/.dotfiles")))
      ;(service wireguard-service-type
      ;         (wireguard-configuration
      ;          (interface "knightmares")
      ;          (adresses '("172.16.13.1/27"))
      ;          (port 51833)
      ;          (private-key
      ;           #~(string-append "<("
      ;                            #$(file-append password-store "/bin/pass")
      ;             " Damocles/WireGuard/private-keys/%i)"))
      ;          (bootstrap-private-key? #f)
      ;          (peers
      ;           (list
      ;            (wireguard-peer
      ;             (name "ipoint-test")
      ;             (public-key "8f/vqKnyFNXV97tgJknBYd2YUt9WgSVxRaiQ2ngAnDQ=")
      ;             (allowed-ips '("172.16.13.2/32"
      ;                            "192.168.110.0/23"
      ;                            "192.168.112.0/23"
      ;                            "192.168.114.0/23"))
      ;             (keep-alive #t))))))

      (service openssh-service-type
               (openssh-configuration
                (password-authentication? #f)
                (port-number 13131))))

     (modify-services %base-services
       (guix-service-type
        config =>(guix-configuration
                  (inherit config)
                  (channels default-channels-with-nonguix)
                  (guix (guix-for-channels default-channels-with-nonguix))
                  (substitute-urls bordeaux-nonguix-substitute-urls)
                  (authorized-keys default-authorized-keys-with-nonguix))))))

   (privileged-programs
    (append
     (cons*
      (privileged-program
       (program
        (file-append iputils "/bin/ping"));Neeeded for iptuils ping
       (setuid? #t))
     %default-privileged-programs)))

   (file-systems
    (cons*
     (file-system
      (mount-point "/")
      (device "/dev/sda1")
      (type "ext4"))
     %base-file-systems))

   (swap-devices
    (list
     (swap-space
      (target (file-system-label "swap")))))))


damocles-system
