;;;
;;; relative linum mode
;;; show the line number along with relative linumbers for the buffer

(defvar rel-linum--orig-format nil)
(defvar rel-linum--format-string "%4d")
(defvar rel-linum--current-line 0)

(defvar rel-linum-max-offset 15
  "Don't display relative distances further than this.")

(defface rel-linum
  '((default :inherit linum))
  "Face for relative line numbers in `rel-linum-mode'.")

(defface rel-linum-current
  '((default :inherit rel-linum))
  "Face for the current line in `rel-linum-mode'.")

(defun rel-linum--get-format-string ()
  (let* ((width  (length (number-to-string (count-lines (point-min) (point-max)))))
	 (format (concat "  %" (number-to-string width) "d")))
    (setq rel-linum--format-string format)))

(defun rel-linum--relative-line-numbers (line-number)
  (let ((offset (- line-number rel-linum--current-line)))
    (if (= offset 0)
	(propertize (format rel-linum--format-string line-number) 'face 'rel-linum-current)
      (propertize (format rel-linum--format-string (abs offset)) 'face 'rel-linum))))

(defun rel-linum--around-linum-update (func &rest args)
  (let ((rel-linum--current-line (line-number-at-pos)))
    (apply func args)))

(defun rel-linum--activate ()
  (linum-mode t)
  (setq rel-linum--orig-format linum-format
	linum-format 'rel-linum--relative-line-numbers
	linum-eager t)
  (add-hook 'linum-before-numbering-hook 'rel-linum--get-format-string)
  (advice-add 'linum-update :around 'rel-linum--around-linum-update))

(defun rel-linum--deactivate ()
  (setq linum-format rel-linum--orig-format
	rel-linum--orig-format nil)
  (remove-hook 'linum-before-numbering-hook 'rel-linum--get-format-string)
  (advice-remove 'linum-update 'rel-linum--around-linum-update)
  (linum-mode -1))

(define-minor-mode rel-linum-mode
  "Relative line numbering!"
  :lighter "rel"
  nil
  (if rel-linum-mode
      (rel-linum--activate)
    (rel-linum--deactivate)))

;;;

(provide 'rel-linum)
