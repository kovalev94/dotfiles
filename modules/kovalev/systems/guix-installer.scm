(define-module (kovalev system guix-installer)
  #:use-module (gnu services networking)
  #:use-module (gnu services desktop)
  #:use-module (gnu services ssh)
  #:use-module (gnu packages package-management)
  #:use-module (nongnu system install)
  #:use-module (nongnu system linux-initrd)
  #:use-module (nongnu packages linux)
  #:use-module ((kovalev package-lists mirage) #:prefix mirage-packages:)
  #:use-module ((kovalev package-lists kovalev) #:prefix kovalev-packages:)
  #:use-module (kovalev services)
  #:use-module (kovalev keyboard)
  #:use-module ((srfi srfi-1) #:prefix srfi-1:))


(define-public guix-installer-system
  (operating-system
   (inherit installation-os-nonfree)

   (host-name "guix-installer-kovalev")
   (locale "ru_RU.utf8")
   (timezone "Asia/Novosibirsk")

   (bootloader
    (bootloader-configuration
     (bootloader grub-bootloader)
     (targets '("/dev/sda"))
     (keyboard-layout kb-layout)))

                                        ; For unknown for me reasons, it breaks booting
                                        ;(initrd microcode-initrd)

   (firmware
    (list
     linux-firmware
     sof-firmware))

   (keyboard-layout kb-layout)


   (packages
    (append
     (map (compose list specification->package+output)
          (append
           mirage-packages:all
           kovalev-packages:all))
     %base-packages))

   (services
    (append
     (list
      (service iptables-service-type
               (iptables-configuration
                (ipv4-rules (local-file "/home/kovalev/.guix-config/sys-files/iptables/guix-installer.rules"))
                (ipv6-rules (local-file "/home/kovalev/.guix-config/sys-files/iptables/guix-installer.rules")))))

     (modify-services (operating-system-user-services installation-os-nonfree)
                      (openssh-service-type config =>
                                            (openssh-configuration
                                             (inherit config)
                                             (port-number 13131)
                                             (%auto-start? #t)))
                      (guix-service-type _ =>
                                         (guix-configuration
                                          (channels default-channels-with-nonguix)
                                          (guix (guix-for-channels default-channels-with-nonguix))
                                          (substitute-urls bordeaux-nonguix-substitute-urls)
                                          (authorized-keys default-authorized-keys-with-nonguix))))))))


guix-installer-system
