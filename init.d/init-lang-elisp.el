;;;
;;; lang-elisp
;;; elisp editing specific stuff

(defun jon/lang/emacs-lisp--eval-last-sexp ()
  (interactive)
  (eval-last-sexp))

(defun jon/lang/emacs-lisp--eval-defun ()
  (interactive)
  (eval-defun))

(defun jon/lang/emacs-lisp-mode--enable ()
  (setq jon/prog--eval-last-sexp 'jon/lang/emacs-lisp--eval-last-sexp
        jon/prog--eval-defun 'jon/lang/emacs-lisp--eval-defun)
  (setq flycheck-disabled-checkers '(emacs-lisp-checkdoc)))

(add-hook 'emacs-lisp-mode-hook 'jon/lang/emacs-lisp-mode--enable)

;;;

(provide 'init-lang-elisp)
