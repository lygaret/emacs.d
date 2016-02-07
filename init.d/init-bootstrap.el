
;;; bootstrap
;;; get everything started

;; reduce gc during startup

(defconst jon/initial-gc-threshold gc-cons-threshold
  "Initial value of `gc-cons-threshold' at start-up time.")

(setq gc-cons-threshold (* 128 1024 1024))

(add-hook
 'after-init-hook
 (lambda () (setq gc-cons-threshold jon/initial-gc-threshold)))

;;;

(provide 'init-bootstrap)
