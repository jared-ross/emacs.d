;;;; Search and project management

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

(use-package ag
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
			    tags-table-list))
		  ;; I don't really know why I have this:
		  bmkp-last-as-first-bookmark-file "~/.emacs.d/bookmarks"))
  :ensure t)

;;; Project Management
(use-package neotree
  :config (progn
	      (global-set-key [f8] 'neotree-toggle))
  :ensure t
  :pin melpa)

;;; Git
(use-package magit
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch-popup))
  :ensure t
  :pin melpa-stable)
