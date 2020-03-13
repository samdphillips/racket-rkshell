#lang racket/base

(require racket/system)
(provide rkexec-runner)

(define rkexec-runner (make-parameter system*))
