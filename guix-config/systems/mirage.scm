(define-module (guix-config systems mirage)
  #:use-module (guix gexp)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)
  #:use-module (gnu services networking)
  #:use-module (gnu system)
  #:use-module (gnu system pam)
  #:use-module (gnu system shadow)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system privilege)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (gnu packages vpn)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages package-management)
  #:use-module (nongnu packages linux)
  #:use-module (guix-config package-lists)
  #:use-module (guix-config etc-hosts)
  #:use-module (guix-config services)
  #:use-module (guix-config keyboard))

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
      (name "lulu")
      (comment "Лелуш Ламперуж")
      (uid 1000)
      (group "users")
      (home-directory "/home/lulu")
      (supplementary-groups
       '("wheel" "netdev" "audio" "video" "kvm" "libvirt" )))
     %base-user-accounts))

   ;Globaly installed packages(e.g. for all users)
   (packages
    (cons*
     vpnc
     (append
      base-sys-toolkit
      base-gui-toolkit
      fs-tools
      network-tools
      virtualization-tools
      sys-fonts
      %base-packages)))

   ;Installed and enabled services(like ssh-server,docker, etc.)
   (services
    (append
     (assoc-ref virtualization-service-list "services")
     power-management-service-list
     (list
      (service bluetooth-service-type)
      (service iptables-service-type
               (iptables-configuration
                (ipv4-rules
                 (local-file
                  (string-append
                   (getenv "DOTFILES_DIR")
                   "/sys-files/mirage/iptables.rules")))
                (ipv6-rules
                 (local-file
                  (string-append
                   (getenv "DOTFILES_DIR")
                   "/sys-files/mirage/iptables.rules")))))
      (simple-service 'dotfiles-and-guix-env session-environment-service-type
                     `(("DOTFILES_DIR" .
                        "/home/lulu/.dotfiles")
                       ("GUIX_PACKAGE_PATH" .
                        "/home/lulu/.dotfiles")))
      (simple-service 'add-extra-hosts
                      hosts-service-type
                      (append
                       ipoint
                       vpn-servers
                       personal-machines
                       work-machines))
      (service openssh-service-type
               (openssh-configuration
                (port-number 13131))))

     (modify-services shit-trimmed-desktop-services
       ;Sleep doesn't work, using freeze until fix.
       (elogind-service-type
        config =>(elogind-configuration
                  (inherit config)
                  (suspend-mode '(s2idle deep))))
       (guix-service-type
        config =>(guix-configuration
                  (inherit config)
                  (channels pinned-channels)
                  (guix (guix-for-channels pinned-channels))
                  (substitute-urls bordeaux-nonguix-substitute-urls)
                  (authorized-keys default-authorized-keys-with-nonguix)))
       (console-font-service-type
        _ => hi-dpi-console-font-configuration)
       (network-manager-service-type
        _ => network-manager-with-vpnc-configuration))))


   (privileged-programs
    (append
     (cons*
      (privileged-program
       (program
        (file-append iputils "/bin/ping"));Neeeded for iptuils ping
       (setuid? #t))
      (assoc-ref virtualization-service-list "privileged-programs"))
     %default-privileged-programs))

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
      (device (file-system-label "guix-home"))
      (dependencies mapped-devices)
      (type "ext4"))
     (file-system
      (mount-point "/")
      (device (file-system-label "guix-root"))
      (dependencies mapped-devices)
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
