;;;; Programming Modes

;;; Haskell
(use-package haskell-mode
  :config (progn
	    (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
	    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)))

;;; Clojure
(use-package clojure-mode
  :config (progn
	    (add-hook 'clojure-mode-hook #'subword-mode)))

(use-package cider
  :pin melpa
  :ensure t)

(use-package multiple-cursors
  :pin melpa
  :ensure t)

(use-package clj-refactor
  :pin melpa
  :config
  (progn
    (add-hook 'clojure-mode-hook
              (lambda ()
                (clj-refactor-mode 1)
                (cljr-add-keybindings-with-prefix "C-c C-m")))))

;;; Javascript
(use-package js2-mode
  :config (setq js2-basic-offset 2
                js2-indent-switch-body t))


(use-package rjsx-mode
  :config (progn
	    (add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode)))
  :pin melpa)

(use-package json-reformat
  :config (progn
            (setq json-reformat:indent-width 2
                  js-indent-level 2)
            ;; Still doesn't work
            (add-hook 'json-mode
                      (lambda ()
                        (setq evil-shift-width 2)))))



(use-package json-mode)

;;; C Programming
(setq c-default-style "linux"
      c-basic-offset 4)

;; Local Variables:
;; flycheck-disabled-checkers: (emacs-lisp-checkdoc)
;; End:
