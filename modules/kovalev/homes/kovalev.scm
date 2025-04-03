(define-module (kovalev homes kovalev)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu services xorg)
  #:use-module (guix gexp)
  #:use-module (gnu home services)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services dotfiles)
  #:use-module (gnu home services syncthing)
  #:use-module ((kovalev package-lists kovalev) #:prefix kovalev-packages:)
  #:use-module (kovalev keyboard)
  #:use-module (kovalev ssh))

;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.
(define-public kovalev-home
  (home-environment
   ;; Below is the list of packages that will show up in your
   ;; Home profile, under ~/.guix-home/profile.
    (packages kovalev-packages:all)

   ;; Below is the list of Home services.  To search for available
   ;; services, run 'guix home search KEYWORD' in a terminal.
   (services
    (list
     (service home-ssh-agent-service-type)
     (service home-startx-command-service-type
              (xorg-configuration
               (keyboard-layout kb-layout)))
     (service home-syncthing-service-type
              (for-home
               (syncthing-configuration
                (arguments
                 (list
                  (string-append
                   "--config="
                   (or (getenv "XDG_CONFIG_HOME") "/home/kovalev/.config")
                   "/syncthing")
                  (string-append
                   "--data="
                   (or (getenv "XDG_STATE_HOME") "/home/kovalev/.local/state")
                   "/syncthing"))))))
     (service home-bash-service-type
              (home-bash-configuration
               (aliases '(("grep" . "grep --color=auto") ("ll" . "ls -l")
                          ("ls" . "ls -p --color=auto")))
               (bashrc (list
                        (local-file
                         (string-append
                          (getenv "GUIX_CONFIG_DIR")
                          "/home-files/kovalev/.bashrc")
                         "bashrc")))
               (bash-profile (list
                              (local-file
                               (string-append
                                (getenv "GUIX_CONFIG_DIR")
                                "/home-files/kovalev/.bash_profile")
                               "bash_profile")))))
     (service home-dotfiles-service-type
              (home-dotfiles-configuration
               (source-directory
                (string-append
                 (getenv "GUIX_CONFIG_DIR") "/home-files"))
               (directories '("kovalev"))
               (excluded
                (list
                 ".*~"
                 ".*\\.swp"
                 "\\.git"
                 "\\.gitignore"
                 ;;Exclude .bash* files because they are
                 ;;already managed by home-bash-service
                 ".bashrc"
                 ".bash_profile"))))
     (simple-service 'my-env-vars-service
                     home-environment-variables-service-type
                     `(("GUIX_CONFIG_DIR" .
                        "/home/kovalev/.guix-config")
                       ("GUIX_PACKAGE_PATH" .
                        "/home/kovalev/.guix-config/modules")))
     (service home-openssh-service-type
              (home-openssh-configuration
               (hosts
                (append
                 personal-servers
                 ipoint
                 akadem
                 spd-servers
                 spd-routers
                 xring-servers
                 xring-routers
                 xring-general
                 general))
               (authorized-keys '())
               (add-keys-to-agent "120m")))))))

kovalev-home
