(use-modules (gnu)
             (gnu services networking)
             (gnu services desktop)
             (gnu services ssh)
             (gnu packages package-management)
             (nongnu system install)
             (nongnu system linux-initrd)
             (nongnu packages linux)
             ((kovalev package-lists mirage) #:prefix mirage-packages:)
             ((kovalev package-lists kovalev) #:prefix kovalev-packages:)
             (kovalev services)
             (kovalev keyboard)
             ((srfi srfi-1) #:prefix srfi-1:))


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
              (ipv4-rules (local-file "iptables.rules"))
              (ipv6-rules (local-file "iptables.rules")))))

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
                                        (authorized-keys default-authorized-keys-with-nonguix)))))))
