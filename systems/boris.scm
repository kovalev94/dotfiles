;; -*- geiser-scheme-implementation: guile -*-

(use-modules (gnu)
             (gnu packages)
             (gnu packages base)
             (gnu packages bash)
             (gnu packages certs)
             (gnu packages cups)
             (gnu packages glib)
             (gnu packages gnome)
             (gnu packages idutils)
             (gnu packages libusb)
             (gnu packages linux)
             (gnu packages nfs)
             (gnu packages package-management)
             (gnu packages scanner)
             (gnu packages vpn)
             (gnu services)
             (gnu services avahi)
             (gnu services base)
             (gnu services cups)
             (gnu services dbus)
             (gnu services desktop)
             (gnu services linux)
             (gnu services networking)
             (gnu services nix)
             (gnu services sound)
             (gnu services spice)
             (gnu services ssh)
             (gnu services virtualization)
             (gnu services xorg)
             (gnu system locale)
             (gnu system nss)
             (gnu system setuid)

             (guix gexp)

             (provocation.me packages linux)

             ((srfi srfi-1) #:prefix srfi-1:))

(operating-system

  ;; -- host -------------------------------------------------------------------

  (host-name "enceladus.provocation.me")

  ;; -- timezone ---------------------------------------------------------------

  (timezone "Asia/Kamchatka")

  ;; -- locale -----------------------------------------------------------------

  (locale "en_US.utf8")
  (locale-definitions
   (list (locale-definition (source "en_US")
                            (name "en_US.utf8"))
         (locale-definition (source "ru_RU")
                            (name "ru_RU.utf8"))))

  ;; -- filesystems ------------------------------------------------------------

  (file-systems (cons* (file-system
                        ;; root fs
                        (device (file-system-label "*"))
                        (mount-point "/")
                        (type "ext4"))

                       (file-system
                        ;; esp fs
                        (device (uuid "*" 'fat))
                        (mount-point "/boot/efi")
                        (type "vfat"))

                       (file-system
                        ;; home fs
                        (device (file-system-label "*"))
                        (mount-point "/home")
                        (type "ext4"))

                       (file-system
                        ;; store r01
                        (device (file-system-label "*"))
                        (mount-point "/home/.gx_")
                        (type "ext4"))

                       (file-system
                        ;; store r02
                        (device (file-system-label "*"))
                        (mount-point "/home/.gx_")
                        (type "ext4"))

                       (file-system
                         (device "tmpfs")
                         (mount-point "/tmp")
                         (type "tmpfs")
                         (check? #f)
                         (flags '(no-dev))
                         (options "mode=1777,size=50%"))

                       %base-file-systems))

  ;; (swap-devices "/swapfile")

  ;; -- bootloader -------------------------------------------------------------

  (bootloader (bootloader-configuration
               (bootloader grub-efi-bootloader)
               (targets '("/boot/efi"))))

  (kernel (make-linux-kernel %linux-version-6.1
                             %linux-hash-6.1))

                             ;; #:kernel-config (local-file-absolute-file-name
                             ;;                  (local-file "./6.0-x86_64.conf"))))

  (kernel-arguments (list ;; "mitigations=off"
                          "quiet"
                          "amd_iommu=on"))

  ;; -- firmware ---------------------------------------------------------------

  (firmware (cons* linux-firmware %base-firmware))

  ;; -- user acounts -----------------------------------------------------------

  (users (cons (user-account
                (name "*")
                (comment "*")
                (group "users")
                (supplementary-groups '("wheel"
                                        "netdev"
                                        "kvm"
                                        "disk"
                                        "audio"
                                        "video"
                                        "input"
                                        "colord"
                                        "scanner"
                                        "lp"
                                        "lpadmin"))
                (home-directory "/home/*"))
               %base-user-accounts))

  ;; -- keyboard layout --------------------------------------------------------

  (keyboard-layout (keyboard-layout "us,ru" #:options
                                    '("ctrl:nocaps")))

  ;; -- system packages --------------------------------------------------------

  (packages (cons*
             ;; -- nss certificates --------------------------------------------
             nss-certs
             ;; -- mounts support ----------------------------------------------
             ntfs-3g fuse
             ;; -- hardware ----------------------------------------------------
             sane-backends hplip-minimal
             ;; -- network -----------------------------------------------------
             openvpn
             ;; -- nix ---------------------------------------------------------
             nix
             ;; -- base packages -----------------------------------------------
             %base-packages))

  ;; -- system services --------------------------------------------------------

  (services (cons*

             ;; -- linux -------------------------------------------------------

             ;; (service kernel-module-loader-service-type
             ;;          '("asus_wmi_ec_sensors"))


             ;; -- misc. -------------------------------------------------------

             (service gpm-service-type)

             ;; -- foreign binaries compat. ------------------------------------

             (service special-files-service-type
                      `(("/lib64/ld-linux-x86-64.so.2"
                         ,(file-append (canonical-package glibc)
                                       "/lib/ld-linux-x86-64.so.2"))))

             ;; -- network -----------------------------------------------------

             ;; (service network-manager-service-type
             ;;          (network-manager-configuration
             ;;           (vpn-plugins
             ;;            (list network-manager-openvpn))))

             (service static-networking-service-type
                      (list (static-networking
                             (addresses
                              (list (network-address
                                     (device "enp3s0")
                                     (value "*/24"))
                                    (network-address
                                     (device "enp3s0")
                                     (value "*::7/48"))))
                             (routes (list (network-route
                                            (destination "default")
                                            (gateway "*"))
                                           (network-route
                                            (destination "default")
                                            (gateway "*"))))
                             (name-servers '("*.1"
                                             "*::2"
                                             "*::1112")))))

             (service avahi-service-type)

             (service ntp-service-type)

             ;; (service openssh-service-type
             ;;          (openssh-configuration
             ;;           (x11-forwarding? #t)
             ;;           (password-authentication? #f)
             ;;           (port-number 2222)))


             ;; -- guix publish ------------------------------------------------

             ;; (service guix-publish-service-type
             ;;          (guix-publish-configuration
             ;;           (host "0.0.0.0")
             ;;           (port 4100)
             ;;           (compression '(("lzip" 7) ("gzip" 9)))))

             ;; -- nix ---------------------------------------------------------

             (service nix-service-type)

             ;; -- virtualization ----------------------------------------------

             (service qemu-binfmt-service-type
                      (qemu-binfmt-configuration
                       (platforms (lookup-qemu-platforms "i386"
                                                         "arm"
                                                         "aarch64"
                                                         "mips64el"))))

             ;; -- printing (cups) ---------------------------------------------

             (service cups-service-type
                      (cups-configuration
                       (web-interface? #t)
                       (extensions (list cups-filters foomatic-filters
                                         foo2zjs hplip-minimal))
                       (server-name host-name)
                       ;; (host-name-lookups #t)
                       ;; (browsing? #t)
                       ;; (browse-dns-sd-sub-types (list "_cups" "_print"))
                       ;; (listen '("192.168.7.2:631"
                       ;;           "localhost:631"
                       ;;           "/var/run/cups/cups.sock"))
                       (default-paper-size "A4")))

             (service cups-pk-helper-service-type)

             ;; -- desktop services --------------------------------------------

             polkit-wheel-service

             (service polkit-service-type)

             (pam-limits-service ;; for jack & co.
              (list
               (pam-limits-entry "@audio" 'both 'rtprio 99)
               (pam-limits-entry "@audio" 'both 'memlock 'unlimited)))

             (simple-service 'mtp udev-service-type (list libmtp))

             (service sane-service-type)

             (simple-service 'mount-setuid-helpers setuid-program-service-type
                             (map (lambda (program)
                                    (setuid-program
                                     (program program)))
                                  (list (file-append nfs-utils "/sbin/mount.nfs")
                                        (file-append ntfs-3g "/sbin/mount.ntfs-3g"))))

             (udisks-service)

             (accountsservice-service)

             (service colord-service-type)

             (elogind-service)

             (dbus-service)

             x11-socket-directory-service

             (service pulseaudio-service-type)

             (service alsa-service-type (alsa-configuration
                                         (pulseaudio? #t)))

             ;; -- base services -----------------------------------------------

             (modify-services %base-services
               (guix-service-type config =>
                                  (guix-configuration
                                   (inherit config)
                                   (substitute-urls
                                    (list "https://bordeaux.guix.gnu.org"))
                                   (build-accounts 32))))))

  (name-service-switch %mdns-host-lookup-nss))

