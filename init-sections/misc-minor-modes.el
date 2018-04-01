;;;; Misc Minor Modes

;;; Winner Mode
(use-package winner
  :config (winner-mode 1))

;;; Rainbow Delimiters
(use-package rainbow-delimiters
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  :ensure t
  :pin melpa-stable)

;;; Agressive Indent
(use-package aggressive-indent
  :ensure t)

;;; Guide Key - Show help on delay of key input
(use-package guide-key
  :config (progn
	    (setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-c"))
	    (guide-key-mode 1))
  :ensure t
  :diminish guide-key-mode)

;;; Whitespace Cleanup
(use-package whitespace-cleanup-mode
  :config (global-whitespace-cleanup-mode t)
  :diminish whitespace-cleanup-mode
  :ensure t)

;;; Writeroom
(use-package writeroom-mode
  :ensure t)

;;; YaSnippet
(use-package yasnippet
  :config (progn (yas-global-mode 1))
  :ensure t)
