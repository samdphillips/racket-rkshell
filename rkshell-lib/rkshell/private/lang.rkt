#lang racket/base

(module base racket/base
  (require "runtime.rkt"
           "syntax.rkt")
  (provide (all-from-out racket/base "runtime.rkt" "syntax.rkt")))

(module full racket
  (require "runtime.rkt"
           "syntax.rkt")
  (provide (all-from-out racket "runtime.rkt" "syntax.rkt")))
