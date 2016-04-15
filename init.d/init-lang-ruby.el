;;;
;;; lang-ruby
;;; ruby mode stuff

;; important note:
;; enh-ruby-mode *completely replaces* ruby-mode
;; configuration for enh-ruby-mode doesn't require ruby-mode,
;; and expecting both will just load both and only use enh-ruby-mode.

(req-package enh-ruby-mode
  :mode (("Rakefile"    . enh-ruby-mode)
         ("Gemfile"     . enh-ruby-mode)
         ("Guardfile"   . enh-ruby-mode)
         ("\\.rb"       . enh-ruby-mode)
         ("\\.rabl"     . enh-ruby-mode)
         ("\\.ru"       . enh-ruby-mode)
         ("\\.rake"     . enh-ruby-mode)
         ("\\.jbuilder" . enh-ruby-mode)
         ("\\.gemspec"  . enh-ruby-mode)
         ("\\.simplecov". enh-ruby-mode))
  :init  (progn
           (setq enh-ruby-deep-indent-parent nil
                 enh-ruby-hanging-deep-indent-level 2)))

(req-package yaml-mode
  :mode (("\\.yaml"     . yaml-mode)
         ("\\.yml"      . yaml-mode)))

(req-package bundler)
                
(req-package inf-ruby
  :init (progn (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)))

(req-package rvm
  :init (progn (add-hook 'enh-ruby-mode-hook 'rvm-activate-corresponding-ruby)
               (advice-add 'inf-ruby-console-auto :before 'rvm-activate-corresponding-ruby)))

(req-package robe
  :init   (progn (add-hook 'enh-ruby-mode-hook 'robe-mode))
  :config (progn (jon/keymap/bind "C-c e h" 'robe-jump enh-ruby-mode-map)
                 (jon/keymap/bind "C-c e d" 'robe-doc  enh-ruby-mode-map)))

;; fix definition and send block to use enh-ruby stuff

(defun jon/lang/ruby/send-definition ()
  (interactive)
  (save-excursion
    (enh-ruby-beginning-of-defun)
    (let ((begin (point)))
      (enh-ruby-end-of-defun)
      (ruby-send-region begin (point)))))

(defun ruby-send-block ()
  (interactive)
  (save-excursion
    (enh-ruby-beginning-of-block)
    (let ((begin (point)))
      (enh-ruby-end-of-block)
      (ruby-send-region begin (point)))))

;;;

(provide 'init-lang-ruby)
