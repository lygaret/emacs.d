;;;
;;; projectile
;;; project navigation inside git dirs

(req-package projectile
  :init   (setq projectile-enable-caching t
		projectile-cache-file (emacsd "projectile.cache")
		projectile-known-projects-file (emacsd "projectile.index"))
  :config (projectile-global-mode))

;;;

(provide 'init-projectile)
