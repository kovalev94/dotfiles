;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (gnu services xorg)
             (guix gexp)
             (gnu home services)
             (gnu home services shells)
             (gnu home services ssh)
             (gnu home services desktop)
             (gnu home services dotfiles)
             (gnu home services syncthing)
             (kovalev package-lists kovalev)
             (kovalev keyboard)
             (kovalev ssh))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
 (packages
  (map (compose list specification->package+output)
       (append
        emacs-stuff
        fonts
        www
        video
        virtualization
        tools
        work)))

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
                  (getenv "XDG_CONFIG_HOME")
                  "/syncthing")
                 (string-append
                  "--data="
                  (getenv "XDG_STATE_HOME")
                  "/syncthing"))))))
    (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '(("grep" . "grep --color=auto") ("ll" . "ls -l")
                              ("ls" . "ls -p --color=auto")))
                   (bashrc (list (local-file
                                  ".dotfiles/.bashrc"
                                  "bashrc")))
                   (bash-profile (list (local-file
                                        ".dotfiles/.bash_profile"
                                        "bash_profile")))))
    (service home-dotfiles-service-type
             (home-dotfiles-configuration
              (directories '(".dotfiles"))
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
                     `(("GUIX_PACKAGE_PATH". "/home/kovalev/.guix-config/modules")))
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
             (add-keys-to-agent "120m"))))))
