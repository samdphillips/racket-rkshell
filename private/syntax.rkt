#lang racket/base

(require (for-syntax racket/base
                     racket/sequence
                     syntax/parse)
         racket/system
         syntax/parse/define)

(provide #%rkexec)

(define-simple-macro (#%rkexec xs:id ...+)
  #:with (s* ...)
  (for/list ([x (in-syntax #'(xs ...))])
    (datum->syntax x (symbol->string
                       (syntax->datum x))))
  (system* s* ...))
