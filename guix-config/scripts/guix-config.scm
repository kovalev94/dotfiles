(define-module (guix-config scripts guix-config)
  #:use-module (guix describe)
  #:use-module (guix channels)
  #:use-module (ice-9 getopt-long)
  #:use-module (ice-9 match)
  #:use-module (guix build utils)
  #:use-module (ice-9 pretty-print)
  #:export (guix-config-main))


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


(define (guix-config-main . args)
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

