;;;; Misc Minor Modes

;;; Winner Mode
(use-package winner
  :config (winner-mode 1))

;;; Rainbow Delimiters
(use-package rainbow-delimiters
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  :pin melpa-stable)

;;; Agressive Indent
(use-package aggressive-indent)

;;; Guide Key - Show help on delay of key input
(use-package guide-key
  :config (progn
	    (setq guide-key/guide-key-sequence
                  '("C-x r"
                    "C-x 4"
                    "C-c"
                    "C-x"))
	    (guide-key-mode 1))
  :diminish guide-key-mode)

;;; Whitespace Cleanup
(use-package whitespace-cleanup-mode
  :config (global-whitespace-cleanup-mode t)
  :diminish whitespace-cleanup-mode)

;;; Writeroom
(use-package writeroom-mode)

;;; YaSnippet
(use-package yasnippet
  :config (progn (yas-global-mode 1))
  :diminish yas-minor-mode)

;;; Multiple Cursors
(use-package multiple-cursors
  :pin melpa)


;; Smart tabs
(use-package smart-tabs-mode)
