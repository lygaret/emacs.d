;;;
;;; relative linum mode
;;; show the line number along with relative linumbers for the buffer

(defcustom rel-linum-max-offset 15
  "Don't display relative distances further than this."
  :type '(integer))

(defcustom rel-linum-abs-window 0
  "Number of lines of absolute numbering around current line."
  :type '(choice (const :tag "No window - display 0 at the current line." nil)
                 (integer)))

(defcustom rel-linum-show-linum t
  "If true, show line numbers outside `rel-linum-max-offset'. Otherwise, display blanks instead."
  :type '(boolean))

(defface rel-linum
  '((default :inherit linum))
  "Face for relative line numbers in `rel-linum-mode'.")

(defface rel-linum-current
  '((default :inherit rel-linum))
  "Face for the current line in `rel-linum-mode'.")

(define-minor-mode rel-linum-mode
  "Relative line numbering!"
  :lighter "rel"
  nil
  (if rel-linum-mode
      (rel-linum--activate)
    (rel-linum--deactivate)))

;; private implementation

(defvar rel-linum--orig-format nil
  "The original linum-format, so we can reset it after turning `rel-linum' off.")

(defvar rel-linum--format-string nil
  "The current linum-format string, which is only updated on scroll.")

(defvar rel-linum--blank-string nil
  "The current blank string, which is only updated on scroll.")
  
(defvar rel-linum--current-line nil
  "The current line, which is used to cache the current line number during format string management.")

;;
;; linum-mode has nice feature, which is that one can set linum's format string (`linum-format')
;; to a function, which should return a formatted and propertized string. Additionally, that
;; function will get called every time the current line changes, since the function would need to be
;; able to change the face properties of the current line.
;;
;; functionally, all we need to do is use our rendering function as linum-format. this is painful however
;; because of how often it'll be called, so, we can specifically cache the following:
;;
;; 1. cache the current line, so the renderer doesn't have to call `line-number-at-pos' every line
;; 2. cache the format string to use, since it's dependant on the max width of the line-number strings
;;    for the current string.
;;

(defun rel-linum--linum-format (line-number)
  "Format the current line number as a relative number."
  (let ((offset (abs (- line-number rel-linum--current-line))))
    (if (<= offset (or rel-linum-abs-window -1))
	(propertize (format rel-linum--format-string line-number) 'face 'rel-linum-current)
      (if (< offset rel-linum-max-offset)
          (propertize (format rel-linum--format-string offset) 'face 'rel-linum)
        (if rel-linum-show-linum
            (propertize (format rel-linum--format-string line-number) 'face 'linum)
          rel-linum--blank-string)))))

(defun rel-linum--cache-format-strings ()
  "Figure out the current format strings based on the width of the numbers in the visible region."
  (let* ((width  (length (number-to-string (count-lines (point-min) (point-max)))))
	 (format (concat " %" (number-to-string width) "d")))
    (setq rel-linum--format-string format
          rel-linum--blank-string (propertize (make-string (+ width 1) ?\ ) 'face 'linum))))

(defun rel-linum--cache-current-line-advice (func &rest args)
  "Set rel-linum--current-line around the function."
  (let ((rel-linum--current-line (line-number-at-pos)))
    (apply func args)))

(defun rel-linum--activate ()
  (add-hook 'linum-before-numbering-hook 'rel-linum--cache-format-strings)
  (advice-add 'linum-update :around 'rel-linum--cache-current-line-advice)
  (linum-mode t)
  (setq rel-linum--orig-format linum-format
	linum-format 'rel-linum--linum-format
	linum-eager t))

(defun rel-linum--deactivate ()
  (setq linum-format rel-linum--orig-format
	rel-linum--orig-format nil)
  (remove-hook 'linum-before-numbering-hook 'rel-linum--cache-format-strings)
  (advice-remove 'linum-update 'rel-linum--cache-current-line-advice)
  (linum-mode -1))

;;;

(provide 'rel-linum)
