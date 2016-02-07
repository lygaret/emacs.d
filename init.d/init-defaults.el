;;;
;;; defaults
;;; fix some weird stuff

;; reflect reality please
(global-auto-revert-mode t)

;; this is rediculous
(defalias 'yes-or-no-p 'y-or-n-p)

;; ido when not helm
(ido-mode t)
(setq ido-flex-matching t)

;; centralize backup files
(let ((backup-dir (expand-file-name "./backups" user-emacs-directory)))
  (setq backup-directory-alist `(("." . ,backup-dir))))

;; unique buffer names with directory names, not numbers
(req-package uniquify
  :config (progn
	    (setq uniquify-buffer-name-style 'forward)))

;; word-wrapping and highlight current line
(global-visual-line-mode)
(global-highline-mode)

;; don't delete the scratch buffer
(req-package persistent-scratch
  :init (persistent-scratch-setup-default))

;; put customize stuff in a separate file

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(defun jon/load-custom-file ()
  (when (file-exists-p custom-file)
    (load custom-file)))

(add-hook 'after-init-hook 'jon/load-custom-file)

;; midnight-mode
;; cleans up unmodified buffers that have been sitting around too long

(require 'midnight)
(midnight-delay-set 'midnight-delay "12:00am")
(setq midnight-period (* 1 60 60)
      clean-buffer-list-display-general 1)

;;;

(provide 'init-defaults)