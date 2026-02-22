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
  #:export (virtualization-service-list))


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
