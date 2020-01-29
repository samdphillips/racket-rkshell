#lang racket/base

(require racket/port
         syntax/strip-context)

(provide make-rkshell-readtable)

(define (port-push-char a-char in-port name line col pos)
  (define ch-port
    (open-input-string (string a-char)))
  (define has-source-info?
    (and name line col pos))
  (define pre-port
    (if has-source-info?
        (relocate-input-port ch-port
                             #:name name
                             line col pos)
        ch-port))
  (input-port-append #t pre-port in-port #:name name))

(define ((make-read-shell-command parent-readtable) a-char in-port name line col pos)
  (define stx
    (parameterize ([current-readtable parent-readtable])
      (read-syntax name (port-push-char a-char in-port name line col pos))))
  (define tag
    (datum->syntax #f '#%rkexec stx))
  (strip-context
    (syntax-case stx ()
      [(x ...) #`(#,tag x ...)])))

(define (make-rkshell-readtable [a-readtable (current-readtable)])
  (make-readtable a-readtable
                  #\{
                  'dispatch-macro
                  (make-read-shell-command a-readtable)))

