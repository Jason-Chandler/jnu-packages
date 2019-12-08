(define-module (jnu packages helm)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system emacs)
  #:use-module (guix licenses))

(define-public jnu-helm
(package
  (name "emacs-helm")
  (version "20191206.1855")
  (source
    (origin
      (method url-fetch)
      (uri (string-append
             "https://melpa.org/packages/helm-"
             version
             ".tar"))
      (sha256
        (base32
          "172y2d0akfjcdzg9gqx74np5dkfa89q3kzgp1bhpsnz08py8ljs6"))))
  (build-system emacs-build-system)
  (propagated-inputs
    `(("emacs-async" ,emacs-async)
      ("emacs-popup" ,emacs-popup)
      ("emacs-helm-core" ,emacs-helm-core)))
  (home-page "https://emacs-helm.github.io/helm/")
  (synopsis
    "Helm is an Emacs incremental and narrowing framework")
  (description "No description available.")
  (license #f)))
