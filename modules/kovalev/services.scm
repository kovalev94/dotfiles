(define-module (kovalev services)
  #:use-module (gnu system setuid)
  #:use-module (gnu services)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages package-management)
  #:use-module (gnu services base)
  #:use-module (gnu services docker)
  #:use-module (gnu services networking)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services xorg)
  #:use-module (gnu services dbus)
  #:use-module (gnu services desktop)
  #:use-module (guix gexp)
  #:use-module (kovalev channels)
  #:use-module ((srfi srfi-1) #:prefix srfi-1:)

  #:export (remove-services
            hi-dpi-console-font-configuration
            guix-with-nonguix-channels-configuration
            network-manager-with-vpnc-configuration
            desktop-without-gdm-service-list
            docker-service-list
            virtualization-service-list
            nm-applet-service-type))



(define (remove-services services service-list)
  "Remove SERVICES, which should be a list of services,
from SERVICE-LIST (%desktop-services for example)"
  (srfi-1:fold
   (lambda (service service-list)
     (srfi-1:remove
      (lambda (srv)
        (equal?
         (service-kind srv) service))
      service-list))
   service-list
   services))


(define hi-dpi-console-font-configuration
  (map
   (lambda
       (tty)
     (cons
      tty
      (file-append
       font-terminus
       "/share/consolefonts/ter-k32n")))
   '("tty1" "tty2" "tty3" "tty4" "tty5" "tty6")))


(define guix-with-nonguix-channels-configuration
  (guix-configuration
   (channels default-channels-with-nonguix)
   (guix (guix-for-channels default-channels-with-nonguix))
   (substitute-urls
    (cons*
     "https://substitutes.nonguix.org"
     %default-substitute-urls))
   (authorized-keys
    (append
     (list
      (plain-file "non-guix.pub"
                  "(public-key (ecc (curve Ed25519)
  (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
     %default-authorized-guix-keys))))


(define network-manager-with-vpnc-configuration
  (network-manager-configuration
   (vpn-plugins
    (list network-manager-vpnc))))


(define desktop-without-gdm-service-list
  (remove-services
   (list
    gdm-service-type
    (service-kind gdm-file-system-service))
   %desktop-services))


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


 ;Because (gnu services networking) module does not expose nm-applet-service
 ;define own nm-applet-service-type similar to that module
(define nm-applet-service-type
  (service-kind
   (simple-service 'network-manager-applet
                   profile-service-type
                   (list network-manager-applet))))

