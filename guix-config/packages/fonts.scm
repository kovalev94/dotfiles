(define-module (guix-config packages fonts)
  #:use-module (guix download)
  #:use-module (guix packages)
  #:use-module (guix build-system font))

(define-public font-nerd-symbols-only
  (package
    (name "font-nerd-symbols-only")
    (version "3.4.0")
    (source
     (origin
       (method url-fetch)
       (uri (string-append "https://github.com/ryanoasis/nerd-fonts/releases/download/"
                           "v" version "/NerdFontsSymbolsOnly" ".zip"))
       (sha256
        (base32 "0iscas5bvb8bgk5pcls95nfwjl7yi23q05mili43dzl0p427jqcf"))))
    (build-system font-build-system)
    (home-page "https://www.nerdfonts.com")
    (synopsis "Just the Nerd Font Icons. I.e Symbol font only")
    (description
     "Nerd Fonts patches developer targeted fonts with a high number of glyphs (icons).
Specifically to add a high number of extra glyphs from popular ‘iconic fonts’
such as Font Awesome, Devicons, Octicons, and others.")
    (license #f)))
