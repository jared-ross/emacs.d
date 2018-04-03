;;; Syntax Management

;; Fly Check
(use-package flycheck
  :config (progn
	    (add-hook 'prog-mode-hook #'flycheck-mode)
	    (setq flycheck-disabled-checkers '(emacs-lisp-checkdoc))
	    (setq flycheck-eslint-executable "/Users/jaredross/.nvm/versions/node/v8.0.0/bin/npx eslint")
	    ;; (flycheck-define-checker javascript-eslint
;;	      "A Javascript syntax and style checker using eslint.

;; See URL `https://github.com/eslint/eslint'."
;;	      :command ("eslint" "--format=checkstyle"
;;			(config-file "--config" flycheck-eslintrc)
;;			(option "--rulesdir" flycheck-eslint-rulesdir)
;;			;; We need to use source-inplace because eslint looks for
;;			;; configuration files in the directory of the file being checked.
;;			;; See https://github.com/flycheck/flycheck/issues/447
;;			source-inplace)
;;	      :error-parser flycheck-parse-checkstyle
;;	      :error-filter (lambda (errors)
;;			      (mapc (lambda (err)
;;				      ;; Parse error ID from the error message
;;				      (setf (flycheck-error-message err)
;;					    (replace-regexp-in-string
;;					     (rx " ("
;;						 (group (one-or-more (not (any ")"))))
;;						 ")" string-end)
;;					     (lambda (s)
;;					       (setf (flycheck-error-id err)
;;						     (match-string 1 s))
;;					       "")
;;					     (flycheck-error-message err))))
;;				    (flycheck-sanitize-errors (flycheck-increment-error-columns errors)))
;;			      errors)
;;	      :modes (js-mode js2-mode js3-mode rjsx-mode)
;;	      :next-checkers ((warning . javascript-jscs))))
	    ))

;;; Hippie Expand
(global-set-key "\M- " 'hippie-expand)

;;; Cycle spacing
(global-set-key (kbd "C-c C-SPC") 'cycle-spacing)

;;; Dealing with parens
(show-paren-mode 1)

;;; Flyspell fixing
(setq ispell-program-name "aspell")
(setq ispell-list-command "list")

(add-hook 'flyspell-mode-hook (lambda () (local-set-key [M-down-mouse-1] 'flyspell-correct-word)))
