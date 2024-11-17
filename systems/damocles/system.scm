;; This is an operating system configuration template
;; for a "bare bones" setup, with no X11 display server.

(use-modules (gnu))
(use-service-modules networking ssh)
(use-package-modules screen ssh)

(operating-system
 (host-name "damocles")
 (timezone "Asia/Novosibirsk")
 (locale "ru_RU.utf8")

 (bootloader (bootloader-configuration
              (bootloader grub-bootloader)
              (targets '("/dev/sda1"))))
 (kernel-arguments (list "console=ttyS0,115200"))
 (mapped-devices
  (list
   (mapped-device
    (source "DamoclesVG")
    (targets
     (list
      "DamoclesVG-GuixRoot"
      "DamoclesVG-GuixHome"
      "DamoclesVG-Swap"))
    (type lvm-device-mapping))))

 (file-systems
  (cons*
   (file-system
    (mount-point "/")
    (device "/dev/mapper/DamoclesVG-GuixRoot")
    (type "ext4"))
   (file-system
    (mount-point "/home")
    (device "/dev/mapper/DamoclesVG-GuixHome")
    (type "ext4"))
   %base-file-systems))

 (swap-devices
  (list
   (swap-space
    (target (file-system-label "swap"))
    (dependencies mapped-devices))))

 (users
  (cons*
   (user-account
    (name "schneizel")
    (group "users")
    (home-directory "/home/schneizel")

    ;; Adding the account to the "wheel" group
    ;; makes it a sudoer.  Adding it to "audio"
    ;; and "video" allows the user to play sound
    ;; and access the webcam.
    (supplementary-groups '("wheel" "netdev"
                            "audio" "video")))
   %base-user-accounts))

  ;; Globally-installed packages.
  (packages (cons screen %base-packages))

  ;; Add services to the baseline: a DHCP client and
  ;; an SSH server.
  (services
   (append
    (list
     (service dhcp-client-service-type)
     (service openssh-service-type
              (openssh-configuration
               (openssh openssh-sans-x)
               (port-number 2222))))
    %base-services)))
