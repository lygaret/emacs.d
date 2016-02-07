
;;; restclient
;;; application for using HTTP documents

(req-package restclient-mode
  :mode "\\.http")

(defun jon/launch/restclient ()
  (interactive)
  (let ((buffer (get-buffer-create "*restclient*")))
    (switch-to-buffer buffer)
    (restclient-mode)))

;;;

(provide 'init-restclient)
