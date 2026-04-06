(define-module (guix-config homes gino)
  #:use-module (guix gexp)
  #:use-module (gnu home)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu home services ssh)
  #:use-module (guix-config channels)
  #:use-module (guix-config homes base)
  #:export (gino-home))


(define gino-home
  (home-environment
    (inherit %my-base-home)
    (services
     (modify-services (home-environment-user-services %my-base-home)
       (home-openssh-service-type
        config => (home-openssh-configuration
                    (inherit config)
                    (authorized-keys
                     (list
                      (local-file
                       (string-append
                        %distro-root-directory
                        "/home-files/gino/.ssh/keys/tristan.pub")
                       "knightmares.pub")))
                    (add-keys-to-agent "120m")))))))


gino-home
