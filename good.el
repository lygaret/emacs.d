(req-package guide-key
  :init   (guide-key-mode)
  :config (progn
            (setq guide-key/guide-key-sequence t)))

(req-package neotree
  :bind   (("C-c t" . neotree-toggle))
  :config (progn
            (with-eval-after-load 'projectile
              (add-hook 'projectile-switch-project-hook 'neotree-projectile-action))))

;; display whitespace
(setq whitespace-style '(face trailing tabs spaces newline empty indentation space-mark tab-mark newline-mark)
      whitespace-display-mappings '((space-mark 32 [183] [46])
                                    (newline-mark 10 [8629 10] [182 10])
                                    (tab-mark 9 [9655 9] [92 9])))

(defun projectile-magit ()
  "Open `magit' for the project, in a full-screen window."
  (interactive)
  (let ((pop-up-windows nil))
    (magit-status-internal (projectile-project-root))))

(req-package projectile
  :init (setq projectile-enable-caching t
              projectile-cache-file "~/.emacs.d/projectile.cache"
              projectile-known-projects-file "~/.emacs.d/projectile-bookmarks.eld"
              projectile-switch-project-action 'projectile-magit)
  :config (projectile-global-mode))

(req-package helm
  :commands (helm-M-x helm-mini helm-buffers-list)
  :bind     (("M-x" . helm-M-x)
             ("C-c b" . helm-buffers-list))
  :init     (require 'helm-config))

(req-package helm-projectile
  :require (helm projectile helm-ag)
  :bind    (("C-c p h" . helm-projectile)
            ("C-c p p" . helm-projectile-switch-project))
  :init    (helm-projectile-on))

(xx req-package smart-mode-line
  :init (progn (sml/setup)
               (setq-default sml/theme 'respectful
                             sml/name-width 0
                             sml/mode-width 'right
                             sml/shorten-directory t
                             sml/shorten-modes t)))

;; no one cares about file size
(size-indication-mode -1)

(req-package diminish
  :init (progn
          (diminish 'visual-line-mode)
          (with-eval-after-load "undo-tree"       (diminish 'undo-tree-mode))
          (with-eval-after-load "guide-key"       (diminish 'guide-key-mode))
          (with-eval-after-load "evil-commentary" (diminish 'evil-commentary-mode))
          (with-eval-after-load "flyspell"        (diminish 'flyspell-mode))))

(req-package evil-surround
  :require (evil evil-args evil-commentary)
  :init   (progn (evil-mode 1)
                 (evil-commentary-mode)
                 (global-evil-surround-mode 1))
  :config (progn
            (define-key evil-inner-text-objects-map "a" 'evil-inner-arg)
            (define-key evil-outer-text-objects-map "a" 'evil-outer-arg)))

(defvar my/org-filing-dir
  (cond ((on-host "beep") "~/sync/notes/")
        ((on-host "keymaster") "~/Dropbox/notes/")))

(req-package org-projectile
  :require org
  :demand t
  :bind   (("C-c oc" . org-capture)
           ("C-c oa" . org-agenda)
           ("C-c ol" . org-store-link))
  :config (progn
            ;; local plugins
            (require 'org-github-links)

            ;; syntax in blocks
            (setq org-src-fontify-natively t)

            ;; face definitions for todo states
            (setq org-todo-keyword-faces
                  '(("someday" . org-archived)
                    ("todo"    . org-warning)
                    ("done"    . org-done)))

            ;; allow refile at file level
            (setq org-refile-use-outline-path 'file)
            (setq org-refile-targets '((org-agenda-files :level . 1)))

            ;; settings capture template
            (setq org-agenda-files ()
                  org-capture-templates
                  '(("s" "Settings Idea" entry (file+headline "~/.emacs.d/emacs.org" "planning"))))

            ;; agenda and capture
            (if my/org-filing-dir
                (progn
                  (setq org-agenda-files (list my/org-filing-dir))
                  (let ((inbox   (concat (file-name-as-directory my/org-filing-dir) "inbox.org"))
                        (journal (concat (file-name-as-directory my/org-filing-dir) "journal.org"))
                        (project (concat (file-name-as-directory my/org-filing-dir) "projects.org")))
                    (setq org-projectile:projects-file project)
                    (add-to-list 'org-capture-templates
                                 (org-projectile:project-todo-entry
                                  "w" "* task %? %a\n" "Current Project Task"))
                    (add-to-list 'org-capture-templates
                                 `("e" "entry" entry (file+headline ,inbox "inbox"))
                                 "* %^{headline?} %U\n %\\1 $?")
                    (add-to-list 'org-capture-templates
                                 `("j" "journal" entry (file+datetree ,journal))
                                 "* $?")
                    (add-to-list 'org-capture-templates
                                 `("w" "clocked" entry (clock))
                                 "* $?"))))))

(setq magit-last-seen-instructions "1.4.0")
(req-package magit
  :bind (("C-c gs" . magit-status)
         ("C-c gh" . magit-log-buffer-file)
         ("C-c gl" . magit-log-current))
  :config (progn (require 'magit-gitflow)
                 (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)))

(req-package rainbow-delimiters
  :ensure t
  :init   (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))

(req-package flycheck
  :init (progn (global-flycheck-mode)

               ;; disable emacs-lisp-checkdoc
               (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc))

               ;; don't spell check in strings
               (setq flyspell-prog-text-faces
                     '(font-lock-comment-face font-lock-doc-face))))

;; spelling
(add-hook 'text-mode-hook (lambda () (flyspell-mode -1)))
(add-hook 'prog-mode-hook (lambda () (flyspell-prog-mode)))

(setq-default indent-tabs-mode nil)

(bind-key "C-c e SPC" 'eval-last-sexp)
(bind-key "C-c er" 'eval-region)
(bind-key "C-c ed" 'eval-defun)

(req-package enh-ruby-mode
  :require ruby-mode
  :mode    (("\\(Rake\\|Guard\\|Gem\\)file\\'" . enh-ruby-mode)
            ("\\.rb\\|\\.rabl\\|\\.ru\\|\\.builder\\|\\.rake\\|\\.jbuilder\\|\\.gemspec'" . enh-ruby-mode))
  :init    (progn
             (setq enh-ruby-deep-indent-parent nil
                   enh-ruby-hanging-deep-indent-level 2)))

(req-package inf-ruby
  :require enh-ruby-mode
  :init    (with-eval-after-load 'enh-ruby-mode
             (progn
               (add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
               (add-hook 'enh-ruby-mode-hook 'inf-ruby-minor-mode)

               ;; send the current line to inf-ruby
               (defun ruby-send-line ()
                 (interactive)
                 (save-excursion
                   (beginning-of-line)
                   (let ((begin (point)))
                     (end-of-line)
                     (ruby-send-region begin (point)))))

               ;; fix definition and send block to use enh-ruby stuff
               (defun ruby-send-definition ()
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

               (dolist (binding '(("C-c e RET" . ruby-send-line)
                                 ("C-c er" . ruby-send-region)
                                 ("C-c eb" . ruby-send-block)
                                 ("C-c ed" . ruby-send-definition)))
                 (let ((keys (kbd (car binding)))
                       (bind (cdr binding)))
                   (define-key inf-ruby-minor-mode-map keys bind))))))

(req-package projectile-rails
  :require projectile
  :init    (with-eval-after-load 'projectile-mode
             (add-hook 'projectile-mode-hook 'projectile-rails-on)))

(req-package rvm
  :require enh-ruby-mode
  :init    (progn
             (rvm-use-default)
             (add-hook 'enh-ruby-mode-hook (lambda () (rvm-activate-corresponding-ruby)))
             (defadvice inf-ruby-console-auto (before activate-rvm-for-robe activate)
               (rvm-activate-corresponding-ruby))))

(req-package robe
  :init  (progn
             (with-eval-after-load 'enh-ruby-mode
               (progn (add-hook 'enh-ruby-mode-hook 'robe-mode)
                      (define-key enh-ruby-mode-map (kbd "C-c eh") 'robe-jump)))))

(req-package bundler :defer t)

(req-package clojure-mode
  :require clojure-mode-extra-font-locking
  :mode    ("\\.edn$" "\\.boot$" "\\.cljs.*$" "\\.clj$" "lein-env")
  :config  (progn
             (add-hook 'clojure-mode-hook 'enable-paredit-mode)
             (add-hook 'clojure-mode-hook 'subword-mode)
             (add-hook 'clojure-mode-hook (lambda ()
                                            (setq inferior-lisp-program "lein repl")
                                            (font-lock-add-keywords
                                             nil
                                             '(("(\\(facts?\\)" (1 font-lock-keyword-face))
                                               ("(\\(backrgound?\\)" (1 font-lock-keyword-face))))
                                            (define-clojure-indent (fact 1))
                                            (define-clojure-indent (facts 2))))))

(req-package cider
  :require clojure
  :config  (progn
             (add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
             (add-hook 'cider-repl-mode-hook 'paredit-mode)
             (setq cider-show-error-buffer t
                   cider-auto-select-error-buffer t
                   cider-repl-history-file "~/.emacs.d/cider.history"
                   cider-repl-wrap-history t)))

(req-package js2-mode
  :mode    "\\.js\\'"
  :config  (progn
             (setq js2-highlight-level 3)))

(req-package ac-js2
  :require js2-mode
  :init    (add-hook 'js2-mode 'ac-js2-mode))

(req-package emmet-mode
  :init   (add-hook 'sgml-mode-hook 'emmet-mode)
  :config (progn
            (bind-key "C-SPC SPC" 'emmet-expand-line emmet-mode-keymap)))

(req-package rust-mode :mode "\\.rs\\'")

(req-package markdown-mode :mode "\\.md\\'")

;; open settings
(defun edit-settings-file ()
  (interactive)
  (find-file-other-window "~/.emacs.d/emacs.org"))
(global-set-key (kbd "C-c ~") 'edit-settings-file)

;; open inbox org
(defun edit-inbox-file ()
  (interactive)
  (find-file-other-window (concat my/org-filing-dir "inbox.org")))
(global-set-key (kbd "C-c oo") 'edit-inbox-file)

(req-package-finish)
