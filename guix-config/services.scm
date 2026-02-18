(define-module (guix-config services)
  #:use-module (gnu system privilege)
  #:use-module (gnu services)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages package-management)
  #:use-module (gnu services base)
  #:use-module (gnu services docker)
  #:use-module (gnu services avahi)
  #:use-module (gnu services networking)
  #:use-module (gnu services virtualization)
  #:use-module (gnu services xorg)
  #:use-module (gnu services dbus)
  #:use-module (gnu services desktop)
  #:use-module (gnu services pm)
  #:use-module (gnu system keyboard)
  #:use-module (guix gexp)
  #:use-module (guix channels)
  #:use-module ((srfi srfi-1) #:prefix srfi-1:)

  #:export (kb-layout
            remove-services
            default-channels-with-nonguix
            default-authorized-keys-with-nonguix
            bordeaux-nonguix-substitute-urls
            network-manager-with-vpnc-configuration
            docker-service-list
            power-management-service-list
            virtualization-service-list
            nm-applet-service-type
            shit-trimmed-desktop-services
            pinned-channels))


(define kb-layout
  (keyboard-layout
   "us,ru"
   #:options '("grp:alt_space_toggle" "caps:swapescape")))


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
  (list
   "https://bordeaux.guix.gnu.org"
   "https://substitutes.nonguix.org"))


(define docker-service-list
  (list
   (service docker-service-type)
   (service containerd-service-type)))


(define power-management-service-list
  (list
   (service tlp-service-type)
   (service thermald-service-type)))


(define virtualization-service-list
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

(define pinned-channels
  (list (channel
         (name 'guix)
         (url "https://git.guix.gnu.org/guix.git")
         (branch "master")
         (commit
          "5e63c9bdb1bf7114d742ba4c07596932e0124188")
         (introduction
          (make-channel-introduction
           "9edb3f66fd807b096b48283debdcddccfea34bad"
           (openpgp-fingerprint
            "BBB0 2DDF 2CEA F6A8 0D1D  E643 A2A0 6DF2 A33A 54FA"))))
        (channel
         (name 'nonguix)
         (url "https://gitlab.com/nonguix/nonguix")
         (branch "master")
         (commit
          "0f68c1684169cbef8824fb246dfefa3e6832225b")
         (introduction
          (make-channel-introduction
           "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
           (openpgp-fingerprint
            "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))))
