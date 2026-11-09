(define-module (guix-config packages ai)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages bash)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module (nonguix build-system binary))

;; Adapted from https://codeberg.org/gofranz/panther (px/packages/ai.scm).
(define-public opencode
  (package
    (name "opencode")
    (version "1.19.5")
    (source
     (origin
       (method url-fetch)
       (uri (string-append
             "https://github.com/anomalyco/opencode/releases/download/v"
             version "/opencode-linux-x64.tar.gz"))
       (sha256
        (base32 "0yk4q4zfyl9ndkbg635dz8z4b7b7dyr2a0izdgrrsfzs6sii10sq"))))
    (build-system binary-build-system)
    (arguments
     (list
      #:strip-binaries? #f
      #:validate-runpath? #f
      #:patchelf-plan
      #~'(("opencode" ()))
      #:install-plan
      #~'(("opencode" "bin/opencode-unwrapped"))
      #:phases
      #~(modify-phases %standard-phases
          (add-after 'install 'create-wrapper
            (lambda* (#:key inputs outputs #:allow-other-keys)
              (let* ((out (assoc-ref outputs "out"))
                     (bin (string-append out "/bin"))
                     (unwrapped (string-append bin "/opencode-unwrapped"))
                     (wrapper (string-append bin "/opencode")))
                (call-with-output-file wrapper
                  (lambda (port)
                    (format port "#!~a
export OPENCODE_DISABLE_AUTOUPDATE=1
exec ~a \"$@\"
"
                            (search-input-file inputs "bin/bash")
                            unwrapped)))
                (chmod wrapper #o755)))))))
    (inputs
     (list bash-minimal))
    (supported-systems '("x86_64-linux"))
    (home-page "https://opencode.ai")
    (synopsis "AI coding agent for the terminal")
    (description
     "OpenCode is an open source AI coding agent with a terminal user
interface.  It works with many model providers and can edit files, run
commands, and use language servers.  This package installs the upstream
prebuilt binary and disables auto-updates.")
    (license license:expat)))
