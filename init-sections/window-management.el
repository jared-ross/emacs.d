(use-package window-purpose
  :config (progn
            (purpose-mode)

            (define-key purpose-mode-map (kbd "C-x f") nil)
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

            ; [org]
            (add-to-list 'purpose-user-mode-purposes '(org-mode . org))

            (purpose-compile-user-configuration))
  :ensure t
  :after (helm))

(use-package ace-window
  :config (global-set-key (kbd "M-o") 'ace-window)
  :ensure t)

(setq pop-up-frames t)
