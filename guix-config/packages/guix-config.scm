(define-module (guix-config packages guix-config)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix build-system guile)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages guile)
  #:use-module (guix-config channels))

(define-public guix-config-tool
  (package
    (name "guix-config-tool")
    (version "0.1")
    (source
     (local-file
      %distro-root-directory #:recursive? #t))
    (build-system guile-build-system)
    (arguments
     (list
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'build 'create-executable
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (bin (string-append out "/bin"))
                     ;; 2. Используем #$ для вставки program-file
                     (script
                      #$(program-file
                         "guix-config"
                         #~(begin
                             (use-modules (guix-config scripts guix-config))
                             (apply guix-config-main (command-line)))
                         #:guile guile-3.0)))
                (mkdir-p bin)
                (copy-file script (string-append bin "/guix-config"))
                (chmod (string-append bin "/guix-config") #o555)))))))
    (inputs
     (list guile-3.0 guix))
    (synopsis "Инструмент управления каналами")
    (description "Вызывает функции из модуля guix-config.")
    (home-page "https://example.com")
    (license #f)))
