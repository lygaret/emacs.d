;;
;; alert
;; show alerts because emacs is eating everything

(req-package alert
  :commands (alert)
  :init (progn (setq alert-default-style 'libnotify)))

;;

(provide 'init-alert)
