;;; Evil

;; Undo Tree
(use-package undo-tree
  :config (progn
	    (global-undo-tree-mode)
	    (setq undo-tree-visualizer-timestamps t
		  undo-tree-visualizer-diff t
		  undo-tree-auto-save-history t
		  undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))
  :diminish undo-tree-mode
  :ensure t)

;; Evil Mode
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
