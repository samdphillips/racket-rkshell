#lang racket/base

(require (for-syntax racket/base
                     racket/sequence
                     syntax/parse)
         racket/system
         syntax/parse/define)

(provide #%rkexec)

(begin-for-syntax
  (define (identifier->string id)
    (symbol->string (syntax-e id)))

  (define (exec-value-$var-id? id)
    (char=? #\$ (string-ref (identifier->string id) 0)))

  (define (exec-value-@var-id? id)
    (char=? #\@ (string-ref (identifier->string id) 0)))

  (define (exec-value-var-id id)
    (define id-str
      (substring (identifier->string id) 1))
    (datum->syntax id (string->symbol id-str)))

  (define-syntax-class rkexec-elem
    [pattern e:id
      #:when (exec-value-$var-id? #'e)
      #:with var (exec-value-var-id #'e)
      #:attr expr #'(unquote var)]
    [pattern e:id
      #:when (exec-value-@var-id? #'e)
      #:with var (exec-value-var-id #'e)
      #:attr expr #'(unquote-splicing var)]
    [pattern e:id
      #:attr expr
      (datum->syntax #'e (symbol->string (syntax->datum #'e)))]
    [pattern (e arg ...)
      #:attr expr #'(unquote (e arg ...))]))

(define-simple-macro (#%rkexec es:rkexec-elem ...+)
  (apply system* (quasiquote (es.expr ...))))
