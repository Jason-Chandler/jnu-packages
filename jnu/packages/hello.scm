(define-module (jnu packages hello)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (guix licenses)
  #:use-module (gnu packages gawk))

(define-public jnu-hello
  (package
    (name "jnu-hello")
    (version "2.10")
    (source (origin
              (method url-fetch)
              (uri (string-append "mirror://gnu/hello/hello-" version
                                  ".tar.gz"))
              (sha256
               (base32
                "0ssi1wpaf7plaswqqjwigppsg5fyh99vdlb9kzl7c9lng89ndq1i"))))
    (build-system gnu-build-system)
    (arguments '(#:configure-flags '("--enable-silent-rules")))
    (inputs `(("gawk" ,gawk)))
    (synopsis "Hello, GNU world: An example GNU package")
    (description "Guess what GNU Hello prints!")
    (home-page "https://www.gnu.org/software/hello/")
    (license gpl3+)))

(define-public nvidia-module
  (package
   (name "nvidia-module")
   (version "440.31")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://download.nvidia.com/XFree86/Linux-x86_64/" version "/NVIDIA-Linux-x86_64-" version ".run"))
            (sha256
             (base32
              "cd592f385c9bfb798f973225dfd086654973984762b669c7d765b074c0d8850f"))))
   (build-system linux-module-build-system)
   (arguments
    ;; TODO: No tests?
    ;;`(#:tests? #f))
   (home-page "https://nvidia.com/")
   (synopsis "Kernel module that enables usage of Nvidia gpu")
   (description "Proprietary kernel module that allows proper function of Nvidia-brand graphics cards")
   (license license:proprietary))))
