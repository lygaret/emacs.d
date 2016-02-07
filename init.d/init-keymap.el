;;;
;;; keymap setup
;;; personal mnemonics are better

(defvar jon/keymap '()
  "A list of (KEY . COMMAND) to set in the keymap")

(defvar jon/keymap/map (make-sparse-keymap)
  "Keymap for overrides and personal bindings")

(define-minor-mode jon/keymap-mode
  "Minor mode for custom keybinds"
  :global t
  :keymap jon/keymap/map)

(defun jon/keymap/bind (bind command &optional predicate)
  "Add a key binding from BIND to COMMAND to `jon/keymap/map'."
  (bind-key bind command jon/keymap/map predicate))

(defun jon/keymap/unbind (bind)
  "Remove the key binding from BIND in `jon/keymap/map'."
  (interactive "k")
  (unbind-key bind jon/keymap/map))

(add-hook
 'after-init-hook
 (lambda ()
   (dolist (keybind jon/keymap)
     (bind-key (car keybind) (cdr keybind) jon/keymap/map)))) 

(add-hook 'after-init-hook 'jon/keymap-mode)

;;;

(provide 'init-keymap)
