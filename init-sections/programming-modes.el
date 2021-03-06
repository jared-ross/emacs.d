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
    (setq-default indent-tabs-mode nil)
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
  :config (progn
            (setq js2-indent-switch-body t)
            (defvaralias 'js2-basic-offset 'tab-width)
            (defvaralias 'sgml-basic-offset 'tab-width)
            
            ;; Fix tabbing bug
            (add-hook 'js2-mode-hook #'js2-imenu-extras-mode)))

(use-package xref-js2
  :config (progn
            (define-key js2-mode-map (kbd "M-.") nil)
            (add-hook 'js2-mode-hook (lambda ()
                                       (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)))))

(use-package js2-refactor
  :config (progn
            (add-hook 'js2-mode-hook #'js2-refactor-mode)
            (js2r-add-keybindings-with-prefix "C-c C-r")))



(use-package rjsx-mode
  :config (progn
            (add-hook 'rjsx-mode-hook (lambda ()
                                        (setq-local js-indent-level tab-width)
                                        (setq-local indent-line-function 'js2-jsx-indent-line)))
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


(use-package nodejs-repl
  :config (progn
            (defun node-repl-jack-in ()
              (interactive)
              (define-key js-mode-map (kbd "C-x C-e") 'nodejs-repl-send-last-expression)
              (define-key js-mode-map (kbd "C-c C-j") 'nodejs-repl-send-line)
              (define-key js-mode-map (kbd "C-c C-r") 'nodejs-repl-send-region)
              (define-key js-mode-map (kbd "C-c C-l") 'nodejs-repl-load-file)
              (define-key js-mode-map (kbd "C-c C-z") 'nodejs-repl-switch-to-repl)
              (nodejs-repl))
            (defun nvm-which ()
              (let* ((shell (concat (getenv "SHELL") " -l -c 'nvm which'"))
                     (output (shell-command-to-string shell)))
                (message output)
                (cadr (split-string output "[\n]+" t))))
            (setq nodejs-repl-command #'nvm-which)))

(defun nvm-which ()
  (let* ((shell (concat (getenv "SHELL") " -l -c 'nvm which'"))
         (output (shell-command-to-string shell)))
    (cadr (split-string output "[\n]+" t))))
(setq nodejs-repl-command #'nvm-which)


(use-package json-mode)


;;; C Programming

(setq c-default-style "linux"
      c-basic-offset 4)

(use-package markdown-mode
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
