(define-module (my-modules services)
  #:use-module (gnu system keyboard)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services docker)
  #:use-module (gnu services networking)
  #:use-module (gnu services avahi)
  #:use-module (gnu services ssh)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services xorg)
  #:use-module (gnu services dbus)
  #:use-module (gnu services nix)
  #:use-module (gnu services desktop)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages spice)
  #:use-module (guix gexp)
  #:use-module (my-modules keyboard)
  #:use-module (my-modules hosts)
  #:use-module (my-modules hosts other)
  #:use-module ((my-modules hosts mts xring)
                #:prefix xring:)
  #:export (modified-desktop-services
            system-services))



(define modified-desktop-services
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
                               (map
                                (lambda (tty-font-pair)
                                  (cons (car tty-font-pair)
                                        (file-append
                                         font-terminus
                                         "/share/consolefonts/ter-132n")))
                                ttys-font-config))
    (network-manager-service-type config =>
                                  (network-manager-configuration
                                   (inherit config)
                                   (vpn-plugins
                                    (list network-manager-vpnc))))))



(define system-services
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
                     (add-domain xring:routers-hosts "routers.xring.")
                     (add-domain xring:servers-hosts "servers.xring.")))
    (set-xorg-configuration
     (xorg-configuration
      (keyboard-layout kb-layout))))
   modified-desktop-services))
