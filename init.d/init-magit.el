;;;
;;; magit
;;; git is for smarter people than me.

(setq magit-last-seen-instructions "1.4.0")

(req-package magit)
(req-package magit-gitflow
  :require magit
  :init    (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))

;;;

(provide 'init-magit)
