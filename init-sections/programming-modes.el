;;;; Programming Modes

;;; Webmode
(use-package web-mode
  :config (setq web-mode-enable-auto-quoting nil
                web-mode-markup-indent-offset 2
                web-mode-css-indent-offset 2
                web-mode-code-indent-offset 2))

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
            (defun my-clojure-mode-hook ()
              (setq cider-clojure-cli-parameters "-A:dev -m nrepl.cmdline --middleware '%s'")
              (clj-refactor-mode 1)
              ;; This choice of keybinding leaves cider-macroexpand-1 unbound
              (cljr-add-keybindings-with-prefix "C-c C-m"))
            (add-hook 'clojure-mode-hook #'my-clojure-mode-hook)))

(use-package parinfer
  :bind
  (("C-," . parinfer-toggle-mode)
   :map parinfer-mode-map
   ("C-M-," . parinfer-shift-left)
   ("C-M-." . parinfer-shift-right))
  :init
  (progn
    (setq parinfer-extensions
          '(defaults       ; should be included.
             pretty-parens  ; different paren styles for different modes.
             evil           ; If you use Evil.
             ;; lispy          ; If you use Lispy. With this extension, you should install Lispy and do not enable lispy-mode directly.
             paredit        ; Introduce some paredit commands.
             smart-tab      ; C-b & C-f jump positions and smart shift with tab & S-tab.
             smart-yank))   ; Yank behavior depend on mode.
    (add-hook 'clojure-mode-hook #'parinfer-mode)
    (add-hook 'emacs-lisp-mode-hook #'parinfer-mode)
    (add-hook 'common-lisp-mode-hook #'parinfer-mode)
    (add-hook 'scheme-mode-hook #'parinfer-mode)
    (add-hook 'lisp-mode-hook #'parinfer-mode)))


;; ;; Turned off as there are problems with it and use-package
(use-package cider
  :config (progn
            (add-hook 'cider-repl-mode-hook '(lambda () (setq scroll-conservatively 101))))
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
