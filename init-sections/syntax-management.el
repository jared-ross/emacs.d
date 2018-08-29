;;; Syntax Management

;; Fly Check

;; Hack to get eslint to work properly
(defun jared-syntax-install-eslint-checker ()
  (interactive)
  (flycheck-define-checker javascript-eslint
    "A Javascript syntax and style checker using eslint.

See URL `http://eslint.org/'."
    :command ("npx" "eslint" "--format=json"
              (option-list "--rulesdir" flycheck-eslint-rules-directories)
              "--stdin" "--stdin-filename" source-original)
    :standard-input t
    :error-parser flycheck-parse-eslint
                                        ; Hack: fix: (flycheck-eslint-config-exists-p)
    :enabled nil
    :modes (js-mode js-jsx-mode js2-mode js2-jsx-mode js3-mode rjsx-mode)
    :working-directory flycheck-eslint--find-working-directory
    :verify
    (lambda (_)
      (let* ((default-directory
               (flycheck-compute-working-directory 'javascript-eslint))
             (have-config t))
        (list
         (flycheck-verification-result-new
          :label "config file"
          :message (if have-config "found" "missing or incorrect")
          :face (if have-config 'success '(bold error))))))))

(use-package flycheck
  :config (progn
            ;; (jared-syntax-install-eslint-checker)
            ;; (add-hook 'rjsx-mode #'jared-syntax-install-eslint-checker)
            (add-hook 'prog-mode-hook #'flycheck-mode)))

;;; Dealing with parens
(show-paren-mode 1)

(use-package flyspell
  :config
  (progn
    (setq ispell-program-name "aspell")
    ;; This seems unnessesary
    ; (setq ispell-list-command "list")
    (add-hook 'flyspell-mode-hook (lambda () (local-set-key [M-down-mouse-1] 'flyspell-correct-word)))))


;; Company Mode
(use-package company
  :defer 2
  :diminish
  :custom
  ;; (company-begin-commands '(self-insert-command))
  ;; (company-idle-delay .1)
  ;; (company-minimum-prefix-length 2)
  ;; (company-show-numbers t)
  (company-tooltip-align-annotations 't)
  (global-company-mode t))

;; This does not seem to work
;; (use-package company-box
;;   :ensure t
;;   :after company
;;   :diminish
;;   :hook (company-mode . company-box-mode))
