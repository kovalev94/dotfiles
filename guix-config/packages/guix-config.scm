(define-module (guix-config packages guix-config)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (guix build-system trivial)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages guile))

(define-public guix-config-tool
  (package
    (name "guix-config-tool")
    (version "0.1")
    (source #f)
    (build-system trivial-build-system)
    (arguments
     (list
      #:modules '((guix build utils))
      #:builder
      #~(begin
          (use-modules (guix build utils))
          (let*
              ((out (assoc-ref %outputs "out"))
               (bin (string-append out "/bin"))
               (guix (assoc-ref %build-inputs "guix"))
               (guile (assoc-ref %build-inputs "guile"))
               (script
                #$(program-file
                   "guix-config"
                   #~(begin
                       (use-modules (guix describe)
                                    (guix channels)
                                    (ice-9 match)
                                    (guix build utils)
                                    (ice-9 getopt-long)
                                    (ice-9 match)
                                    (ice-9 pretty-print))

                       ;; Копируем сюда ваши функции
                       (define (channels-with-update target-channel-name)
                         (map (lambda (chan)
                                (if (eq? (channel-name chan) target-channel-name)
                                    (channel
                                      (inherit chan)
                                      (commit #f))
                                    chan))
                              (current-channels)))

                       (define (guix-config-pull channels)
                         (let ((temp-file "/tmp/guix-config-channels.scm"))

                           (dynamic-wind
                             (lambda ()
                               (with-output-to-file temp-file
                                 (lambda ()
                                   (pretty-print `(list ,@(map channel->code channels))))))
                             (lambda ()
                               (invoke "guix" "pull" "-C" temp-file))
                             (lambda ()
                               (when (file-exists? temp-file)
                                 (delete-file temp-file))))))

                       (define (guix-config-main args)
                         (let* ((option-spec '((help (single-char #\h) (value #f))))
                                (options (getopt-long args option-spec))
                                (free-args (option-ref options '() '())))

                           (match free-args
                             (("pull" target-name)
                              (guix-config-pull (channels-with-update (string->symbol target-name))))

                             (("pull")
                              (display "Error: please specify channel name.")
                              (display "Example: guix-config pull dotfiles\n"))

                             (other
                              (display "Usage: guix-config pull <channel-name>\n")
                              (display "example: guix-config pull dotfiles\n")))))

                       (guix-config-main (command-line)))
                   #:guile guile-3.0
                   #:module-path (file-append guix "share/guile/site/3.0"))))
            (mkdir-p bin)
            (symlink script (string-append bin "/guix-config"))))))
    (inputs (list guile-3.0 guix))
    (synopsis "Простая утилита для Guix")
    (description "Весь код встроен в пакет.")
    (home-page #f)
    (license #f)))
