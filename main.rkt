#lang racket/base

(module reader syntax/module-reader
  rkshell/private/lang
  #:wrapper1
  (lambda (read)
    (parameterize ([current-readtable rkshell-readtable]) (read)))

  (require "private/reader.rkt")
  (define rkshell-readtable (make-rkshell-readtable)))
