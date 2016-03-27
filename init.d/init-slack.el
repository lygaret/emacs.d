;;;
;;; slack
;;; at least it's not skype

(req-package slack
  :require  alert
  :commands (slack-start)

  :init
  (progn
    (require 'cl)
    (setq slack-prefer-current-team t))

  :config
  (progn
    (require 'private)
    (jon/private/register-slack-teams)))

;;;

(provide 'init-slack)
