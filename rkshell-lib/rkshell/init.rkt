#lang racket

;; setup for racket repl

(require rkshell/private/reader
         (submod rkshell/private/lang full))
(define rkshell-readtable (make-rkshell-readtable))
(current-readtable rkshell-readtable)
(provide (all-from-out (submod rkshell/private/lang full)))
