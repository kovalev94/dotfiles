(define-module (my-modules hosts)
  #:use-module (gnu services base)
  #:use-module (srfi srfi-9 gnu)
  #:export (add-domain))


(define (add-domain hosts-list domain-name)
  "For each host in @var{hosts-list} - Append @var{domain-name} to @var{canonical-name}.
Set old value of @var{canonical-name} to @var{aliases}.
Data returned as new list,old data kept unmodified"
  (map
   (lambda (host)
       (if (host? host)
           (set-fields
            host
            ((host-canonical-name)
             (string-append (host-canonical-name host) "." domain-name))
            ((host-aliases)
             (list(host-canonical-name host))))))
   hosts-list))
