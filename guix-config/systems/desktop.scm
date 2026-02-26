(define-module (guix-config systems desktop)
  #:use-module (guix gexp)
  #:use-module (gnu packages)
  #:use-module (gnu packages spice)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages package-management)
  #:use-module (gnu services)
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
  #:use-module (guix-config channels)
  #:use-module (guix-config substitutes)
  #:use-module (guix-config common)
  #:use-module (guix-config packages telephony)
  #:use-module (guix-config systems base)
  #:use-module (srfi srfi-1)
  #:export (%my-desktop-system))
;;Clean imports

(define (users->podman-subids users)
  (let ((cgroup-users (filter (lambda (u)
                                (member "cgroup" (user-account-supplementary-groups u)))
                              users)))
    (map (lambda (user index)
           (subid-range
             (name (user-account-name user))
             (start (+ 100000 (* index 65536)))
             (count 65536)))
         cgroup-users
         (iota (length cgroup-users)))))


(define %my-desktop-system
  (operating-system
    (inherit %my-base-system)
    (host-name "my-desktop")

    (packages
     (append
      %my-desktop-packages
      (operating-system-packages %my-base-system)))

    (services
     (append
      (list
       (service libvirt-service-type)
       (service virtlog-service-type)
       (simple-service
        'spice-polkit polkit-service-type
        (list spice-gtk))
       (service rootless-podman-service-type
                (rootless-podman-configuration
                  (subuids
                   (users->podman-subids
                    (operating-system-users this-operating-system)))
                  (subgids
                   (users->podman-subids
                    (operating-system-users this-operating-system))))))
      (operating-system-user-services %my-base-system)))

    (privileged-programs
     (cons*
      (privileged-program
        (program
         (file-append
          spice-gtk
          "/libexec/spice-client-glib-usb-acl-helper"))
        (setuid? #t))
      (privileged-program
        (program
         (file-append sngrep "/bin/sngrep"))
        (capabilities "CAP_NET_RAW+eip"))
      (operating-system-privileged-programs %my-base-system)))))
