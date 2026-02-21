(define-module (guix-config services)
  #:use-module (gnu system privilege)
  #:use-module (gnu services)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages package-management)
  #:use-module (gnu services base)
  #:use-module (gnu services avahi)
  #:use-module (gnu services networking)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services xorg)
  #:use-module (gnu services dbus)
  #:use-module (gnu services desktop)
  #:use-module (gnu system keyboard)
  #:use-module (guix gexp)
  #:use-module (guix channels)
  #:use-module ((srfi srfi-1) #:prefix srfi-1:)

  #:export (remove-services
            network-manager-with-vpnc-configuration
            virtualization-service-list
            nm-applet-service-type
            shit-trimmed-desktop-services))


(define (remove-services services service-list) ;;Delete
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


(define virtualization-service-list ;;Keep and rewrite
  `(( "services" . (,(service libvirt-service-type
                              (libvirt-configuration
                                (unix-sock-group "libvirt")))
                    ,(service virtlog-service-type)
                    ,(simple-service
                      'spice-polkit polkit-service-type
                      (list spice-gtk))))

    ( "privileged-programs" . (,(privileged-program
                                  (program
                                   (file-append
                                    spice-gtk
                                    "/libexec/spice-client-glib-usb-acl-helper"))
                                  (setuid? #t))))))


                                        ;Because (gnu services networking) module does not expose nm-applet-service
                                        ;define own nm-applet-service-type similar to that module
(define nm-applet-service-type ;; Delete
  (service-kind
   (simple-service 'network-manager-applet
                   profile-service-type
                   (list network-manager-applet))))

(define shit-trimmed-desktop-services ;; Move to base
  (remove-services
   (list
    avahi-service-type
    nm-applet-service-type
    usb-modeswitch-service-type
    gdm-service-type
    (service-kind gdm-file-system-service))
   %desktop-services))

