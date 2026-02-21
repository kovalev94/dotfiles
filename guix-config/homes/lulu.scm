(define-module (guix-config homes lulu)
  #:use-module (guix gexp)
  #:use-module (guix channels)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu services xorg)
  #:use-module (gnu home services)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services mail)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services dotfiles)
  #:use-module (gnu home services syncthing)
  #:use-module (guix-config package-sets)
  #:use-module (guix-config services)
  #:use-module (guix-config channels)
  #:use-module (guix-config ssh))

;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.
(define-public lulu-home
  (home-environment
    ;; Below is the list of packages that will show up in your
    ;; Home profile, under ~/.guix-home/profile.
    (packages
     (specifications->packages
      (append
       (list
        "emacs-bluetooth"
        "qbittorrent")
       (delete "ungoogled-chromium"
               work-tools)
       herbst-de
       emacs-base
       emacs-exwm
       emacs-doom-module-corfu
       emacs-doom-module-magit
       emacs-doom-module-dired
       python-emacs
       ansible-emacs
       mail-emacs
       golang-emacs
       video-tools)))

    ;; Below is the list of Home services.  To search for available
    ;; services, run 'guix home search KEYWORD' in a terminal.
    (services
     (list
      (service home-channels-service-type
               %my-channels)
      (service home-ssh-agent-service-type)
      (service home-gpg-agent-service-type
               (home-gpg-agent-configuration
                 (pinentry-program
                  (file-append
                   (specification->package "pinentry-rofi")
                   "/bin/pinentry-rofi"))
                 (default-cache-ttl 6000)
                 (max-cache-ttl 7200)))
      (service home-startx-command-service-type
               (for-home (xorg-configuration
                           (keyboard-layout kb-layout))))
      (service home-syncthing-service-type
               (for-home
                (syncthing-configuration
                  (arguments
                   (list
                    (string-append
                     "--config="
                     (or (getenv "XDG_CONFIG_HOME") "/home/lulu/.config")
                     "/syncthing")
                    (string-append
                     "--data="
                     (or (getenv "XDG_STATE_HOME") "/home/lulu/.local/state")
                     "/syncthing"))))))
      (service home-bash-service-type
               (home-bash-configuration
                 (aliases '(("grep" . "grep --color=auto") ("ll" . "ls -l")
                            ("ls" . "ls -p --color=auto")))
                 (bashrc (list
                          (local-file
                           (string-append
                            (getenv "DOTFILES_DIR")
                            "/home-files/general/.bashrc")
                           "bashrc")))
                 (bash-profile (list
                                (local-file
                                 (string-append
                                  (getenv "DOTFILES_DIR")
                                  "/home-files/general/.bash_profile")
                                 "bash_profile")))))

      (service home-dotfiles-service-type
               (home-dotfiles-configuration
                 (source-directory
                  (string-append
                   (getenv "DOTFILES_DIR") "/home-files"))
                 (directories '("general" "lulu"))
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


      (service home-msmtp-service-type
               (home-msmtp-configuration
                 (defaults
                   (msmtp-configuration
                     (tls? #t)
                     (auth? #t)))
                 (accounts
                  (list
                   (msmtp-account
                     (name "Gmail")
                     (configuration
                      (msmtp-configuration
                        (host "smtp.gmail.com")
                        (port 587)
                        (user "kvp94best@gmail.com")
                        (from "kvp94best@gmail.com")
                        (password-eval "pass Mail/kvp94best@gmail.com"))))
                   (msmtp-account
                     (name "Yandex")
                     (configuration
                      (msmtp-configuration
                        (host "smtp.yandex.ru")
                        (port 587)
                        (user "kovalev.kovalev94@yandex.ru")
                        (from "kovalev.kovalev94@yandex.ru")
                        (password-eval "pass Mail/kovalev.kovalev94@yandex.ru"))))
                   (msmtp-account
                     (name "Apple")
                     (configuration
                      (msmtp-configuration
                        (host "smtp.mail.me.com")
                        (port 587)
                        (user "kovalev_94@icloud.com")
                        (from "kovalev_94@icloud.com")
                        (password-eval "pass Mail/kovalev_94@icloud.com"))))))))

      (service home-openssh-service-type
               (home-openssh-configuration
                 (hosts
                  (append
                   vpn-servers
                   personal-machines
                   work-machines
                   my-version-control
                   ipoint))
                 (authorized-keys '())
                 (add-keys-to-agent "120m")))))))

lulu-home
