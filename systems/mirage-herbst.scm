;; This is an operating system configuration generated
;; by the graphical installer.
;;
;; Once installation is complete, you can learn and modify
;; this file to tweak the system configuration, and pass it
;; to the 'guix system reconfigure' command to effect your
;; changes.


;; Indicate which modules to import to access the variables
;; used in this configuration.
(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             ((my-modules packages) #:prefix my:)
             ((my-modules services) #:prefix my:)
             ((my-modules keyboard) #:prefix my:)
             ((my-modules filesystem) #:prefix my:)
             (my-modules hosts)
             (my-modules hosts other)
             ((my-modules hosts mts xring) #:prefix xring:))

(use-package-modules
 spice
 fonts
 gnome)

(use-system-modules setuid)


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
    (keyboard-layout my:kb-layout)))

  (locale "ru_RU.utf8")
  (timezone "Asia/Novosibirsk")
  ;keyboard-layout will use in several places in this config
  (keyboard-layout my:kb-layout)
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
  (packages my:system-packages)
  ;Installed and enabled services(like ssh-server,docker, etc.)
  (services my:system-services)

  (setuid-programs
   (append (list (setuid-program
                  (program (file-append spice-gtk "/libexec/spice-client-glib-usb-acl-helper"))))
           %setuid-programs))

  ;Required for LVM disks
  (mapped-devices my:lvm-mapped-devices)
  ;OS file systems
  (file-systems my:file-systems)
  (swap-devices my:swap-devices))
