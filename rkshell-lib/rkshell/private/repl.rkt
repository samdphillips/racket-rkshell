#lang racket/base

(provide rkshell-path
         rkshell-add-path!
         rkshell-find-in-path
         current-rkshell-path
         rkshell-repl-runner)

(require racket/string
         racket/system)

;; useful bits when running from the cli repl
(define (rkshell-path)
  (string-split (getenv "PATH") ":"))

(define (rkshell-add-path! p)
  (rkshell-set-path! (append (rkshell-path) (list p))))

(define (rkshell-set-path! paths)
  (putenv "PATH" (string-join paths ":")))

(define current-rkshell-path
  (make-derived-parameter
    current-environment-variables
    (lambda (v)
      (let ([env (environment-variables-copy (current-environment-variables))])
        (environment-variables-set! env #"PATH" (string->bytes/utf-8 (string-join v ":")))
        env))
    (lambda (env)
      (string-split
        (bytes->string/utf-8
          (environment-variables-ref env #"PATH"))
        ":"))))

(define (rkshell-find-in-path name)
  (for/or ([dir (in-list (rkshell-path))])
    (let ([full-name (build-path dir name)])
      (and (file-exists? full-name) full-name))))

(define (rkshell-repl-runner cmd . args)
  (apply system* (rkshell-find-in-path cmd) args))

