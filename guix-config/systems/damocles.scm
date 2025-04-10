;(define-module (guix-config systems damocles)
;  #:use-module (gnu)
;  #:use-module (gnu services networking)
;  #:use-module (gnu packages screen)
;  #:use-module (gnu packages ssh))
;
;(define-public damocles-system
;  (operating-system
;   (host-name "damocles")
;   (timezone "Asia/Novosibirsk")
;   (locale "ru_RU.utf8")
;
;   (bootloader
;    (bootloader-configuration
;     (bootloader grub-bootloader)
;     (targets '("/dev/sda1"))
;     (keyboard-layout kb-layout)))
;
;
;   (keyboard-layout kb-layout)
;
;
;   (users
;    (cons*
;     (user-account
;      (name "schneizel")
;      (group "users")
;      (home-directory "/home/schneizel")
;      (supplementary-groups '("wheel" "netdev"
;                              "audio" "video")))
;     %base-user-accounts))
;
;   ;Globaly installed packages(e.g. for all users)
;   (packages
;    (append
;     ;; define package list - dont forget
;     damocles-packages:all
;     %base-packages))
;
;   ;Installed and enabled services(like ssh-server,docker, etc.)
;   (services
;    (append
;     (list
;      ;; Define home -dont forget
;      (service guix-home-service-type
;            `(("schneizel" ,kovalev-home)))
;      (service iptables-service-type
;               (iptables-configuration
;                (ipv4-rules
;                 (local-file
;                  (string-append
;                   (getenv "DOTFILES_DIR")
;                   "/sys-files/iptables/damocles.rules")))
;                (ipv6-rules
;                 (local-file
;                  (string-append
;                   (getenv "DOTFILES_DIR")
;                   "/sys-files/iptables/damocles.rules")))))
;      ;; Some service for wireguard connections
;      (service openssh-service-type
;               (openssh-configuration
;                (port-number 13131))))
;
;     (modify-services %base-services
;        delete(service static-networking-service-type
;                 (list %loopback-static-networking))
;       (guix-service-type
;        config =>(guix-configuration
;                  (inherit config)
;                  (channels default-channels-with-nonguix)
;                  (guix (guix-for-channels default-channels-with-nonguix))
;                  (substitute-urls bordeaux-nonguix-substitute-urls)
;                  (authorized-keys default-authorized-keys-with-nonguix))))))
;
;
;   (file-systems
;    (cons*
;     (file-system
;      (mount-point "/")
;      (device "/dev/vda1")
;      (type "ext4"))
;     %base-file-systems))
;
;   (swap-devices
;    (list
;     (swap-space
;      (target (file-system-label "swap"))
;      (dependencies mapped-devices))))
;
;
;
;   ;; Add services to the baseline: a DHCP client and
;   ;; an SSH server.
;   (services
;    (append
;     (list
;      (service dhcp-client-service-type)
;      (service openssh-service-type
;               (openssh-configuration
;                (openssh openssh-sans-x)
;                (port-number 2222))))
;     %base-services))))
;
;
;damocles-system
