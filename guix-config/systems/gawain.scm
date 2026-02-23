(define-module (guix-config systems gawain)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages package-management)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (gnu services base)
  #:use-module (gnu services dbus)
  #:use-module (gnu services xorg)
  #:use-module (gnu services avahi)
  #:use-module (gnu services desktop)
  #:use-module (gnu services containers)
  #:use-module (gnu services networking)
  #:use-module (gnu services virtualization)
  #:use-module (gnu system)
  #:use-module (gnu system pam)
  #:use-module (gnu system shadow)
  #:use-module (gnu system accounts)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system privilege)
  #:use-module (nongnu system linux-initrd)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (nongnu packages linux)
  #:use-module (guix-config package-sets)
  #:use-module (guix-config channels)
  #:use-module (guix-config substitutes)
  #:use-module (guix-config common)
  #:use-module (guix-config packages certs)
  #:use-module (guix-config packages telephony)
  #:use-module (srfi srfi-1))


(define-public gawain-system
  (operating-system
    (host-name "gawain")
    (locale "ru_RU.utf8")
    (timezone "Asia/Novosibirsk")

    (bootloader
      (bootloader-configuration
        (bootloader grub-efi-bootloader)
        (targets '("/boot/efi"))
        (theme (grub-theme
                (inherit (grub-theme))
                (gfxmode '("1920x1080x32" "auto"))))
        (keyboard-layout %my-kb-layout)))

    (kernel linux)
    (initrd microcode-initrd)
    (firmware
     (list
      linux-firmware
      sof-firmware))

    (keyboard-layout %my-kb-layout)

    (users
     (cons*
      (user-account
        (name "vitaliy.kovalev")
        (comment "Виталий Ковалёв")
        (uid 1000)
        (group "users")
        (home-directory "/home/vitaliy.kovalev")
        (supplementary-groups
         '("wheel" "netdev" "audio" "video" "kvm" "libvirt" )))
      %base-user-accounts))
    ;;Globaly installed packages(e.g. for all users)
    (packages
     (append
      (specifications->packages
       (cons*
        "eltex-certs"
        (append
         base-sys
         base-gui
         fs-tools
         network-tools
         virtualization-base
         sys-fonts)))
      %base-packages))

    ;;Installed and enabled services(like ssh-server,docker, etc.)
    (services
     (append
      (list
       (service libvirt-service-type)
       (service virtlog-service-type)
       (simple-service
        'spice-polkit polkit-service-type
        (list spice-gtk))
       (service nftables-service-type
                (nftables-configuration
                  (ruleset
                   (local-file
                    (string-append
                     (getenv "DOTFILES_DIR")
                     "/sys-files/gawain/nftables/rules")))))
       (simple-service 'my-env session-environment-service-type
                       `(("DOTFILES_DIR" .
                          "/home/vitaliy.kovalev/.dotfiles")
                         ("TZ" . ,timezone)
                         ("GUIX_PACKAGE_PATH" .
                          "/home/vitaliy.kovalev/.dotfiles")))
       (service rootless-podman-service-type
                (rootless-podman-configuration
                  (subgids
                   (list (subid-range (name "vitaliy.kovalev"))))
                  (subuids
                   (list (subid-range (name "vitaliy.kovalev"))))))
       (service openssh-service-type
                (openssh-configuration
                  (port-number 22)
                  (extra-content "PermitTunnel yes"))))

      (modify-services %desktop-services
        (delete avahi-service-type)
        (delete gdm-service-type)
        (delete (service-kind gdm-file-system-service))
        (guix-service-type
         config =>(guix-configuration
                    (inherit config)
                    (channels %my-pinned-channels)
                    (guix (guix-for-channels %my-pinned-channels))
                    (substitute-urls %my-substitutes-urls)
                    (authorized-keys %my-authorized-keys))))))

    (privileged-programs
     (cons*
      (privileged-program
        (program
         (file-append
          spice-gtk
          "/libexec/spice-client-glib-usb-acl-helper"))
        (setuid? #t))
      (privileged-program
        (program
         (file-append sngrep "/bin/sngrep"))
        (capabilities "CAP_NET_RAW+eip"))
      (privileged-program
        (program
         (file-append (specification->package "iputils") "/bin/ping"))
        (capabilities "cap_net_raw=ep"))
      (remove (lambda (p)
                (let ((path (object->string (privileged-program-program p))))
                  (or (string-suffix? "/bin/ping" path)
                      (string-suffix? "/bin/ping6" path))))
              %default-privileged-programs)))

    ;;Required for LVM disks
    (mapped-devices
     (list
      (mapped-device
        (source "GawainLinux")
        (targets
         (list
          "GawainLinux-GuixRoot"
          "GawainLinux-GuixHome"
          "GawainLinux-Swap"))
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


gawain-system
