;;;
;;; projectile
;;; project navigation inside git dirs

(req-package projectile
  :init   (setq projectile-enable-caching t
		projectile-cache-file (emacsd "projectile.cache")
		projectile-known-projects-file (emacsd "projectile.index")
		projectile-keymap-prefix (kbd "C-c M-p"))
  :config (projectile-global-mode))

(req-package helm-ag
  :require  helm ag
  :commands (helm-ag-project-root))

(req-package helm-projectile
  :require  helm
  :commands (helm-projectile helm-projectile-switch-project helm-projectile-buffers-list))

;;;

(provide 'init-projectile)
