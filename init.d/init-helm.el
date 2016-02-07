;;;
;;; helm
;;;

(req-package helm
  :init (require 'helm-config))

(req-package helm-ag)
(req-package helm-projectile
  :commands (helm-projectile helm-projectile-switch-project helm-projectile-buffers-list))

;;;

(provide 'init-helm)
