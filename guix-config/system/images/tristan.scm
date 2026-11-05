(define-module (guix-config systems images tristan)
  #:use-module (gnu image)
  #:use-module (guix platforms arm)
  #:use-module (guix-config systems tristan)
  #:export (tristan-image))


(define-public tristan-image
  (image
    (format 'disk-image)
    (partition-table-type 'gpt)
    (partitions
     (list
      (partition
        (size (* 4 (expt 2 30)))
        (offset (expt 2 24))
        (label "Swap")
        (file-system "swap"))
      (partition
        (size 'guess)
        (label "Root")
        (flags '(boot))
        (file-system "ext4"))))
    (operating-system tristan-system)
    (platform aarch64-linux)
    (volatile-root? #f)))


tristan-image
