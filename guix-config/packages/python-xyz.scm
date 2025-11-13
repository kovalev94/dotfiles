(define-module (guix-config packages python-xyz)
  #:use-module ((guix licenses) #:prefix license:)
  #:use-module (gnu packages python-xyz)
  #:use-module (gnu packages python-crypto)
  #:use-module (gnu packages python-build)
  #:use-module (gnu packages python-check)
  #:use-module (gnu packages check)
  #:use-module (gnu packages time)
  #:use-module (gnu packages sphinx)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix gexp)
  #:use-module (guix build-system python)
  #:use-module (guix build-system pyproject))


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
    (home-page "https://github.com/RazerM/parver")
    (synopsis "Parse and manipulate version numbers.")
    (description "Parse and manipulate version numbers.")
    (license license:expat)))

(define-public python-pipenv
  (package
    (name "python-pipenv")
    (version "2025.0.4")
    (source
     (origin
       (method url-fetch)
       (uri (pypi-uri "pipenv" version))
       (sha256
        (base32 "18npx2vjhbw1f504vf3rbcxylpg1qabb51zpm5c2znyc85w2mz1n"))))
    (build-system pyproject-build-system)
    (arguments
     (list #:tests? #f)) ; no tests in PyPI
    (propagated-inputs (list python-certifi python-packaging python-setuptools
                             python-virtualenv))
    (native-inputs (list python-beautifulsoup4
                         python-black
                         python-flake8
                         python-flaky
                         python-invoke
                         python-mock
                         python-parver
                         python-pytest
                         python-pytest-timeout
                         python-pytest-xdist
                         python-setuptools
                         python-sphinx
                         python-towncrier
                         python-wheel))
    (home-page "https://pipenv.pypa.io/en/latest/")
    (synopsis "Python Development Workflow for Humans.")
    (description "Python Development Workflow for Humans.")
    (license license:expat)))
