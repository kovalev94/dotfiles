(define-module (guix-config packages python-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages check)
  #:use-module (gnu packages sphinx)
  #:use-module (guix packages)
  #:use-module (guix gexp)
  #:use-module (guix build-system python)
  #:use-module (guix build-system pyproject)
  #:use-module (guix download))


(define-public python-parver
  (package
    (name "python-parver")
    (version "0.5")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "parver" version))
       (sha256
        (base32 "0xs7xcbrbgq25v85404aw5w5wp42v2lbxi7911zg1scwpgkf3zdr"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-arpeggio python-attrs
                             python-typing-extensions))
    (native-inputs (list python-doc8
                         python-flake8
                         python-hypothesis
                         python-pep8-naming
                         python-pretend
                         python-pytest
                         python-setuptools
                         python-wheel))
    (home-page "https://pypi.org/project/parver/")
    (synopsis "Parse and manipulate version numbers.")
    (description "Parse and manipulate version numbers.")
    (license license:expat)))

(define-public python-pipenv
  (package
    (name "python-pipenv")
    (version "2024.4.1")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pipenv" version))
       (sha256
        (base32 "116z98qm2yqyg4n605z0skrm2rq0k91xcyyz35f7vnndq42n3sp8"))))
    (build-system pyproject-build-system)
    (propagated-inputs (list python-certifi python-packaging python-setuptools
                             python-virtualenv))
    (arguments
     (list #:tests? #f)) ;; Temporary disable
    (native-inputs (list python-beautifulsoup4
    ;                     python-pytest-cov
                         python-black
                         python-flake8
                         python-flaky
                         python-invoke
                         python-mock
                         python-parver
                         python-pytest
                         python-pytest-timeout
                         python-pytest-xdist
    ;                     python-hypothesis
                         python-setuptools
                         python-sphinx
                         python-towncrier
                         python-wheel))
    (home-page "https://pipenv.pypa.io/en/latest/")
    (synopsis "Python Development Workflow for Humans.")
    (description "Python Development Workflow for Humans.")
    (license license:expat)))
