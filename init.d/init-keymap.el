;;;
;;; keymap setup
;;; personal mnemonics are better

(defvar jon/keymap '()
  "A list of (KEY . COMMAND) to set in the keymap")

(defvar jon/keymap/map (make-sparse-keymap)
  "Keymap for overrides and personal bindings")

(defun jon/keymap/bind (bind command &optional predicate)
  "Add a key binding from BIND to COMMAND to `jon/keymap/map'."
  (interactive "KKey Sequence? \naCommand? ")
  (bind-key bind command jon/keymap/map predicate))

(defun jon/keymap/unbind (bind)
  "Remove the key binding from BIND in `jon/keymap/map'."
  (interactive "k")
  (unbind-key bind jon/keymap/map))

(define-minor-mode jon/keymap-mode
  "Minor mode for custom keybinds"
  :global t
  :keymap jon/keymap/map
  (if jon/keymap-mode
      (progn
	(dolist (entry jon/keymap)
	  (let ((keys (car entry))
		(cmds (cdr entry)))
	    (bind-key keys cmds jon/keymap/map)))
	(message "Reloaded %s key-bindings..." (length jon/keymap)))))

;;;

(provide 'init-keymap)
