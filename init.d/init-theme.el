;;
;;; theme
;;; ui related stuff, in general

(req-package afternoon-theme :defer t)
(req-package dakrone-theme :defer t)

(defun reset-themes ()
  "Disables all enabled themes"
  (interactive)
  (mapcar #'disable-theme custom-enabled-themes))

;; splash screen
(setq inhibit-startup-screen t)

;; hide menus and such
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; new frames
(setq default-frame-alist
      `((menu-bar-lines . 0)
	(tool-bar-lines . 0)
	(vertical-scroll-bars 0)))

;; set the initial theme

(defvar jon/theme nil
  "Defines the theme to load by default")

(defvar jon/theme/overlay nil
  "Defines the theme to apply after the selected theme")

;; clear out old themes before applying a new one, and always apply the overlay

(add-hook
 'after-init-hook
 (lambda ()
   (when jon/theme
     (load-theme jon/theme))))

(advice-add
 'load-theme :around
 (lambda (func &rest args)
   (reset-themes)
   (prog1
       (apply func args)
     (when jon/theme/overlay
       (message (format "adding overlay %s" jon/theme/overlay))
       (apply func `(,jon/theme/overlay))))))

;;;

(provide 'init-theme)
