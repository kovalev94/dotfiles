(define-module (guix-config packages emacs-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix packages)
  #:use-module (guix git-download)
  #:use-module (guix build-system emacs)
  #:use-module (gnu packages emacs-xyz))


(define-public emacs-yasnippet-capf
  (let ((commit "f53c42a996b86fc95b96bdc2deeb58581f48c666")
        (revision "0")
        (url "https://github.com/elken/yasnippet-capf"))
    (package
      (name "emacs-yasnippet-capf")
      (version (git-version "0.1" revision commit))
      (source
       (origin
         (method git-fetch)
         (uri (git-reference
                (url url)
                (commit commit)))
         (file-name (git-file-name name version))
         (sha256
          (base32 "1hwsra5w150dfswkvw3jryhkg538nm3ig74xzfplzbg0n6v7qs19"))))
      (build-system emacs-build-system)
      (propagated-inputs
       (list emacs-yasnippet))
      (arguments (list #:tests? #f))      ; no test suite
      (home-page url)
      (synopsis
       "Completion-At-Point Extension for YASnippet.")
      (description
       "A simple capf (Completion-At-Point Function) for completing yasnippet snippets.")
      (license license:gpl3))))

;;- nerd-icons-corfu
