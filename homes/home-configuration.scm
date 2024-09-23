;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
             (gnu packages)
             (gnu services)
             (guix gexp)
             (gnu home services shells)
             (gnu home services ssh))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (specifications->packages (list "telegram-desktop"
                                            "qbittorrent"
                                            "google-chrome-stable"
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
    (service home-bash-service-type
                  (home-bash-configuration
                   (aliases '(("grep" . "grep --color=auto") ("ll" . "ls -l")
                              ("ls" . "ls -p --color=auto")))
                   (bashrc (list (local-file
                                  "/home/kovalev/.guix-config/guix/homes/.bashrc"
                                  "bashrc")))
                   (bash-profile (list (local-file
                                        "/home/kovalev/.guix-config/guix/homes/.bash_profile"
                                        "bash_profile")))))
    (service home-openssh-service-type
              (home-openssh-configuration
               (hosts
                (list
                 (openssh-host
                  (name "test")
                  (user "testing")
                  (port 10022))))))
          )))
