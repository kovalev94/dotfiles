(define-module (guix-config homes schneizel)
  #:use-module (gnu home)
  #:use-module (gnu packages vpn)
  #:use-module (gnu packages fonts)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services dotfiles)
  #:use-module (gnu home services syncthing)
  #:use-module (guix-config channels)
  #:use-module (guix-config packages))

;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(define-public schneizel-home
  (home-environment
   ;; Below is the list of packages that will show up in your
   ;; Home profile, under ~/.guix-home/profile.
    (packages
     %my-emacs-packages)
   ;; 

   ;;Below is the list of Home services.  To search for available
   ;; services, run 'guix home search KEYWORD' in a terminal.
   (services
    (list
     ;(service home-syncthing-service-type
     ;         (for-home
     ;          (syncthing-configuration
     ;           (arguments
     ;            (list
     ;             (string-append
     ;              "--config="
     ;              (or (getenv "XDG_CONFIG_HOME") "/home/schneizel/.config")
     ;              "/syncthing")
     ;             (string-append
     ;              "--data="
     ;              (or (getenv "XDG_STATE_HOME") "/home/schneizel/.local/state")
     ;              "/syncthing"))))))
     (service home-openssh-service-type
              (home-openssh-configuration
               (authorized-keys
                (list
                 (local-file
                  (string-append
                   %distro-root-directory
                   "/home-files/general/knightmares.pub"))))))
     (service home-bash-service-type
              (home-bash-configuration
               (aliases '(("grep" . "grep --color=auto") ("ll" . "ls -l")
                          ("ls" . "ls -p --color=auto")))
               (bashrc (list
                        (local-file
                         (string-append
                          %distro-root-directory
                          "/home-files/schneizel/.bashrc")
                         "bashrc")))
               (bash-profile (list
                              (local-file
                               (string-append
                                %distro-root-directory
                                "/home-files/schneizel/.bash_profile")
                               "bash_profile")))))
     (service home-dotfiles-service-type
              (home-dotfiles-configuration
               (source-directory
                (string-append
                 %distro-root-directory
                 "/home-files"))
               (directories '("schneizel"))
               (excluded
                (list
                 ".*~"
                 ".*\\.swp"
                 "\\.git"
                 "\\.gitignore"
                 ;;Exclude .bash* files because they are
                 ;;already managed by home-bash-service
                 ".bashrc"
                 ".bash_profile"))))))))

schneizel-home
