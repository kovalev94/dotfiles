(define-module (guix-config systems mirage)
  #:use-module (guix gexp)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages linux)
  #:use-module (gnu services)
  #:use-module (gnu services pm)
  #:use-module (gnu services ssh)
  #:use-module (gnu services base)
  #:use-module (gnu services desktop)
  #:use-module (gnu services networking)
  #:use-module (gnu system)
  #:use-module (gnu system pam)
  #:use-module (gnu system shadow)
  #:use-module (guix-config systems desktop)
  #:export (mirage-system))
;;Clean imports

(define mirage-system
  (operating-system
    (inherit %my-desktop-system)
    (host-name "mirage")
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
         '("wheel" "netdev" "audio" "video" "kvm" "libvirt" "cgroup")))
      %base-user-accounts))

    (packages
     (cons*
      tlp
      (operating-system-packages %my-desktop-system)))

    (services
     (append
      (list
       (service tlp-service-type)
       (service thermald-service-type)
       (simple-service 'add-extra-hosts hosts-service-type
                       (list
                        (host "185.164.163.16" "vpnserv")
                        (host "213.87.105.213" "damocles")
                        (host "109.174.98.182" "ipoint-marksa-white")
                        (host "109.111.191.225" "ipoint-gogolya-white")
                        (host "176.126.103.60" "ipoint-controller-white")))
       (simple-service 'my-env session-environment-service-type
                       `(("DOTFILES_DIR" .
                          "/home/lulu/.dotfiles")
                         ("TZ" .
                          ,(operating-system-timezone %my-desktop-system))
                         ("GUIX_PACKAGE_PATH" .
                          "/home/lulu/.dotfiles"))));; add dynamic behavior
      (modify-services (operating-system-user-services %my-desktop-system)
        (openssh-service-type
         config => (openssh-configuration
                     (port-number 13131)))
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
                        "/sys-files/mirage/nftables/rules")))));; add dynamic behavior
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
