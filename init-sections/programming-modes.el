;;;; Programming Modes

;;; Haskell
(use-package haskell-mode
  :config (progn
	    (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
	    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)))

;;; Clojure
(use-package clojure-mode
  :config (progn
	    (add-hook 'clojure-mode-hook #'subword-mode))
  :ensure t)

(use-package cider
  :ensure t
  :pin melpa-stable)

;;; Javascript
(use-package js2-mode
  :ensure t
  :config (setq js2-basic-offset 2))

(use-package rjsx-mode
  :config (progn
	    (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode)))
  :ensure t
  :pin melpa)

(use-package add-node-modules-path
  :config (progn
	    (eval-after-load 'js-mode
	      '(add-hook 'js-mode-hook #'add-node-modules-path)))
  :ensure t)

;;; C Programming
(setq c-default-style "linux"
      c-basic-offset 4)

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
