(define-module (guix-config packages golang-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (guix build-system go)
  #:use-module (gnu packages golang-build)
  #:use-module (guix git-download)
  #:use-module (guix packages)
  #:use-module (guix utils)
  #:use-module (gnu packages golang-xyz))

(define-public go-github-com-cweill-gotests
  (package
    (name "go-github-com-cweill-gotests")
    (version "1.9.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/cweill/gotests")
              (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1721gn6zp2bbnj92yh8jjn7yajms28d94xkfkck8kcxqb5nj07wp"))))
    (build-system go-build-system)
    (arguments
     (list
      #:install-source? #f
      #:import-path "github.com/cweill/gotests/gotests"
      #:unpack-path "github.com/cweill/gotests"))
    (propagated-inputs (list go-golang-org-x-tools))
    (home-page "https://github.com/cweill/gotests")
    (synopsis "gotests")
    (description
     "Package gotests contains the core logic for generating table-driven tests.")
    (license license:asl2.0)))


(define-public go-github-com-fatih-gomodifytags-next
  (package
    (name "go-github-com-fatih-gomodifytags-next")
    (version "1.17.0")
    (source
     (origin
       (method git-fetch)
       (uri (git-reference
              (url "https://github.com/fatih/gomodifytags")
              (commit (string-append "v" version))))
       (file-name (git-file-name name version))
       (sha256
        (base32 "1wzbz2fn3n4a9hbi96p0gdaly3rn5mzc9zk4k337dkf5dr2x4n2x"))))
    (build-system go-build-system)
    (arguments
     (list
      #:import-path "github.com/fatih/gomodifytags"))
    (propagated-inputs (list go-golang-org-x-tools
                             go-github-com-fatih-structtag
                             go-github-com-fatih-camelcase))
    (home-page "https://github.com/fatih/gomodifytags")
    (synopsis "gomodifytags")
    (description
     "Go tool to modify/update field tags in structs. @@code{gomodifytags} makes it
easy to update, add or delete the tags in a struct field.  You can easily add
new tags, update existing tags (such as appending a new key, i.e: @@code{db},
@@code{xml}, etc..) or remove existing tags.  It also allows you to add and
remove tag options.  It's intended to be used by an editor, but also has modes
to run it from the terminal.  Read the usage section below for more information.")
    (license license:bsd-3)))
