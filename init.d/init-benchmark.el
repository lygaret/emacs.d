
;;; benchmark
;;; utilities and advice for transparency in startup times

(defun jon/bench/time-subtract-millis (b a)
  (* 1000.0 (float-time (time-subtract b a))))

(defun jon/bench/trace-require (req feature &rest args)
  "Trace calls to `require' with the elapsed time taken to load."
  (if (featurep feature)
      (apply req (cons feature args))
    (let ((start-time (current-time)))
      (prog1 (apply req (cons feature args))
	(let ((elapsed-time (jon/bench/time-subtract-millis (current-time) start-time)))
	  (message "require: %s (%s s)" feature elapsed-time))))))
  
(advice-add 'require :around 'jon/bench/trace-require)
      
;;;

(provide 'init-benchmark)
