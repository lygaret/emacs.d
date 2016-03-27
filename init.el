;;
;; bootstrap the configuration
;; the rest is defined in `lisp/init-*.el' files

(defmacro xx (&rest body) nil)
(defun emacsd (&optional path)
  "Return a path to a file in emacs.d"
  (expand-file-name (or path "") user-emacs-directory))

(add-to-list 'load-path (emacsd "init.d"))
(add-to-list 'load-path (emacsd "user-lisp"))
(add-to-list 'load-path (emacsd "site-lisp"))
(add-to-list 'custom-theme-load-path (emacsd "site-lisp"))

;; bootstrapping
(require 'init-bootstrap)
(require 'init-package)
(require 'init-defaults)

;; ui
(require 'init-theme)
(require 'init-keymap)

;; features
(require 'init-evil)
(require 'init-tramp)
(require 'init-projectile)
(require 'init-helm)
(require 'init-alert)

;; applications
(require 'init-magit)
(require 'init-restclient)
(require 'init-github)
(require 'init-slack)

(require 'init-programming)
(require 'init-lang-elisp)
(require 'init-lang-ruby)

(require 'init-lang-markdown)

;; quick settings

(setq jon/theme 'material
      jon/theme/overlay 'material-overlay)

(setq jon/theme/diminish
      '(undo-tree-mode
	auto-revert-mode
	("guide-key" guide-key-mode)))

(setq jon/keymap
      '(("M-x"     . helm-M-x)
	("C-c b"   . helm-mini)
	("C-c g s" . magit-status)
	("C-c g l" . magit-log-current)
	("C-c p h" . helm-projectile)
	("C-c p p" . helm-projectile-switch-project)
	("C-c p s" . helm-ag-project-root)
	("C-c p b" . helm-projectile-buffers-list)
        ("C-c e"   . jon/prog-keymap)))

(add-hook 'after-init-hook 'jon/theme-mode)
(add-hook 'after-init-hook 'jon/keymap-mode)

;; get the whole thing started

(req-package-finish)

(put 'dired-find-alternate-file 'disabled nil)
