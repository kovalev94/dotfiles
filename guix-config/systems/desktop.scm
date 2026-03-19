(define-module (guix-config systems desktop)
  #:use-module (guix gexp)
  #:use-module (gnu packages spice)
  #:use-module (gnu services)
  #:use-module (gnu services ssh)
  #:use-module (gnu services dbus)
  #:use-module (gnu services cups)
  #:use-module (gnu services containers)
  #:use-module (gnu services virtualization)
  #:use-module (gnu system)
  #:use-module (gnu system accounts)
  #:use-module (gnu system privilege)
  #:use-module (guix-config packages)
  #:use-module (guix-config packages telephony)
  #:use-module (guix-config systems base)
  #:export (%my-desktop-system))


(define (users->podman-subids users)
  (let ((cgroup-users
         (filter
          (lambda (u)
            (member "cgroup"
                    (user-account-supplementary-groups u)))
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
       (service qemu-binfmt-service-type
                (qemu-binfmt-configuration
                  (platforms (lookup-qemu-platforms "arm" "aarch64"))))
       (service rootless-podman-service-type
                (rootless-podman-configuration
                  (subuids
                   (users->podman-subids
                    (operating-system-users this-operating-system)))
                  (subgids
                   (users->podman-subids
                    (operating-system-users this-operating-system)))))
       (service cups-service-type
                (cups-configuration
                 (web-interface? #t))))
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
