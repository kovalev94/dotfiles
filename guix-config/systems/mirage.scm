(define-module (guix-config systems mirage)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages fonts)
  #:use-module (gnu services)
  #:use-module (gnu services pm)
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
  #:use-module (guix-config systems base)
  #:use-module (guix-config packages telephony)
  #:use-module (srfi srfi-1))
;;Clean imports

(define-public mirage-system
  (operating-system
    (inherit %my-desktop-base-system)
    (host-name "mirage")
    (locale "ru_RU.utf8")
    (timezone "Asia/Novosibirsk")
    ;;Temporary(I hope) fix for screen redraw lags
    (kernel-arguments
     (append
      (list "i915.enable_psr=0")
      %default-kernel-arguments))

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

    (services
     (append
      (list
       (service tlp-service-type)
       (service thermald-service-type)
       (simple-service 'add-extra-hosts hosts-service-type
                       (list
                        (host "185.164.163.16" "vpnserv")
                        (host "213.87.105.213" "damocles")
                        (host "172.16.13.3" "lancelot")
                        (host "109.174.98.182" "ipoint-marksa-white")
                        (host "109.111.191.225" "ipoint-gogolya-white")
                        (host "176.126.103.60" "ipoint-controller-white")))
       (simple-service 'my-env session-environment-service-type
                       `(("DOTFILES_DIR" .
                          "/home/vitaliy.kovalev/.dotfiles")
                         ("TZ" .
                          ,(operating-system-timezone %my-desktop-base-system))
                         ("GUIX_PACKAGE_PATH" .
                          "/home/vitaliy.kovalev/.dotfiles"))));; add dynamic behavior
      (modify-services (operating-system-user-services %my-desktop-base-system)
        ;;Sleep doesn't work, using freeze until fix.
        (elogind-service-type
         config =>(elogind-configuration
                    (inherit config)
                    (suspend-mode '(s2idle deep))))

        (nftables-service-type
         config => (nftables-configuration
                     (ruleset
                      (local-file
                       (string-append
                        (getenv "DOTFILES_DIR");;
                        "/sys-files/gawain/nftables/rules")))));; add dynamic behavior
        (network-manager-service-type
         config => (network-manager-configuration
                     (inherit config)
                     (vpn-plugins (list network-manager-openvpn))))

        (console-font-service-type
         config => (map (lambda (pair)
                          (cons (car pair)
                                (file-append font-terminus "/share/consolefonts/ter-k32n")))
                        config)))))))


mirage-system
