(define-module (guix-config systems base)
  #:use-module (guix gexp)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages package-management)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (gnu services base)
  #:use-module (gnu services dbus)
  #:use-module (gnu services xorg)
  #:use-module (gnu services avahi)
  #:use-module (gnu services desktop)
  #:use-module (gnu services networking)
  #:use-module (gnu system)
  #:use-module (gnu system pam)
  #:use-module (gnu system shadow)
  #:use-module (gnu system accounts)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system privilege)
  #:use-module (gnu bootloader)
  #:use-module (gnu bootloader grub)
  #:use-module (nongnu system linux-initrd)
  #:use-module (nongnu packages linux)
  #:use-module (guix-config packages)
  #:use-module (guix-config channels)
  #:use-module (guix-config substitutes)
  #:use-module (guix-config keyboard)
  #:use-module (srfi srfi-1)
  #:export (%my-base-system))


(define %my-base-system
  (operating-system
    (host-name "my-base")
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

    (packages
     (append
      %my-base-packages
      %base-packages))

    (services
     (append
      (list
       (service bluetooth-service-type)
       (service nftables-service-type)
       (service openssh-service-type))
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
         (file-append iputils "/bin/ping"))
        (capabilities "cap_net_raw=ep"))
      (remove (lambda (p)
                (let ((path (object->string (privileged-program-program p))))
                  (and (string-contains path "inetutils")
                       (or (string-contains path "/bin/ping")
                           (string-contains path "/bin/ping6")))))
              %default-privileged-programs)))
    ;;Required for LVM disks
    (mapped-devices
     (list
      (mapped-device
        (source "Guix")
        (targets
         (list "Guix-Root" "Guix-Home" "Guix-Swap"))
        (type lvm-device-mapping))))

    (file-systems
     (cons*
      (file-system
        (mount-point "/home")
        (device "/dev/mapper/Guix-Home")
        (dependencies mapped-devices)
        (type "ext4"))
      (file-system
        (mount-point "/")
        (device "/dev/mapper/Guix-Root")
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
        (target "/dev/mapper/Guix-Swap")
        (dependencies mapped-devices))))))
