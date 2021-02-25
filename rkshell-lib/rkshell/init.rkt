#lang racket

;; setup for racket repl

(require rkshell/private/reader
         rkshell/private/repl
         (submod rkshell/private/lang full))

(define rkshell-readtable (make-rkshell-readtable))
(current-readtable rkshell-readtable)

(rkexec-runner rkshell-repl-runner)

(provide (all-from-out rkshell/private/repl
                       (submod rkshell/private/lang full)))
