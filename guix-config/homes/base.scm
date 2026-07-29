(define-module (guix-config homes base)
  #:use-module (gnu home)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services dotfiles)
  #:use-module (guix-config channels)
  #:use-module (guix-config ssh)
  #:export (%my-base-home))


(define %my-base-home
  (home-environment
    (services
     (list
      (service home-channels-service-type
               %my-pinned-channels)
      (service home-ssh-agent-service-type)

      (service home-openssh-service-type
               (home-openssh-configuration
                 (hosts
                  (append
                   vpn-servers
                   personal-machines
                   my-version-control))
                 (authorized-keys '())
                 (known-hosts2
                  (list
                   (local-file
                    (string-append
                     %distro-root-directory
                     "/aux-files/known_hosts_github"))))
                 (add-keys-to-agent "120m")))

      (service home-gpg-agent-service-type
               (home-gpg-agent-configuration
                 (default-cache-ttl 3600)
                 (max-cache-ttl 10800)))
      (service home-bash-service-type)
      (service home-dotfiles-service-type
               (home-dotfiles-configuration
                 (source-directory
                  (string-append
                   %distro-root-directory
                   "/home-files"))
                 (directories '("base"))
                 (excluded
                  (list
                   ".*~"
                   ".*\\.swp"
                   "\\.git"
                   "\\.gitignore"))))))))
