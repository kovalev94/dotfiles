(define-module (guix-config homes lulu)
  #:use-module (gnu home)
  #:use-module (gnu services)
  #:use-module (gnu home services)
  #:use-module (gnu home services pm)
  #:use-module (gnu home services ssh)
  #:use-module (gnu home services dotfiles)
  #:use-module (guix-config ssh)
  #:use-module (guix-config homes desktop)
  #:export (lulu-home))


(define lulu-home
  (home-environment
    (inherit %my-desktop-home)
    (services
     (cons*
      (service home-batsignal-service-type)
      (modify-services (home-environment-user-services %my-desktop-home)
        (home-dotfiles-service-type
         config => (home-dotfiles-configuration
                     (inherit config)
                     (directories
                      (cons*
                       "lulu"
                       (home-dotfiles-configuration-directories config)))))
        (home-openssh-service-type
         config => (home-openssh-configuration
                     (inherit config)
                     (hosts
                      (append
                       work-machines
                       ipoint
                       (home-openssh-configuration-hosts config))))))))))


lulu-home
