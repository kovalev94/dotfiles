(define-module (kovalev services)
  #:use-module (gnu system)
  #:use-module (gnu system keyboard)
  #:use-module (gnu system setuid)
  #:use-module (gnu services)
  #:use-module (gnu packages spice)
  #:use-module (gnu services base)
  #:use-module (gnu services docker)
  #:use-module (gnu services networking)
  #:use-module (gnu services avahi)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services xorg)
  #:use-module (gnu services dbus)
  #:use-module (gnu services desktop)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages package-management)
  #:use-module (guix gexp)
  #:use-module (kovalev keyboard)
  #:use-module (kovalev channels)
  #:export (modified-desktop-services
            docker-service-list
            virtualization-service-list
            system-services))


(define modified-desktop-services
  (modify-services %desktop-services
    (delete avahi-service-type)
    (delete gdm-service-type)
    (guix-service-type config =>
                       (guix-configuration
                        (inherit config)
                        (channels default-channels-with-nonguix)
                        (guix (guix-for-channels default-channels-with-nonguix))
                        (substitute-urls
                         (list
                          "https://bordeaux.guix.gnu.org"
                          "https://substitutes.nonguix.org"))
                        (authorized-keys
                         (append
                          (list
                           (plain-file "non-guix.pub"
                                       "(public-key (ecc (curve Ed25519)
  (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
                          %default-authorized-guix-keys))))
    (console-font-service-type ttys-font-config =>
                               (map
                                (lambda (tty-font-pair)
                                  (cons (car tty-font-pair)
                                        (file-append
                                         font-terminus
                                         "/share/consolefonts/ter-k32n")))
                                ttys-font-config))
    (network-manager-service-type config =>
                                  (network-manager-configuration
                                   (inherit config)
                                   (vpn-plugins
                                    (list network-manager-vpnc))))))

(define docker-service-list
  (list
    (service docker-service-type)
    (service containerd-service-type)))


(define virtualization-service-list
  `(( "services" . (,(service libvirt-service-type
                              (libvirt-configuration
                               (unix-sock-group "libvirt")))
                    ,(service virtlog-service-type)
                    ,(simple-service
                      'spice-polkit polkit-service-type
                      (list spice-gtk))))

    ( "setuid-programs" . (,(setuid-program
                             (program
                              (file-append
                               spice-gtk
                               "/libexec/spice-client-glib-usb-acl-helper")))))))
