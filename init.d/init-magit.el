;;;
;;; magit
;;; git is for smarter people than me.

(setq magit-last-seen-instructions "1.4.0")

(req-package magit
  :defer t)

(req-package magit-gitflow
  :require  magit
  :commands (turn-on-magit-gitflow)
  :init     (add-hook 'magit-mode-hook 'turn-on-magit-gitflow))

(defun jon/magit-projectile ()
  "Open `magit' for the project."
  (let ((pop-up-windows nil))
    (magit-status-internal (projectile-project-root))))

(add-hook
 'projectile-mode-hook
 (lambda () (setq projectile-switch-project-action 'jon/magit-projectile)))

;;;

(provide 'init-magit)
