;;
;;; theme
;;; ui related stuff, in general

(req-package afternoon-theme :defer t)
(req-package dakrone-theme :defer t)

(req-package diminish)
(req-package guide-key
  :config (setq guide-key/guide-key-sequence t))

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

(defvar jon/theme/diminish nil
  "Defines modes to diminish away") 

;; minor mode for my styles, etc

(defun jon/theme-mode--reset-theme ()
  "Disables all enabled themes"
  (interactive)
  (mapcar #'disable-theme custom-enabled-themes))

(defun jon/theme-mode--wrap-load-theme (func &rest args)
  "Advice: load-theme should unload existing themes, and apply the overlay."
  (jon/theme-mode--reset-theme)
  (prog1
      (apply func args)
    (when jon/theme/overlay
      (message (format "adding overlay %s" jon/theme/overlay))
      (apply func `(,jon/theme/overlay)))))

(defun jon/theme-mode--enable ()
  "`jon/theme' was enabled, now what?"

  ;; wrap load-theme to unload existing themes, and apply the overlay.
  (advice-add 'load-theme :around 'jon/theme-mode--wrap-load-theme)

  ;; enable the configured theme
  (when jon/theme
    (load-theme jon/theme))
  
  ;; apply configured diminish profiles
  (dolist (entry jon/theme/diminish)
    (if (listp entry)
	(let ((feature (car entry))
	      (args    (cdr entry)))
	  (with-eval-after-load feature (apply 'diminish args)))
      (diminish entry)))
  
  ;; enable some modes
  (guide-key-mode t))

(defun jon/theme-mode--disable ()
  "`jon/theme' was disabled, now what?"
  (advice-remove 'load-theme 'jon/theme-mode--wrap-load-theme)
  (jon/theme-mode--reset-theme)
  (guide-key-mode nil))

(define-minor-mode jon/theme-mode 
  "Minor mode providing visual stuff."
  :global t
  (if jon/theme-mode
      (jon/theme-mode--enable)
    (jon/theme-mode--disable)))

;;;

(provide 'init-theme)
