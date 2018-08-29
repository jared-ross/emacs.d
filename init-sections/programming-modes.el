;;;; Programming Modes

;;; TypeScript
(use-package tide
  :config (progn
            (defun setup-tide-mode ()
              (interactive)
              (tide-setup)
              (flycheck-mode +1)
              (setq flycheck-check-syntax-automatically '(save mode-enabled))
              (eldoc-mode +1)
              (tide-hl-identifier-mode +1)
              ;; company is an optional dependency. You have to
              ;; install it separately via package-install
              ;; `M-x package-install [ret] company`
              (company-mode +1))

            ;; aligns annotation to the right hand side
            (setq company-tooltip-align-annotations t)

            ;; formats the buffer before saving
            (add-hook 'before-save-hook 'tide-format-before-save)

            (add-hook 'typescript-mode-hook #'setup-tide-mode)))


;;; YAML
(use-package yaml-mode)

;;; PHP
(use-package php-mode
  :config (add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode)))

;;; Haskell
(use-package haskell-mode
  :config (progn
	    (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
	    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)))

;;; Clojure
(use-package clojure-mode
  :config (progn
	    (add-hook 'clojure-mode-hook #'subword-mode)))

;; ;; Turned off as there are problems with it and use-package
;; (use-package cider
;;   :pin melpa)

(use-package multiple-cursors
  :pin melpa)

;; ;; Turned off as there are problems with it, same as cider
;; (use-package clj-refactor
;;   :pin melpa
;;   :config
;;   (progn
;;     (add-hook 'clojure-mode-hook
;;               (lambda ()
;;                 (clj-refactor-mode 1)
;;                 (cljr-add-keybindings-with-prefix "C-c C-m")))))

;;; Racket
(use-package racket-mode)

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
