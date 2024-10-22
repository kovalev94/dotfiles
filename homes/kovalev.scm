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
             (gnu home services shells)
             (gnu home services ssh)
             (gnu home services desktop)
             (gnu home services dotfiles)
             (my-modules keyboard)
             ((my-modules ssh) #:prefix my:)
             ((mts ssh) #:prefix mts:))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "telegram-desktop"
                                            "qbittorrent"
                                            "ungoogled-chromium"
                                            "libreoffice"
                                            "obs"
                                            "nyxt"
                                            "emacs"
                                            "emacs-rg"
                                            "emacs-pdf-tools"
                                            "emacs-clang-format"
                                            "emacs-vterm"
                                            "dzen"
                                            "xftwidth"
                                            "font-google-noto-emoji"
                                            "font-gnu-unifont"
                                            "ripgrep"
                                            "kdenlive"
                                            "python-black"
                                            "python-isort"
                                            "imagemagick"
                                            "flameshot"
                                            "virt-manager"
                                            "vlc"
                                            "wireshark"
                                            "pulsemixer"
                                            "alacritty"
                                            "docker-compose"
                                            "node"
                                            "unison"
                                            "shellcheck"
                                            "python-pytest"
                                            "python-pyflakes"
                                            "python-nose"
                                            "sshfs"
                                            "minicom"
                                            "markdown"
                                            "lrzsz"
                                            "fping"
                                            "dia"
                                            "fd"
                                            "ccls"
                                            "libvterm"
                                            "font-fira-mono"
                                            "font-fira-sans"
                                            "font-fira-code")))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list
    (service home-ssh-agent-service-type)
    (service home-startx-command-service-type
             (xorg-configuration
              (keyboard-layout kb-layout)))
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
    (service home-openssh-service-type
             (home-openssh-configuration
              (hosts
               (append
                my:ssh-hosts
                mts:ssh-hosts))
             (authorized-keys '())
             (add-keys-to-agent "120m"))))))
