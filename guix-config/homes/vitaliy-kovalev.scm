(define-module (guix-config homes vitaliy-kovalev)
  #:use-module (gnu home)
  #:use-module (gnu packages)
  #:use-module (gnu packages wm)
  #:use-module (gnu packages vpn)
  #:use-module (gnu packages base)
  #:use-module (gnu packages sync)
  #:use-module (gnu packages fonts)
  #:use-module (gnu packages gnome)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages chromium)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages networking)
  #:use-module (gnu packages bittorrent)
  #:use-module (gnu packages libreoffice)
  #:use-module (gnu packages imagemagick)
  #:use-module (gnu packages web-browsers)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages video)
  #:use-module (nongnu packages chrome)
  #:use-module (gnu services)
  #:use-module (gnu services)
  #:use-module (gnu services xorg)
  #:use-module (guix gexp)
  #:use-module (gnu home services)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services mail)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services dotfiles)
  #:use-module (gnu home services syncthing)
  #:use-module (guix-config package-lists)
  #:use-module (guix-config keyboard)
  #:use-module (guix-config ssh))

;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.
(define-public vitaliy.kovalev-home
  (home-environment
   ;; Below is the list of packages that will show up in your
   ;; Home profile, under ~/.guix-home/profile.
   (packages
    (append
     (list
      glibc
      font-google-noto-emoji
      font-fira-mono
      font-fira-sans
      font-fira-code
      rclone
      google-chrome-stable
      wireshark
      wireguard-tools
      herbstluftwm
      libreoffice
      imagemagick
      alacritty
      bluez
      nyxt
      password-store
      rofi-pass
      gnupg
      ;telegram-desktop
      qbittorrent
      vlc)
     tiled-wm-toolkit
     emacs-toolkit
     python-tools
     golang-tools))

   ;; Below is the list of Home services.  To search for available
   ;; services, run 'guix home search KEYWORD' in a terminal.
   (services
    (list
     (service home-ssh-agent-service-type)
     (service home-gpg-agent-service-type
              (home-gpg-agent-configuration
               (pinentry-program
                (file-append pinentry-rofi "/bin/pinentry-rofi"))
               (default-cache-ttl 6000)
               (max-cache-ttl 7200)))
     (service home-startx-command-service-type
              (for-home (xorg-configuration
               (keyboard-layout kb-layout))))
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
               (directories '("general" "vitaliy.kovalev"))
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
             (name "Eltex")
             (configuration
              (msmtp-configuration
               (host "smtp.eltex.loc")
               (port 587)
               (user "vitaliy.kovalev@eltex.loc")
               (from "vitaliy.kovalev@eltex.loc")
               (password-eval "pass Eltex/LDAP/vitaliy.kovalev"))))))))

     (service home-openssh-service-type
              (home-openssh-configuration
               (hosts
                (append
                 vpn-servers
                 my-version-control))
               (authorized-keys (list
                                 (local-file
                                  (string-append
                                   (getenv "DOTFILES_DIR")
                                   "/home-files/vitaliy.kovalev/.ssh/keys/gawain.pub")
                                  "gawain.pub")))
               (add-keys-to-agent "120m")))))))

vitaliy.kovalev-home
