;;
;;; theme
;;; ui related stuff, in general

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



;; apply the theme after everything's ready to go

(add-hook
 'after-init-hook
 (lambda ()
   (require 'afternoon-theme)
   (load-theme 'afternoon t)))

;;;

(provide 'init-theme)
