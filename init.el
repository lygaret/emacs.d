
;; bootstrap the configuration
;; the rest is defined in `lisp/init-*.el' files

(defmacro xx (&rest body) nil)
(defun emacsd (&optional path)
  "Return a path to a file in emacs.d"
  (expand-file-name (or path "") user-emacs-directory))

(add-to-list 'load-path (emacsd "init.d"))
(add-to-list 'load-path (emacsd "site-lisp"))

(xx require 'init-benchmark)

;; bootstrapping
(require 'init-bootstrap)
(require 'init-package)
(require 'init-defaults)

;; ui
(require 'init-theme)

;; features
(require 'init-evil)
(require 'init-tramp)
(require 'init-projectile)
(require 'init-helm)

;; applications
(require 'init-magit)
(require 'init-restclient)

;; key bindings

(define-minor-mode jon/custom-mode
  "Keymaps, just for me!? I'm touched!"
  :global t
  :keymap (let ((map (make-sparse-keymap)))
	    (bind-key "C-c g s" 'magit-status)
	    (bind-key "C-c g h" 'magit-log-buffer-file)
	    (bind-key "C-c g l" 'magin-log-current)
	    (bind-key "C-c p h" 'helm-projectile map)
	    (bind-key "C-c p p" 'helm-projectile-switch-project)
	    map))

(add-hook 'after-init-hook 'jon/custom-mode)

;; get the whole thing started

(req-package-finish)
