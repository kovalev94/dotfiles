(define-module (kovalev systems mirage)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (gnu system shadow)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu services base)
  #:use-module (gnu services networking)
  #:use-module (gnu services desktop)
  #:use-module (gnu services ssh)
  #:use-module (gnu services avahi)
  #:use-module (gnu services guix)
  #:use-module (gnu system setuid)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages package-management)
  #:use-module (nongnu packages linux)
  #:use-module (nongnu system linux-initrd)
  #:use-module ((kovalev package-lists mirage) #:prefix mirage-packages:)
  #:use-module (kovalev etc-hosts)
  #:use-module (kovalev services)
  #:use-module (kovalev keyboard)
  #:use-module (kovalev homes kovalev)
  #:use-module ((srfi srfi-1) #:prefix srfi-1:))

(define-public mirage-system
  (operating-system
   (host-name "mirage")
   (locale "ru_RU.utf8")
   (timezone "Asia/Novosibirsk")


   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets '("/boot/efi"))
     (theme (grub-theme
             (inherit (grub-theme))
             (gfxmode '("1920x1080x32" "auto"))))
     (keyboard-layout kb-layout)))

   (kernel linux)
   ;Temporary(I hope) fix for screen redraw lags
   (kernel-arguments
    (append
     (list "i915.enable_psr=0")
     %default-kernel-arguments))

   (initrd microcode-initrd)

   (firmware
    (list
     linux-firmware
     sof-firmware))


   (keyboard-layout kb-layout)


   (users
    (cons*
     (user-account
      (name "kovalev")
      (comment "Виталий Ковалёв")
      (group "users")
      (home-directory "/home/kovalev")
      (supplementary-groups
       '("wheel" "netdev" "audio" "video" "kvm" "libvirt" )))
     %base-user-accounts))

   ;Globaly installed packages(e.g. for all users)
   (packages
    (append
     mirage-packages:all
     %base-packages))

   ;Installed and enabled services(like ssh-server,docker, etc.)
   (services
    (append
     (assoc-ref virtualization-service-list "services")
     (list
      (service bluetooth-service-type)
      (service iptables-service-type
               (iptables-configuration
                (ipv4-rules
                 (local-file
                  (string-append
                   (getenv "GUIX_CONFIG_DIR")
                   "/sys-files/iptables/mirage.rules")))
                (ipv6-rules
                 (local-file
                  (string-append
                   (getenv "GUIX_CONFIG_DIR")
                   "/sys-files/iptables/guix-installer.rules")))))
      (simple-service 'add-extra-hosts
                      hosts-service-type
                      (append
                       ipoint
                       personal-machines))
      (service openssh-service-type
               (openssh-configuration
                (port-number 13131))))

     (modify-services shit-trimmed-desktop-services
       (guix-service-type
        config =>(guix-configuration
                  (inherit config)
                  (channels default-channels-with-nonguix)
                  (guix (guix-for-channels default-channels-with-nonguix))
                  (substitute-urls bordeaux-nonguix-substitute-urls)
                  (authorized-keys default-authorized-keys-with-nonguix)))
       (console-font-service-type
        _ => hi-dpi-console-font-configuration)
       (network-manager-service-type
        _ => network-manager-with-vpnc-configuration))))


   (setuid-programs
    (append
     (cons*
      (setuid-program
       (program
        (file-append iputils "/bin/ping")));Neeeded for iptuils ping
      (assoc-ref virtualization-service-list "setuid-programs"))
     %setuid-programs))

                                        ;Required for LVM disks
   (mapped-devices
    (list
     (mapped-device
      (source "MirageLinux")
      (targets
       (list
        "MirageLinux-GuixRoot"
        "MirageLinux-GuixHome"
        "MirageLinux-Swap"))
      (type lvm-device-mapping))))

   (file-systems
    (cons*
     (file-system
      (mount-point "/home")
      (device "/dev/mapper/MirageLinux-GuixHome")
      (type "ext4"))
     (file-system
      (mount-point "/")
      (device "/dev/mapper/MirageLinux-GuixRoot")
      (type "ext4"))
     (file-system
      (mount-point "/boot/efi")
      (device (file-system-label "EFI"))
      (type "vfat"))
     %base-file-systems))

   (swap-devices
    (list
     (swap-space
      (target (file-system-label "swap"))
      (dependencies mapped-devices))))))


mirage-system
