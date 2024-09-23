(define-module (my-modules hosts)
  #:use-module (gnu services base)
  #:use-module (srfi srfi-9 gnu)
  #:export (add-domain))


(define (add-domain hosts-list domain-name)
  "Return new list of hosts with @var{aliases} field set to
@var{canonical-name} + @var{domain-name} from @var{hosts-lists}"
  (map
   (lambda (host)
       (if (host? host)
           (set-field
            host
            (host-aliases)
            (list(string-append (host-canonical-name host) "." domain-name)))))
   hosts-list))
