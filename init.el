;;;;; init --- Summary

;;;; Emacs Init file

;;;; Commentary:

;;;; Code:

;;; Setting the path
(let* ((extra '("/usr/local/texbin" "/usr/local/bin" "/Applications/ghc-7.8.4.app/Contents/bin"))
       (extra-path-form (mapconcat (lambda (x) (concat ":" x)) extra "")))
  (setenv "PATH" (concat (getenv "PATH") extra-path-form))
  (setq exec-path (append exec-path extra)))

;;;; Packages

;;; Set sources
;; TODO Move this into custom.el and change custom-file to suit
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks")
 '(cdlatex-paired-parens "$")
 '(custom-safe-themes
   (quote
    ("ffe39e540469ef05808ab4b75055cc81266875fa4a0d9e89c2fec1da7a6354f3" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" default)))
 '(js2-basic-offset 2)
 '(mac-option-modifier (quote meta))
 '(mac-right-option-modifier (quote hyper))
 '(nil nil t)
 '(org-agenda-files
   (quote
    ("~/.org/emacs.org" "~/.org/tasks.org" "~/.org/notes.org")))
 '(package-archives
   (quote
    (("melpa" . "http://melpa.org/packages/")
     ("melpa-stable" . "http://stable.melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")))))

(package-initialize)

;;; Use package Setup
(package-install 'use-package)
(package-install 'diminish)
(package-install 'bind-key)
(eval-when-compile
  (require 'use-package))
(require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant


;;; Haskell
(use-package haskell-mode
  :config (progn
	    (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
	    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)))

;;; Solarized theme
;; (use-package solarized-theme
;;   :config (progn
;;	    (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;;	    (load-theme 'solarized t))
;;   :ensure t)

;;; Ample theme
;; (use-package ample-theme
;;   :config (progn (load-theme 'ample t t)
;;		 (load-theme 'ample-flat t t)
;;		 (load-theme 'ample-light t t)
;;		 (enable-theme 'ample-flat))
;;   :ensure t)

;;; Aurora Theme
(use-package leuven-theme
  :config (progn
	    (load-theme 'leuven t t))
  :ensure t)

;;; Winner Mode
(use-package winner
  :config (winner-mode 1))

;;; Undo Tree
(use-package undo-tree
  :config (progn
	    (global-undo-tree-mode)
	    (setq undo-tree-visualizer-timestamps t
		  undo-tree-visualizer-diff t))
  :diminish undo-tree-mode
  :ensure t)

;;; Evil Mode
(use-package evil
  :config (progn
	    ;; Redefining Keys
	    (evil-declare-key 'normal global-map (kbd "C-e") 'evil-end-of-line)
	    (evil-declare-key 'insert global-map (kbd "C-e") 'end-of-line)
	    (mapc (lambda (state)	; For some reason this only works with mapcar
		    ;; (evil-declare-key state global-map (kbd "C-f") 'evil-forward-char)
		    ;; (evil-declare-key state global-map (kbd "C-b") 'evil-backward-char)
		    ;; (evil-declare-key state global-map (kbd "C-d") 'evil-delete-char)
		    ;; (evil-declare-key state global-map (kbd "C-n") 'evil-next-line)
		    ;; (evil-declare-key state global-map (kbd "C-p") 'evil-previous-line)
		    (evil-declare-key state global-map (kbd "C-w") 'evil-delete)
		    (evil-declare-key state global-map (kbd "C-y") 'yank)
		    (evil-declare-key state global-map (kbd "C-k") 'kill-line))
		  '(normal insert visual))

	    (define-key evil-normal-state-map (kbd "q") nil)

	    ;; Fixing up certain states
	    (evil-set-initial-state 'magit-mode 'emacs)
	    (evil-set-initial-state 'magit-mode 'emacs)
	    (evil-set-initial-state 'magit-popup-mode 'emacs)
	    (evil-set-initial-state 'org-mode 'emacs)
	    (evil-set-initial-state 'sql-interactive-mode 'emacs)
	    (evil-set-initial-state 'neotree-mode 'emacs)

	    (evil-mode 1))
  :ensure t)

;;; Rainbow Delimiters
(use-package rainbow-delimiters
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  :ensure t
  :pin melpa-stable)

;;; Magit
(use-package magit
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch-popup))
  :ensure t
  :pin melpa-stable)

;;; Helm
(use-package helm
  :config (progn
	    (require 'helm-config)
	    (setq helm-candidate-number-limit           100
		  helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
		  helm-input-idle-delay 0.01  ; this actually updates things
					; reeeelatively quickly.
		  helm-yas-display-key-on-candidate t
		  helm-quick-update t
		  helm-M-x-requires-pattern nil
		  helm-ff-skip-boring-files             t
		  helm-split-window-in-side-p           t
		  helm-move-to-line-cycle-in-source     t
		  helm-ff-search-library-in-sexp        t
		  helm-scroll-amount                    8
		  helm-ff-file-name-history-use-recentf t)
					; rebind tab to run persistent action
	    (define-key helm-command-map (kbd "<tab>")
	      'helm-execute-persistent-action)
					; make TAB works in terminal
	    (define-key helm-command-map (kbd "C-i")
	      'helm-execute-persistent-action)
					; list actions using C-z
	    (define-key helm-command-map (kbd "C-z")
	      'helm-select-action)

	    (when (executable-find "curl")
	      (setq helm-google-suggest-use-curl-p t))

	    (helm-mode t))
  :bind (("C-x C-f" . helm-find-files)
	 ("C-c h" . helm-mini)
	 ("C-h a" . helm-apropos)
	 ("C-x C-b" . helm-buffers-list)
	 ("C-x b" . helm-buffers-list)
	 ("M-y" . helm-show-kill-ring)
	 ("M-x" . helm-M-x)
	 ("C-x c o" . helm-occur)
	 ("C-x c s" . helm-swoop)
	 ("C-x c y" . helm-yas-complete)
	 ("C-x c Y" . helm-yas-create-snippet-on-region)
	 ("C-x c b" . my/helm-do-grep-book-notes)
	 ("C-x c SPC" . helm-all-mark-rings))
  :diminish helm-mode
  :ensure t)

(use-package helm-dash
  :if 'helm
  :ensure t)

(use-package helm-ag
  :ensure t)

(use-package perspective
  :ensure t)

(use-package projectile
  :ensure t)

(use-package persp-projectile
  :ensure t)

(use-package helm-projectile
  :ensure t)

(use-package bookmark+
  :config (progn
	    (setq desktop-globals-to-save
		  (append '((comint-input-ring . 50)
			    (compile-history . 30)
			    desktop-missing-file-warning
			    (dired-regexp-history . 20)
			    (extended-command-history . 30)
			    (face-name-history . 20)
			    (file-name-history . 100)
			    (grep-find-history . 30)
			    (grep-history . 30)
			    (ido-buffer-history . 100)
			    (ido-last-directory-list . 100)
			    (ido-work-directory-list . 100)
			    (ido-work-file-list . 100)
			    (magit-read-rev-history . 50)
			    (minibuffer-history . 50)
			    (org-clock-history . 50)
			    (org-refile-history . 50)
			    (org-tags-history . 50)
			    (query-replace-history . 60)
			    (read-expression-history . 60)
			    (regexp-history . 60)
			    (regexp-search-ring . 20)
			    register-alist
			    (search-ring . 20)
			    (shell-command-history . 50)
			    tags-file-name
			    tags-table-list))))
  :ensure t)

;; (use-package smart-mode-line
;;   :config (progn
;;	    (setq sml/theme 'dark)
;;	    (setq-default
;;	     mode-line-format
;;	     '("%e"
;;	       mode-line-front-space
;;	       mode-line-mule-info
;;	       mode-line-client
;;	       mode-line-modified
;;	       mode-line-remote
;;	       mode-line-frame-identification
;;	       mode-line-buffer-identification
;;	       "   "
;;	       mode-line-position
;;	       (vc-mode vc-mode)
;;	       "  "
;;	       mode-line-modes
;;	       mode-line-misc-info
;;	       mode-line-end-spaces))
;;	    (sml/setup))
;;   :ensure t)

;;; Guide Key - Show help on delay of key input
(use-package guide-key
  :config (progn
	    (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-c"))
	    (guide-key-mode 1))
  :ensure t
  :diminish guide-key-mode)

;;; Fly Check
(use-package flycheck
  :config (add-hook 'programming-mode-hook #'flycheck-mode)
  :ensure t)

;;; Agressive Indent
(use-package aggressive-indent
  :ensure t)

;;; AucTex
(use-package tex-site
  :config (progn
	    (add-hook 'TeX-mode-hook
		      (lambda () (TeX-fold-mode 1)))
	    (setq TeX-auto-save t
		  TeX-parse-self t)
	    (setq-default TeX-master nil)
	    (add-hook 'LaTeX-mode-hook 'turn-on-reftex))
  :ensure auctex)

(use-package cdlatex
  :config (progn
	    (add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
	    (setq cdlatex-math-symbol-alist '((?- ("\\cap" "\\leftrightarrow" "\\longleftrightarrow"))
					      (?p ("\\pi" "\\Pr(?)" "\\varpi")))))
  :ensure t)


;;; Whitespace Cleanup
(use-package whitespace-cleanup-mode
  :config (global-whitespace-cleanup-mode t)
  :diminish whitespace-cleanup-mode
  :ensure t)

;;; Smart Mode Line
;; (use-package smart-mode-line
;;   :config (progn
;;	    (setq sml/theme 'respectful)
;;	    (sml/setup))
;;   :ensure t)

;;; Org Mode
(use-package org
  :config (progn
	    (setq org-directory "~/.org/")
	    ;; (let ((notes (concat org-directory "/notes.org")))
	    ;;   (setq org-default-notes-file notes
	    ;;	    org-agenda-files (list notes)))
	    (setq org-log-done 'time
		  org-todo-keywords
		  '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d@!)" "CANCELED(c@!)")
		    (sequence "MAYBE(m)" "|" "CANCELED(c@!)"))
		  org-startup-indented t
		  org-special-ctrl-a/e t
		  ;; Refiling
		  org-refile-targets '((org-agenda-files :maxlevel . 9))
		  org-outline-path-complete-in-steps nil
		  org-refile-use-outline-path t
		  org-refile-allow-creating-parent-nodes (quote confirm)
		  ;; Capturing
		  org-capture-templates
		  '(("t" "Todo" entry
		     (file+headline "~/.org/tasks.org" "Tasks")
		     "* TODO %?")
		    ("T" "Referenced Todo" entry
		     (file+headline "~/.org/tasks.org" "Tasks")
		     "* TODO %?\n  %i\n  %a")
		    ("c" "Consume" entry
		     (file+headline "~/.org/tasks.org" "Consume")
		     "* MAYBE %?")
		    ("b" "Buy" entry
		     (file+headline "~/.org/tasks.org" "Shopping")
		     "* TODO %?")
		    ("p" "Projects" entry
		     (file+headline "~/.org/notes.org" "Projects")
		     "* MAYBE %?")
		    ("n" "Notes" entry
		     (file+headline "~/.org/notes.org" "Unsorted")
		     "* %?")
		    ("e" "Emacs note" entry
		     (file+headline "~/.org/emacs.org" "Captured")
		     "* %?")
		    ("j" "Journal" entry (file+datetree "~/.org/journal.org")
		     "* %?\nEntered on %U\n  %i\n  %a"))))
  :bind (("C-c l" . org-store-link)
	 ("C-c c" . org-capture)
	 ("C-c a" . org-agenda)
	 ("C-c b" . org-iswitchb))
  :ensure t)

;; (use-package sublimity
;;   :config (progn
;;	    (sublimity-mode 1)
;;	    (require 'sublimity-scroll))
;;   :ensure t)

;; (use-package smooth-scroll
;;   :config (smooth-scroll-mode t)
;;   :diminish smooth-scroll-mode
;;   :ensure t)

;; (use-package tea-time
;;   :config (setq tea-time-sound-command "afplay %s")
;;   :ensure t)

;;; Clojure
(use-package clojure-mode
  :config (progn
	    (add-hook 'clojure-mode-hook #'subword-mode))
  :ensure t)

(use-package rjsx-mode
  :config (progn
	    (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))
  :ensure t
  :pin melpa)

(use-package neotree
  :config (progn
	      (global-set-key [f8] 'neotree-toggle))
  :ensure t
  :pin melpa)

(use-package cider
  :config (progn
	    )
  :ensure t
  :pin melpa)

(use-package cider
  :ensure t
  :pin melpa-stable)

;;; Bongo
(use-package bongo
  :ensure t)

(use-package writeroom-mode
  :ensure t)

;;; YaSnippet
(use-package yasnippet
  :config (progn (yas-global-mode 1))
  :ensure t)

;;;; Misc

;;; Backing up
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;;; History
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
	search-ring
	regexp-search-ring))

;;; Sentences end with a single space
(setq sentence-end-double-space nil)

;;; Killing Text - From https://github.com/itsjeyd/emacs-config/blob/emacs24/init.el
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
    (if mark-active (list (region-beginning) (region-end))
      (list (line-beginning-position)
	(line-beginning-position 2)))))

;;; EShell
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

;;; Fix scrolling and bells
(global-set-key [wheel-right] 'ignore)	; This is because wheel-right
					; takes me off screen too easily
(global-set-key [wheel-left] 'scroll-right)

(defun my-bell-function ()
  "This bell function doesn't ring on certian occasions."
  (unless (memq this-command
	'(isearch-abort abort-recursive-edit exit-minibuffer
	      keyboard-quit mwheel-scroll down up next-line previous-line
	      backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;;; Removing the tool bar
(tool-bar-mode -1)

;;; Edit this config
(global-set-key (kbd "<f12>")
		(lambda ()
		  (interactive)
		  (find-file-other-window user-init-file)))

;;; Hippie Expand
(global-set-key "\M- " 'hippie-expand)

;;; Cycle spacing
(global-set-key (kbd "C-c C-SPC") 'cycle-spacing)

;;; Dealing with parens
(show-paren-mode 1)

;;; Better Scrolling - This doesn't work well I am just using the emacs-mac-port
;; (setq redisplay-dont-pause t
;;       scroll-margin 7
;;       scroll-step 1
;;       scroll-conservatively 10
;;       scroll-preserve-screen-position 1
;;       mouse-wheel-scroll-amount '(1 ((shift) . 1))  ; one line at a time
;;       mouse-wheel-progressive-speed nil)            ; don't accelerate

;;; C Code
(setq c-default-style "linux"
      c-basic-offset 4)

(provide 'init)

;;; Fixing Re-builder
(setq reb-re-syntax 'string)

;;; Renaming Current file
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
	(filename (buffer-file-name)))
    (if (not filename)
	(message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
	  (message "A buffer named '%s' already exists!" new-name)
	(progn
	  (rename-file name new-name 1)
	  (rename-buffer new-name)
	  (set-visited-file-name new-name)
	  (set-buffer-modified-p nil))))))

;;; Flyspell fixing
(setq ispell-program-name "aspell")
(setq ispell-list-command "list")

(add-hook 'flyspell-mode-hook (lambda () (local-set-key [M-down-mouse-1] 'flyspell-correct-word)))

;;; OSX Tricks

;; Use spotlight for locating
(setq locate-command "mdfind")

;;; init.el ends here
;;(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 ;;'(region ((t (:background "selectedTextBackgroundColor")))))
(put 'narrow-to-region 'disabled nil)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
