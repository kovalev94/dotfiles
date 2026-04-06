(define-module (guix-config homes vitaliy-kovalev)
  #:use-module (guix gexp)
  #:use-module (gnu home)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu home services mail)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services dotfiles)
  #:use-module (guix-config channels)
  #:use-module (guix-config homes desktop)
  #:use-module (guix-config ssh)
  #:export (vitaliy-kovalev-home))


(define vitaliy-kovalev-home
  (home-environment
    (inherit %my-desktop-home)
    (services
     (modify-services (home-environment-user-services %my-desktop-home)
       (home-dotfiles-service-type
        config => (home-dotfiles-configuration
                    (inherit config)
                    (directories
                     (cons*
                      "vitaliy.kovalev"
                      (home-dotfiles-configuration-directories config)))))
       (home-msmtp-service-type
        config => (home-msmtp-configuration
                    (inherit config)
                    (accounts
                     (cons*
                      (msmtp-account
                        (name "Eltex")
                        (configuration
                         (msmtp-configuration
                           (host "smtp.eltex.loc")
                           (port 587)
                           (user "vitaliy.kovalev@eltex.loc")
                           (from "vitaliy.kovalev@eltex.loc")
                           (password-eval "pass Eltex/LDAP/vitaliy.kovalev"))))
                      (home-msmtp-configuration-accounts config)))))
       (home-openssh-service-type
        config => (home-openssh-configuration
                    (inherit config)
                    (hosts
                     (append
                      work-machines
                      (home-openssh-configuration-hosts config)))
                    (authorized-keys
                     (list
                      (local-file
                       (string-append
                        %distro-root-directory
                        "/home-files/vitaliy.kovalev/.ssh/keys/gawain.pub")
                       "gawain.pub")))
                    (add-keys-to-agent "120m")))))))


vitaliy-kovalev-home
