#lang racket/base

(module reader syntax/module-reader
  (submod rkshell/private/lang base)
  #:wrapper1
  (lambda (read)
    (parameterize ([current-readtable rkshell-readtable]) (read)))

  (require "private/reader.rkt")
  (define rkshell-readtable (make-rkshell-readtable)))
