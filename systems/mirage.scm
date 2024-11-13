(use-modules (gnu)
             (gnu system setuid)
             (gnu packages spice)
             (nongnu packages linux)
             (gnu services avahi)
             (gnu services networking)
             (gnu services desktop)
             (gnu services ssh)
             (nongnu system linux-initrd)
             (kovalev package-lists mirage)
             (kovalev services)
             (kovalev etc-hosts)
             ((mts hosts xring) #:prefix mts:xring:)
             (kovalev keyboard)
             ((srfi srfi-1) #:prefix srfi-1:))


(operating-system
  (kernel linux)
  ;Temporary(I hope) fix for screen redraw lags
  (kernel-arguments 
   (append
    (list "i915.enable_psr=0")
    %default-kernel-arguments))
  (initrd microcode-initrd)
  (firmware (list linux-firmware sof-firmware))
  (bootloader
   (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (targets '("/boot/efi"))
    (theme (grub-theme
            (inherit (grub-theme))
            (gfxmode '("1920x1080x32" "auto"))))
    (keyboard-layout kb-layout)))

  (locale "ru_RU.utf8")
  (timezone "Asia/Novosibirsk")
  ;keyboard-layout will use in several places in this config
  (keyboard-layout kb-layout)
  (host-name "mirage")

  (users
   (cons*
    (user-account
     (name "kovalev")
     (comment "Виталий Ковалёв")
     (group "users")
     (home-directory "/home/kovalev")
     (supplementary-groups
      '("wheel" "netdev" "audio" "video" "kvm" "libvirt" "docker")))
   %base-user-accounts))
  ;Globaly installed packages(e.g. for all users)
  (packages
   (append
    (map (compose list specification->package+output)
         (append
          system-utils
          network-utils
          base-toolkit
          base-gui))
    %base-packages))

  ;Installed and enabled services(like ssh-server,docker, etc.)
  (services
   (append
    docker-service-list
    (assoc-ref virtualization-service-list "services")
    (list
     (service bluetooth-service-type)
     (simple-service 'add-extra-hosts
                     hosts-service-type
                     (append
                      ipoint
                      akadem))
     (service openssh-service-type))

    (modify-services (remove-services
                      (list
                       avahi-service-type
                       nm-applet-service-type
                       usb-modeswitch-service-type)
                      desktop-without-gdm-service-list)

      (guix-service-type _ =>
                         (guix-configuration
                          (inherit guix-with-nonguix-channels-configuration)
                          (substitute-urls
                           (srfi-1:delete "https://ci.guix.gnu.org"
                                          (guix-configuration-substitute-urls
                                           guix-with-nonguix-channels-configuration)))))
      (console-font-service-type _ =>
                                 hi-dpi-console-font-configuration)
      (network-manager-service-type _ =>
                                    network-manager-with-vpnc-configuration))))

  (setuid-programs
   (append
    (assoc-ref virtualization-service-list "setuid-programs")
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
     (device (uuid "BFD6-6AB9" 'fat32))
     (type "vfat"))
    %base-file-systems))

  (swap-devices
   (list
    (swap-space
     (target (file-system-label "swap"))
     (dependencies mapped-devices)))))
