(use-modules (gnu)
             (nongnu packages linux)
             (nongnu system linux-initrd)
             (kovalev packages system mirage)
             (kovalev services)
             (kovalev keyboard)
             (kovalev filesystem)
             (kovalev users))


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

  (users users)
  ;Globaly installed packages(e.g. for all users)
  (packages system-packages)
  ;Installed and enabled services(like ssh-server,docker, etc.)
  (services system-services)

  (setuid-programs setuid-programs)

  ;Required for LVM disks
  (mapped-devices lvm-mapped-devices)
  ;OS file systems
  (file-systems file-systems)
  (swap-devices swap-devices))
