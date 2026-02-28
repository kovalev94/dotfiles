(define-module (guix-config systems guix-installer)
  #:use-module (gnu system)
  #:use-module (nongnu system install)
  #:use-module (guix-config packages)
  #:use-module (guix-config keyboard)
  #:export (guix-installer-system))


(define-public guix-installer-system
  (operating-system
    (inherit installation-os-nonfree)

    (host-name "guix-installer")
    (locale "ru_RU.utf8")
    (timezone "Asia/Novosibirsk")

    (keyboard-layout %my-kb-layout)

    (packages
     (append
      %my-base-packages
      (operating-system-packages installation-os-nonfree)))))


guix-installer-system
