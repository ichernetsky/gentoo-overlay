
;;; scheme-complete site-lisp configuration

(add-to-list 'load-path "/usr/share/emacs/site-lisp/scheme-complete")
(autoload 'scheme-smart-complete "scheme-complete" nil t)
(autoload 'scheme-complete-or-indent "scheme-complete" nil t)
(autoload 'scheme-get-current-symbol-info "scheme-complete" nil t)
(eval-after-load 'scheme
  '(progn (define-key scheme-mode-map [tab] 'scheme-complete-or-indent)))
