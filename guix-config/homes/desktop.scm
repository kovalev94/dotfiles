(define-module (guix-config homes desktop)
  #:use-module (guix gexp)
  #:use-module (gnu home)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu services)
  #:use-module (gnu services xorg)
  #:use-module (gnu home services)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services mail)
  #:use-module (gnu home services desktop)
  #:use-module (gnu home services dotfiles)
  #:use-module (guix-config packages)
  #:use-module (guix-config keyboard)
  #:use-module (guix-config doom-modules-packages)
  #:use-module (guix-config homes base)
  #:export (%my-desktop-home))


(define %my-desktop-home
  (home-environment
    (inherit %my-base-home)
    (packages
     (append
      doom-module-corfu-packages
      doom-module-magit-packages
      doom-module-dired-packages
      %my-emacs-packages))
    (services
     (append
      (list
       (service home-startx-command-service-type
                (for-home (xorg-configuration
                            (keyboard-layout %my-kb-layout))))
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
                         (password-eval "pass Mail/kovalev_94@icloud.com")))))))))
      (modify-services (home-environment-user-services %my-base-home)
        (home-gpg-agent-service-type
         config => (home-gpg-agent-configuration
                     (inherit config)
                     (pinentry-program
                      (file-append
                       pinentry-rofi
                       "/bin/pinentry-rofi"))))
        (home-dotfiles-service-type
         config => (home-dotfiles-configuration
                     (inherit config)
                     (directories
                      (cons*
                       "desktop"
                       (home-dotfiles-configuration-directories config))))))))))
