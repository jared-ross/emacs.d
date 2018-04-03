;;; Latex

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
					      (?p ("\\pi" "\\Pr(?)" "\\varpi")))
		  cdlatex-paired-parens "$")))
