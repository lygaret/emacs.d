
;; bootstrap the configuration
;; the rest is defined in `lisp/init-*.el' files

(defmacro xx (&rest body) nil)

(defmacro as-command (&rest body)
  `(lambda () (interactive) ,@body))

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
(require 'init-keymap)

;; features
(require 'rel-linum)
(require 'init-evil)
(require 'init-tramp)
(require 'init-projectile)
(require 'init-helm)

;; applications
(require 'init-magit)
(require 'init-restclient)

;; quick settings

(setq jon/theme  'whiteboard)
(setq jon/keymap '(("M-x"     . helm-M-x)
		   ("C-c m"   . jon/toggle-messages)
		   ("C-c b"   . helm-mini)
		   ("C-c g s" . magit-status)
		   ("C-c g h" . magit-log-buffer-file)
		   ("C-c g l" . magit-log-current)
		   ("C-c p h" . helm-projectile)
		   ("C-c p p" . helm-projectile-switch-project)
		   ("C-c p b" . helm-projectile-buffers-list)))

;; Library

(defun jon/toggle-messages ()
  (interactive)
  (message "hello")
  (unless (equal (buffer-name) "*Messages*")
    (display-buffer "*Messages*" 'display-buffer-pop-up-window)))

;; get the whole thing started

(req-package-finish)
