;;;
;;; programming
;;; programming modes application configuration

(req-package rainbow-delimiters
  :init (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(req-package flycheck
  :init (progn (setq flyspell-prog-text-faces
		     '(font-lock-comment-face font-lock-doc-face))))

(req-package helm-dash
  :commands (helm-dash helm-dash-at-point))

(with-eval-after-load 'comint
  (add-hook 'comint-mode-hook (lambda () (text-scale-set -1))))

(setq-default indent-tabs-mode nil)
(setq-default tab-always-indent 'complete)

(defvar jon/prog--eval-last-sexp
  (lambda ()
    (message "Evaluation has not been configured in this mode."))
  "The function to run when `eval-last-sexp' is called.")

(defvar jon/prog--eval-defun
  (lambda ()
    (message "Evaluation has not been configured in this mode."))
  "The function to run when `eval-defun' is called.")

(defmacro jon/prog--call (v)
  `(lambda () (interactive) (funcall ,v)))

(setq jon/prog-keymap
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "e") (jon/prog--call jon/prog--eval-last-sexp))
    (define-key map (kbd "d") (jon/prog--call jon/prog--eval-defun))
    map))

(bind-key "C-c x" jon/prog-keymap)

;;;

(provide 'init-programming)
