;;;; Programming Modes

;;; Webmode
(use-package web-mode
  :config (setq web-mode-enable-auto-quoting nil))

;;; TypeScript
(use-package tide
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (typescript-mode . eldoc)
         (before-save . tide-format-before-save))
  :config (progn
            ;; Setup JSX
            (add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
            (add-hook 'web-mode-hook
                      (lambda ()
                        (when (string-equal "jsx" (file-name-extension buffer-file-name))
                          (setup-tide-mode))))

            ;; configure jsx-tide checker to run after your default jsx checker
            (flycheck-add-mode 'javascript-eslint 'web-mode)
            (flycheck-add-next-checker 'javascript-eslint 'jsx-tide 'append)

            ;; Setup TSX
            (add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
            (add-hook 'web-mode-hook
                      (lambda ()
                        (when (string-equal "tsx" (file-name-extension buffer-file-name))
                          (setup-tide-mode))))

            ;; enable typescript-tslint checker
            (flycheck-add-mode 'typescript-tslint 'web-mode)))


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
