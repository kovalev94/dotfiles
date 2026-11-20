(define-module (guix-config packages certs)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix git-download)
  #:use-module (guix build-system trivial)
  #:use-module (nonguix licenses)
  #:use-module (gnu packages)
  #:use-module (gnu packages tls))


(define-public eltex-certs
  (package
   (name "eltex-certs")
   (version "1")
   (source #f)
   (build-system trivial-build-system)
   (arguments
    (list
     #:modules '((guix build utils))
     #:builder
     #~(begin
         (use-modules (guix build utils))
         (let ((out (string-append #$output "/etc/ssl/certs"))
               (openssl #$(file-append openssl "/bin/openssl")))
           (mkdir-p out)
           (for-each
            (lambda (cert name)
              (let ((dest (string-append out "/" name)))
                ;; Нормализуем сертификат в PEM (поддерживает и PEM, и DER на входе)
                (unless (zero? (system* openssl "x509" "-in" cert "-out" dest))
                  (invoke openssl "x509" "-inform" "DER" "-in" cert "-out" dest))))
            (list #$(this-package-input "EltexRootCA.crt")
                  #$(this-package-input "Eltex_RCA.crt"))
            '("EltexRootCA.pem" "Eltex_RCA.pem"))
           (invoke openssl "rehash" out)))))
   (native-inputs
    (list openssl))
   (inputs
    `(("EltexRootCA.crt"
       ,(origin
         (method url-fetch)
         (uri "http://ca.eltex.loc/crt/EltexRootCA.crt")
         (sha256
          (base32
           "1hxc99axlgzhfnkas90lhas8iy1hgiqamy8s8ln7i7qx8nz3k626"))))
      ("Eltex_RCA.crt"
       ,(origin
         (method url-fetch)
         (uri "http://ca.eltex.loc/crt/Eltex_RCA.crt")
         (sha256
          (base32
           "0vfpjr7w2qigkf3mk31fmj8ihndc9krb4h47s1qiqaalpj06m0kr"))))))
   (home-page "https://eltex.loc")
   (synopsis "Eltex root certificates")
   (description "This package provides a certificate store containing only the
Eltex root certificates.  It is intended to be used within Guix.")
   (license (undistributable "https://eltex.loc"))))
