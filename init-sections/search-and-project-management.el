;;;; Search and project management

(use-package ivy :ensure t
  :diminish (ivy-mode . "")
  :bind
  (("C-c C-r" . ivy-resume)
   ("<f6>" . ivy-resume)
   ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file)
   ("<f1> f" . counsel-describe-function)
   ("<f1> v" . counsel-describe-variable)
   ("<f1> l" . counsel-find-library)
   ("<f2> i" . counsel-info-lookup-symbol)
   ("<f2> u" . counsel-unicode-char)
   ("C-c g" . counsel-git)
   ("C-c j" . counsel-git-grep)
   ("C-c k" . counsel-ag)
   ("C-x l" . counsel-locate)
   ("C-S-o" . counsel-rhythmbox)
   :map ivy-mode-map
   ("C-'" . ivy-avy)
   :map minibuffer-local-map
   ("C-r" . counsel-minibuffer-history))
  :config (progn
            (ivy-mode 1)
            (setq ivy-use-virtual-buffers t)
            (setq ivy-height 10)
            ;; does not count candidates
            (setq ivy-count-format "")
            ;; no regexp by default
            (setq ivy-initial-inputs-alist nil)
            ;; configure regexp engine.
            (setq ivy-re-builders-alist
                  ;; allow input not in order
                  '((t   . ivy--regex-ignore-order)))

            (setq enable-recursive-minibuffers t)

            (global-set-key "\C-s" 'swiper)))

(use-package ivy-hydra)

;; Documentation
(use-package counsel-dash
  :config (progn
            (setq counsel-dash-common-docsets '())
            (add-hook 'emacs-lisp-mode-hook (lambda () (setq-local counsel-dash-docsets '("Emacs Lisp"))))
            (add-hook 'clojure-mode-hook (lambda () (setq-local counsel-dash-docsets '("Clojure"))))
            (setq counsel-dash-browser-func 'eww)))

;; Project management

(use-package projectile
  :bind (:map projectile-mode-map
              ("M-p" . projectile-command-map))
  :config (progn
            (projectile-mode +1)))

(use-package counsel-projectile
  :config (progn
            (counsel-projectile-mode +1)))


(use-package ag
  :config (setq ag-highlight-search t))

(use-package wgrep-ag)

(use-package neotree
  :config (progn
	      (global-set-key [f8] 'neotree-toggle))
  :pin melpa)

;;; Git
(use-package magit
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch-popup))
  :config (progn
            (add-hook 'after-save-hook 'magit-after-save-refresh-status t))
  :pin melpa)
