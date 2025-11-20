(define-module (guix-config packages telephony)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix git-download)
  #:use-module (guix build-system gnu)
  #:use-module (guix packages)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages tls)
  #:use-module (gnu packages pcre)
  #:use-module (gnu packages crypto)
  #:use-module (gnu packages autotools)
  #:use-module (gnu packages pkg-config)
  #:use-module (gnu packages compression)
  #:use-module (gnu packages ncurses))

(define-public sngrep
  (package
   (name "sngrep")
   (version "1.8.2")
   (source
    (origin
     (method git-fetch)
     (uri (git-reference
           (url "https://github.com/irontec/sngrep")
           (commit (string-append "v" version))))
     (file-name (git-file-name name version))
     (sha256 (base32 "0wcsbvay2jkaaqfcwrmsrzaakkgnav00d8rr1yx0c92ny7zr7ywy"))))
   (build-system gnu-build-system)
   (arguments
    `(#:configure-flags
      (list
       "--with-openssl" ;;Adds OpenSSL support to parse TLS captured messages (req. libssl)
       "--with-pcre" ;;Adds Perl Compatible regular expressions support in regexp fields
       "--with-zlib" ;;Enable zlib to support gzip compressed pcap files
       "--enable-unicode" ;;Adds Ncurses UTF-8/Unicode support (req. libncursesw5)
       "--enable-ipv6" ;;Enable IPv6 packet capture support.
       "--enable-eep" ;;Enable EEP packet send/receive support.
       )))
   (native-inputs
    (list autoconf
          automake
          pkg-config))
   (inputs
    (list ncurses
          libpcap
          openssl
          libxcrypt
          gnutls
          pcre
          zlib))
   (synopsis "Ncurses SIP Messages flow viewer.")
   (description "sngrep is a tool for displaying SIP calls message flows
from terminal. It supports live capture to display realtime SIP packets
and can also be used as PCAP viewer.")
   (home-page "https://github.com/irontec/sngrep")
   (license (list
             license:gpl3
             license:openssl))))
