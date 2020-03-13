#lang racket/base

(module base racket/base
  (require "syntax.rkt")
  (provide (all-from-out racket/base "syntax.rkt")))

(module full racket
  (require "syntax.rkt")
  (provide (all-from-out racket "syntax.rkt")))
