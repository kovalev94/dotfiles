(use-modules (gnu)
             (gnu services networking)
             (gnu services desktop)
             (gnu services ssh)
             (gnu packages package-management)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             ((kovalev package-lists mirage) #:prefix mirage-packages:)
             ((kovalev package-lists kovalev) #:prefix kovalev-packages:)
             (kovalev services)
             (kovalev keyboard))


(operating-system
 (host-name "guix-installer")
 (locale "ru_RU.utf8")
 (timezone "Asia/Novosibirsk")

 (bootloader
  (bootloader-configuration
   (bootloader grub-bootloader)
   (targets '("/dev/sda"))
   (keyboard-layout kb-layout)))

 (kernel linux)
 (kernel-arguments
  (append
   (list "i915.enable_psr=0"
         "console=ttyS0,115200")
   %default-kernel-arguments))

 (initrd microcode-initrd)
 (initrd-modules
  (append
   (list "virtio_scsi")
   %base-initrd-modules))

 (firmware
  (list
   linux-firmware
   sof-firmware))


 (keyboard-layout kb-layout)


 (users
  (cons
   (user-account
    (name "manager")
    (comment "Build Manager")
    (group "users")
    (supplementary-groups
     '("wheel" "netdev" "audio" "video")))
   %base-user-accounts))


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
              (ipv6-rules (local-file "iptables.rules"))))
    (service openssh-service-type
             (openssh-configuration
              (port-number 13131))))

   (modify-services shit-trimmed-desktop-services
                    (guix-service-type _ =>
                                       (guix-configuration
                                        (channels default-channels-with-nonguix)
                                        (guix (guix-for-channels default-channels-with-nonguix))
                                        (substitute-urls bordeaux-nonguix-substitute-urls)
                                        (authorized-keys default-authorized-keys-with-nonguix)))
                    (console-font-service-type _ =>
                                               hi-dpi-console-font-configuration)
                    (network-manager-service-type _ =>
                                                  network-manager-with-vpnc-configuration)
                    (console-font-service-type _ =>
                                               hi-dpi-console-font-configuration))))


 (file-systems
  (cons
   (file-system
    (device (file-system-label "root"))
    (mount-point "/")
    (type "ext4"))
   %base-file-systems))

 (swap-devices
  (list
   (swap-space
    (target (file-system-label "swap"))))))
