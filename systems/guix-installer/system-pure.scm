(use-modules (gnu)
             (gnu services networking)
             (gnu services desktop)
             (gnu services ssh)
             ((kovalev package-lists mirage) #:prefix mirage-packages:)
             ((kovalev package-lists kovalev) #:prefix kovalev-packages:)
             (kovalev services)
             (kovalev keyboard)
             ((srfi srfi-1) #:prefix srfi-1:))


(operating-system
 (host-name "guix-installer")
 (locale "ru_RU.utf8")
 (timezone "Asia/Novosibirsk")

 (bootloader
  (bootloader-configuration
   (bootloader grub-bootloader)
   (targets '("/dev/sda"))
   (keyboard-layout kb-layout)))

 (kernel-arguments
  (append
   (list "console=ttyS0,115200")
   %default-kernel-arguments))

 (initrd-modules
  (append
   (list "virtio_scsi")
   %base-initrd-modules))


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
        (srfi-1:delete
         "firefox"
         (append
          mirage-packages:all
          kovalev-packages:all)))
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
                                        (substitute-urls bordeaux-nonguix-substitute-urls)))
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
