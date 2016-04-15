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

(req-package rel-linum
  :init (add-hook 'prog-mode-hook 'rel-linum-mode))

(with-eval-after-load 'comint
  (add-hook 'comint-mode-hook (lambda () (text-scale-set -1))))

(defvar jon/prog-keymap (make-sparse-keymap)
  "Keymap to hold programming level bindings, which is reinitialized per mode")

;;;

(provide 'init-programming)
