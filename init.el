;;; init.el --- my initialization stuff
;;; Commentary:
;;; get er' done

;;; Code:
;; initialize elpa
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/")
	     '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)
(setq package-enable-at-startup nil)

;; bootstrapping configuration
(defvar init-source-org-file
  (expand-file-name "emacs.org" user-emacs-directory)
  "The file that our Emacs configuration comes from.")

(defvar init-source-el-file
  (expand-file-name "emacs.el" user-emacs-directory)
  "The file that our Emacs configuration is generated into.")

;; load the org file iff it's newer than the generated el file
(if (file-exists-p init-source-org-file)
    (if (and (file-exists-p init-source-el-file)
	     (file-newer-than-file-p init-source-el-file init-source-org-file))
	(load-file init-source-el-file)
      (progn (require 'org)
	     (org-babel-load-file init-source-org-file)))
  (error "'%s' file is missing" init-source-org-file))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(provide 'init)
;;; init.el ends here
