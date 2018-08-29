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
         ;; These don't seem to work
	 ;; ("C-x c o" . helm-occur)
	 ;; ("C-x c s" . helm-swoop)
	 ;; ("C-x c y" . helm-yas-complete)
	 ;; ("C-x c Y" . helm-yas-create-snippet-on-region)
	 ;; ("C-x c b" . my/helm-do-grep-book-notes)
	 ;; ("C-x c SPC" . helm-all-mark-rings)
         )
  :diminish helm-mode)

;; Project management

(use-package ag
  :config (setq ag-highlight-search t))

(use-package neotree
  :config (progn
	      (global-set-key [f8] 'neotree-toggle))
  :pin melpa)

;;; Git
(use-package magit
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch-popup))
  :pin melpa
  :ensure t)
