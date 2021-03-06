
;;; evil
;;;
;;; "As a poke at Emacs' creeping featurism, vi advocates have been known to
;;;  describe Emacs as "a great operating system, lacking only a decent editor".

(req-package evil
  :require  evil-surround evil-commentary evil-args evil-extra-operator
  :commands (evil-mode)
  :init     (progn
              (evil-mode 1)
              (evil-surround-mode 1)
              (evil-commentary-mode 1)
              (global-evil-extra-operator-mode 1)

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
