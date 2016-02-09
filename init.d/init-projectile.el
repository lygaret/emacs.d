;;;
;;; projectile
;;; project navigation inside git dirs

(req-package projectile
  :defer  nil
  :init   (setq projectile-enable-caching t
		projectile-cache-file (emacsd "projectile.cache")
		projectile-known-projects-file (emacsd "projectile.index")
		projectile-keymap-prefix "C-c M-p")
  :config (projectile-global-mode))

(req-package ag
  :defer    t)

(req-package helm-ag
  :require  (helm ag)
  :defer    t
  :commands (helm-ag-project-root))

(req-package helm-projectile
  :require  helm
  :defer    t
  :commands (helm-projectile helm-projectile-switch-project helm-projectile-buffers-list))

;;;

(provide 'init-projectile)
