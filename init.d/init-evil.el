
;;; evil
;;;
;;; "As a poke at Emacs' creeping featurism, vi advocates have been known to
;;;  describe Emacs as "a great operating system, lacking only a decent editor".

(req-package evil
  :ensure   evil
  :commands (evil-mode)
  :init     (progn
              (evil-mode t)))

(req-package evil-surround
  :require evil
  :defer   nil
  :ensure  evil-surround
  :init    (add-hook 'evil-mode-hook 'evil-surround-mode))

(req-package evil-commentary
  :require evil
  :defer   nil
  :ensure  evil-commentary
  :init    (add-hook 'evil-mode-hook 'evil-commentary-mode))

(req-package evil-args
  :require evil
  :defer   nil
  :ensure  evil-args
  :config  (progn
	     (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
	     (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)

	     ;; bind evil-forward/backward-args
	     (define-key evil-normal-state-map "L" 'evil-forward-arg)
	     (define-key evil-normal-state-map "H" 'evil-backward-arg)
	     (define-key evil-motion-state-map "L" 'evil-forward-arg)
	     (define-key evil-motion-state-map "H" 'evil-backward-arg)

	     ;; bind evil-jump-out-args
	     (define-key evil-normal-state-map "K" 'evil-jump-out-args)))

;;;

(provide 'init-evil)
