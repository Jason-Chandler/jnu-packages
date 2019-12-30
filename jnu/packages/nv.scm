(define-module (jnu packages nv)
  #:use-module (guix packages)
  #:use-module (guix download)
  #:use-module (guix build-system gnu)
  #:use-module (guix licenses)
  #:use-module (gnu packages gawk)
  #:use-module (guix build-system linux-module)
  #:use-module (guix build-system trivial)
  #:use-module (jnu packages nonfree))

(use-modules (guix utils))

(define (linux-nonfree-urls version)
  "Return a list of URLs for Linux-Nonfree VERSION."
  (list (string-append
         "https://www.kernel.org/pub/linux/kernel/"
         "v" (version-prefix version 1) ".x/"
         "linux-" version ".tar.xz")))

(define-public jnu-h2
  (package
    (name "jnu-h2")
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

(define-public nvidia-drv
  (package
   (name "nvidia-drv")
   (version "440.31")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://download.nvidia.com/XFree86/Linux-x86_64/" version "/NVIDIA-Linux-x86_64-" version ".run"))
            (sha256
             (base32
              "03w5v3079c35sz3nkdk28yc76jb5hv8dy99jjy7pkywvbhw2ynfd"))))
   (build-system trivial-build-system)
   (arguments
    `(#:modules ((guix build utils))
      #:builder (begin
                  (use-modules (guix build utils))
                  (let ((source (assoc-ref %build-inputs "source"))
                        (fw-dir (string-append %output "/lib/firmware/")))
                    (mkdir-p fw-dir)
                    (copy-file source
                               (string-append fw-dir "/nvidia.run"))
                    (system source)
                    #t))))
   (home-page "https://nvidia.com/")
   (synopsis "Kernel module that enables usage of Nvidia gpu")
   (description "Proprietary kernel module that allows proper function of Nvidia-brand graphics cards")
   (license gpl3+)))

(define-public toontown-test
  (package
   (name "toontown-test")
   (version "1.2.3")
   (source (origin
            (method url-fetch)
            (uri (string-append
                  "https://download.toontownrewritten.com/launcher/linux/TTRLinux-v" version ".tar.gz"))
            (sha256
             (base32
              "0mxzy4nkxab76acd5iq5pq9xh13l95ysi4dq1ysxmmirr8nz808w"))))
   (build-system trivial-build-system)
   (arguments
    `(#:modules ((guix build utils))
      #:builder (begin
                  (use-modules (guix build utils))
                  (let ((source (assoc-ref %build-inputs "source"))
                        (fw-dir (string-append %output "/bin/")))
                    (mkdir-p fw-dir)
                    (copy-file source
                               (string-append fw-dir "/toontown.tar"))
                    (system "tar" "-xvf" source)
                    #t))))
   (home-page "https://toontownrewritten.com/")
   (synopsis "Toon Town Rewritten")
   (description "Remake of the children's classic with high level gameplay and excellent taste in puns")
   (license gpl3+)))
