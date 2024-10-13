(define-module (my-modules filesystem)
  #:use-module (gnu system mapped-devices)
  #:use-module (gnu system file-systems)
  #:export (lvm-mapped-devices
            file-systems
            swap-devices))


(define lvm-mapped-devices
  (list
   (mapped-device
    (source "MirageLinux")
    (targets
     (list
      "MirageLinux-GuixRoot"
      "MirageLinux-GuixHome"
      "MirageLinux-Swap"))
    (type lvm-device-mapping))))

(define file-systems
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

(define swap-devices
  (list
   (swap-space
    (target (file-system-label "swap"))
    (dependencies lvm-mapped-devices))))
