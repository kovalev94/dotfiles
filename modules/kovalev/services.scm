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
  #:use-module ((srfi srfi-1) #:prefix srfi-1:)

  #:export (remove-services
            default-channels-with-nonguix
            default-authorized-keys-with-nonguix
            bordeaux-nonguix-substitute-urls
            hi-dpi-console-font-configuration
            network-manager-with-vpnc-configuration
            docker-service-list
            virtualization-service-list
            nm-applet-service-type
            shit-trimmed-desktop-services))



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


(define default-channels-with-nonguix
  (cons* (channel
         (name 'nonguix)
         (url "https://gitlab.com/nonguix/nonguix")
         ;; Enable signature verification:
         (introduction
          (make-channel-introduction
           "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
           (openpgp-fingerprint
            "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
        %default-channels))


(define default-authorized-keys-with-nonguix
  (append
   (list
    (plain-file "non-guix.pub"
                "(public-key (ecc (curve Ed25519)
  (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))
   %default-authorized-guix-keys))


(define bordeaux-nonguix-substitute-urls
  (cons*
   "https://substitutes.nonguix.org"
   %default-substitute-urls))


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


(define network-manager-with-vpnc-configuration
  (network-manager-configuration
   (vpn-plugins
    (list network-manager-vpnc))))


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

(define shit-trimmed-desktop-services
  (remove-services
   (list
    avahi-service-type
    nm-applet-service-type
    usb-modeswitch-service-type
    gdm-service-type
    (service-kind gdm-file-system-service))
   %desktop-services))
