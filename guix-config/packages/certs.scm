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
         (let ((eltex-root-ca (assoc-ref %build-inputs "EltexRootCA.crt"))
               (eltex-rca (assoc-ref %build-inputs "Eltex_RCA.crt"))
               (out (string-append (assoc-ref %outputs "out") "/etc/ssl/certs"))
               (openssl (assoc-ref %build-inputs "openssl"))
               (perl (assoc-ref %build-inputs "perl")))
           (mkdir-p out)

           (for-each (lambda (cert)
                  (copy-file
                   cert (string-append
                         out "/" (strip-store-file-name cert))))
                (list eltex-root-ca eltex-rca))
           ;; Create hash symlinks suitable for OpenSSL ('SSL_CERT_DIR' and
           ;; similar.)
           (chdir (string-append %output "/etc/ssl/certs"))
           (invoke (string-append perl "/bin/perl")
                   (string-append openssl "/bin/c_rehash")
                   ".")))))
    (native-inputs
     (list openssl perl))
    (inputs
     `(; The Let's Encrypt root certificate, "ISRG Root X1".
       ("EltexRootCA.crt"
        ,(origin
           (method url-fetch)
           (uri "https://ca.eltex.loc/crt/EltexRootCA.crt")
           (sha256
            (base32
             "1hxc99axlgzhfnkas90lhas8iy1hgiqamy8s8ln7i7qx8nz3k626"))))
       ("Eltex_RCA.crt"
        ,(origin
           (method url-fetch)
           (uri "https://ca.eltex.loc/crt/Eltex_RCA.crt")
           (sha256
            (base32
             "0vfpjr7w2qigkf3mk31fmj8ihndc9krb4h47s1qiqaalpj06m0kr"))))))
    (home-page "https://ca.eltex.loc")
    (synopsis "Eltex root certificate")
    (description "This package provides a certificate store containing only the
Eltex root certificate.  It is intended to be used within Guix.")
    (license (undistributable "https://ca.eltex.loc"))))
