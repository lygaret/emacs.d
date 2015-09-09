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
  "The file that our emacs configuration comes from.")

(defvar init-source-el-file
  (expand-file-name "emacs.el" user-emacs-directory)
  "The file that our emacs configuration is generated into.")

;; load the org file iff it's newer than the generated el file
(if (file-exists-p init-source-org-file)
    (if (and (file-exists-p init-source-el-file)
	     (file-newer-than-file-p init-source-el-file init-source-org-file))
	(load-file init-source-el-file)
      (progn (require 'org)
	     (org-babel-load-file init-source-org-file)))
  (error "'%s' file is missing." init-source-org-file))
