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
             (my-modules hosts)
             (my-modules hosts other)
             (my-modules hosts mts kamchatka)
             ((my-modules hosts mts spd)
              #:prefix spd:)
             ((my-modules hosts mts xring)
              #:prefix xring:))

(use-service-modules
 desktop
 docker
 networking
 avahi
 ssh
 virtualization
 xorg
 dbus
 nix)

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
  (locale "ru_RU.utf8")
  (timezone "Asia/Novosibirsk")
  ;keyboard-layout will use in several places in this config
  (keyboard-layout
   (keyboard-layout
    "us,ru"
    #:options '("grp:win_space_toggle")))

  (bootloader
   (bootloader-configuration
    (bootloader grub-efi-bootloader)
    (targets '("/boot/efi"))
    (theme (grub-theme
	    (inherit (grub-theme))
	    (gfxmode '("1920x1080x32" "auto"))))
    (keyboard-layout keyboard-layout)))

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
    (map specification->package
         (list
          ;;GUI toolkit
          "herbstluftwm"
          "polybar"
          "dmenu"
          "xrandr"
          "xinput"
          "xrdb"
          "xdg-utils"
          "picom"
          "pavucontrol"
          "feh"
          "font-gnu-freefont"
          ;;System utitilies
          "htop"
          "lvm2"
          "bluez"
          "spice-gtk"
          "screen"
          ;;Network utitilies
          "tcpdump"
          "nmap"
          "iputils"
          "curl"
          "wireguard-tools"
          ;;File utitilities
          "vim"
          "mc"
          "unzip"
          "git"
          ;;Programming
          "python"
          ;;Terminal
          "xterm"
          ;;Web Browser
          "firefox"
          ;;VPN plugin, needed for NM
          "vpnc"))
    %base-packages))


  (services
   (append
    (list
     (service openssh-service-type)
     (service nix-service-type)
     (service docker-service-type)
     (service containerd-service-type)
     (service bluetooth-service-type)
     (service libvirt-service-type
              (libvirt-configuration
               (unix-sock-group "libvirt")))
     (service virtlog-service-type)
     (simple-service 'spice-polkit polkit-service-type (list spice-gtk))
     (simple-service 'add-extra-hosts
                hosts-service-type
                (append
                 other-hosts
                 spd:msk-servers
                 (add-domain kamchatka-hosts "kam")
                 (add-domain xring:routers-hosts "routers.xring")
                 (add-domain xring:servers-hosts "servers.xring")))


     (set-xorg-configuration
      (xorg-configuration
       (keyboard-layout keyboard-layout))))

    (modify-services %desktop-services
                     (delete avahi-service-type)
                     (guix-service-type config =>
                                        (guix-configuration
                                         (inherit config)
                                         (substitute-urls
                                          (list
                                           "https://bordeaux.guix.gnu.org"
                                           "https://substitutes.nonguix.org"))
                                         (authorized-keys
                                          (append
                                           (list
                                            (local-file
                                             "/home/kovalev/.config/guix/nonguix-signing-key.pub"))
                                           %default-authorized-guix-keys))))
                     (console-font-service-type ttys-font-config =>
                                                (map (lambda (tty-font-pair)
                                                       (cons (car tty-font-pair)
                                                             (file-append
                                                              font-terminus
                                                              "/share/consolefonts/ter-132n")))
                                                     ttys-font-config))
                     (network-manager-service-type config =>
                                                   (network-manager-configuration
                                                    (inherit config)
                                                    (vpn-plugins
                                                     (list network-manager-vpnc)))))))


  (setuid-programs
   (append (list (setuid-program
                  (program (file-append spice-gtk "/libexec/spice-client-glib-usb-acl-helper"))))
           %setuid-programs))


  ;Required for LVM disks 
  (mapped-devices 
   (list
    (mapped-device
     (source "MirageLinux")
     (targets
      (list
       "MirageLinux-GuixRootSecond"
       "MirageLinux-GuixHomeSecond"
       "MirageLinux-Swap"))
     (type lvm-device-mapping))))


  (file-systems
   (cons*
;This is OS file systems
    (file-system
      (mount-point "/home")
      (device "/dev/mapper/MirageLinux-GuixHomeSecond")
      (type "ext4"))

    (file-system
      (mount-point "/")
      (device "/dev/mapper/MirageLinux-GuixRootSecond")
      (type "ext4"))

    (file-system
      (mount-point "/boot/efi")
      (device (uuid "BFD6-6AB9" 'fat32))
      (type "vfat"))
;Other OS file systems
%base-file-systems))


  (swap-devices
   (list
    (swap-space (target (file-system-label "swap"))
                (dependencies mapped-devices)))))
