;; keep track of loading time
(defconst emacs-start-time (current-time))
(defun my/msg-elapsed (template)
    (let ((elapsed (float-time
		    (time-subtract (current-time) emacs-start-time))))
      (message template elapsed)))

;; initialize elpa
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/")
	     '("melpa-stable" . "http://stable.melpa.org/packages/"))
(package-initialize)
(setq package-enable-at-startup nil)

(my/msg-elapsed "Finished loading packages in %.3fs")

;; keep customize it it's own file
(setq custom-file "~/.emacs.d/customize.el")
(when (file-exists-p custom-file)
  (load custom-file))

;; load the settings from org mode
(org-babel-load-file "~/.emacs.d/settings.org")

(my/msg-elapsed "Finished loading configuration in %.3fs")
 
(put 'dired-find-alternate-file 'disabled nil)
