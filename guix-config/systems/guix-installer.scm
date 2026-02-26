(define-module (guix-config systems guix-installer)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (gnu system install)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu services base)
  #:use-module (gnu packages package-management)
  #:use-module (nongnu packages linux)
  #:use-module (guix-config channels)
  #:use-module (guix-config substitutes)
  #:use-module (guix-config common))


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
     (keyboard-layout %my-kb-layout)))

   (firmware
    (list
     linux-firmware
     sof-firmware))

   (keyboard-layout %my-kb-layout)

   (packages
    (append
     %my-base-packages
     (operating-system-packages installation-os)))

   (services
     (modify-services (operating-system-user-services installation-os)
       (guix-service-type
        config =>(guix-configuration
                  (inherit config)
                  (channels %my-pinned-channels)
                  (guix (guix-for-channels %my-pinned-channels))
                  (substitute-urls %my-substitutes-urls)
                  (authorized-keys %my-authorized-keys)))))))


guix-installer-system
