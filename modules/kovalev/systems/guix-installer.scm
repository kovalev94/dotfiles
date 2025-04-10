(define-module (kovalev systems guix-installer)
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
  #:use-module (gnu packages wm)
  #:use-module (gnu packages vpn)
  #:use-module (gnu packages sync)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages chromium)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages bittorrent)
  #:use-module (gnu packages libreoffice)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages web-browsers)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages package-management)
  #:use-module (nongnu system install)
  #:use-module (nongnu system linux-initrd)
  #:use-module (nongnu packages linux)
  #:use-module (kovalev package-lists)
  #:use-module (kovalev services)
  #:use-module (kovalev keyboard)
  #:use-module ((srfi srfi-1) #:prefix srfi-1:))


(define-public guix-installer-system
  (operating-system
   (inherit installation-os-nonfree)

   (host-name "guix-installer-kovalev")
   (locale "ru_RU.utf8")
   (timezone "Asia/Novosibirsk")

   (bootloader
    (bootloader-configuration
     (bootloader grub-bootloader)
     (targets '("/dev/sda"))
     (keyboard-layout kb-layout)))

     ; For unknown for me reasons, it breaks booting
     ;(initrd microcode-initrd)

   (firmware
    (list
     linux-firmware
     sof-firmware))

   (keyboard-layout kb-layout)


   (packages
    (append
     (list
      vpnc
      font-google-noto-emoji
      font-fira-mono
      font-fira-sans
      font-fira-code
      rclone
      wireshark
      wireguard-tools
      herbstluftwm
      libreoffice
      dia
      imagemagick
      alacritty
      bluez
      ungoogled-chromium
      nyxt
      keepassxc
      ;telegram-desktop
      qbittorrent)
     base-sys-toolkit
     base-gui-toolkit
     tiled-wm-toolkit
     emacs-toolkit
     fs-tools
     network-tools
     video-tools
     virtualization-tools
     sys-fonts
     (operating-system-packages installation-os-nonfree)))

   (services
    (append
     (list
      (service iptables-service-type
               (iptables-configuration
                (ipv4-rules
                 (local-file
                  (string-append
                   (getenv "GUIX_CONFIG_DIR")
                   "/sys-files/iptables/guix-installer.rules")))
                (ipv6-rules
                 (local-file
                  (string-append
                   (getenv "GUIX_CONFIG_DIR")
                   "/sys-files/iptables/guix-installer.rules"))))))

     (modify-services (operating-system-user-services installation-os-nonfree)
       (openssh-service-type
        config => (openssh-configuration
                   (inherit config)
                   (port-number 13131)
                   (%auto-start? #t)))
       (guix-service-type
        config =>(guix-configuration
                  (inherit config)
                  (channels default-channels-with-nonguix)
                  (guix (guix-for-channels default-channels-with-nonguix))
                  (substitute-urls bordeaux-nonguix-substitute-urls)
                  (authorized-keys default-authorized-keys-with-nonguix))))))))


guix-installer-system
