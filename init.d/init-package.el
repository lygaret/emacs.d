
;;; package
;;; initialize elpa, ensure req-package is installed, etc.

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))
(add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/"))

;; kick off package.el

(setq package-enable-at-startup nil)
(package-initialize)

;; ensure req-package is installed and available

(unless (package-installed-p 'req-package)
  (package-refresh-contents)
  (package-install 'req-package))

(setq use-package-verbose t)
(require 'req-package)

;;;

(provide 'init-package)
