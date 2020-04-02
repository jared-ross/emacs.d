(use-package window-purpose
  :config (progn
            (purpose-mode)

            (define-key purpose-mode-map (kbd "C-x f") 'find-file-without-purpose)
            (define-key purpose-mode-map (kbd "C-x C-f") nil)
            (define-key purpose-mode-map (kbd "C-x b") 'switch-buffer-without-purpose)
            (define-key purpose-mode-map (kbd "C-x C-b") nil)

            ; [webdev]
            (add-to-list 'purpose-user-mode-purposes '(sql-mode . webdev))
            (add-to-list 'purpose-user-mode-purposes '(php-mode . webdev))
            (add-to-list 'purpose-user-mode-purposes '(rjsx-mode . webdev))
            (add-to-list 'purpose-user-mode-purposes '(scss-mode . webdev))
            (add-to-list 'purpose-user-mode-purposes '(css-mode . webdev))
            (add-to-list 'purpose-user-mode-purposes '(html-mode . webdev))
            (add-to-list 'purpose-user-mode-purposes '(json-mode . webdev))
            (add-to-list 'purpose-user-mode-purposes '(web-mode . webdev))

            ; [org]
            (add-to-list 'purpose-user-mode-purposes '(org-mode . org))

            ; [terminal] extensions
            (add-to-list 'purpose-user-mode-purposes '(cider-repl-mode . repl))
            (add-to-list 'purpose-user-mode-purposes '(message-buffer-mode . repl))

            (add-to-list 'purpose-user-mode-purposes '(magit-mode . magit))

            (purpose-compile-user-configuration)))

(use-package ace-window
  :config (global-set-key (kbd "M-o") 'ace-window))

(setq pop-up-frames nil)
