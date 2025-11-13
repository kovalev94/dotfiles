(define-module (guix-config systems guix-installer)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (gnu system install)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu services base)
  #:use-module (gnu packages package-management)
  #:use-module (nongnu packages linux)

  #:use-module (guix-config package-sets)
  #:use-module (guix-config services)
  #:use-module (guix-config keyboard))


(define-public guix-installer-system
  (operating-system
   (inherit installation-os)

   (host-name "guix-installer")
   (locale "ru_RU.utf8")
   (timezone "Asia/Novosibirsk")

   (bootloader
    (bootloader-configuration
     (bootloader grub-bootloader)
     (targets '("/dev/sda"))
     (keyboard-layout kb-layout)))

   (firmware
    (list
     linux-firmware
     sof-firmware))

   (keyboard-layout kb-layout)

   (packages
    (append
     base-sys
     fs-tools
     network-tools
     (operating-system-packages installation-os)))

   (services
     (modify-services (operating-system-user-services installation-os)
       (guix-service-type
        config =>(guix-configuration
                  (inherit config)
                  (channels pinned-channels)
                  (guix (guix-for-channels pinned-channels))
                  (substitute-urls bordeaux-nonguix-substitute-urls)
                  (authorized-keys default-authorized-keys-with-nonguix)))))))


guix-installer-system
