(define-module (guix-config packages certs)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial)
  #:use-module (nonguix licenses)
  #:use-module (gnu packages)
  #:use-module (gnu packages perl)
  #:use-module (gnu packages tls))


(define-public eltex-certs
  (package
    (name "eltex-certs")
    (version "1")
    (source #f)
    (build-system trivial-build-system)
    (arguments
     '(#:modules ((guix build utils))
       #:builder
       (begin
         (use-modules (guix build utils))
         (let ((eltex-ca (assoc-ref %build-inputs "EltexRootCA.crt"))
               (out (string-append (assoc-ref %outputs "out") "/etc/ssl/certs"))
               (openssl (assoc-ref %build-inputs "openssl"))
               (perl (assoc-ref %build-inputs "perl")))
           (mkdir-p out)
           ((lambda (cert)
              (copy-file
               cert (string-append
                     out "/" (strip-store-file-name cert))))
            eltex-ca)
           ;; Create hash symlinks suitable for OpenSSL ('SSL_CERT_DIR' and
           ;; similar.)
           (chdir (string-append %output "/etc/ssl/certs"))
           (invoke (string-append openssl "/bin/openssl")
                   "x509"
                   "-in"
                   "EltexRootCA.crt"
                   "-out"
                   "EltexRootCA.pem"
                   "-outform PEM")
           (invoke (string-append perl "/bin/perl")
                   (string-append openssl "/bin/c_rehash")
                   ".")))))
    (native-inputs
     (list openssl perl))                           ;for 'c_rehash'
    (inputs
     `(; The Let's Encrypt root certificate, "ISRG Root X1".
       ("EltexRootCA.crt"
        ,(origin
           (method url-fetch)
           (uri "https://intdocs.eltex.loc/download/attachments/337631/EltexRootCA.crt")
           (sha256
            (base32
             "00a9s6ny148wk50hyxrd7a2vkr3y7f6wiwx7sq1asbjla0wixrrn"))))))
    (home-page "https://intdoc.eltex.loc")
    (synopsis "Eltex root certificate")
    (description "This package provides a certificate store containing only the
Eltex root certificate.  It is intended to be used within Guix.")
    (license (undistributable "https://intdocs.eltex.loc"))))
