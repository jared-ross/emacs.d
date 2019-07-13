;;;; Search and project management

;;; Helm
;; (use-package helm
;;   :config (progn
;; 	    (require 'helm-config)
;; 	    (setq helm-candidate-number-limit           100
;; 		  helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
;; 		  helm-input-idle-delay 0.01  ; this actually updates things
;; 					; reeeelatively quickly.
;; 		  helm-yas-display-key-on-candidate t
;; 		  helm-quick-update t
;; 		  helm-M-x-requires-pattern nil
;; 		  helm-ff-skip-boring-files             t
;; 		  helm-split-window-in-side-p           t
;; 		  helm-move-to-line-cycle-in-source     t
;; 		  helm-ff-search-library-in-sexp        t
;; 		  helm-scroll-amount                    8
;; 		  helm-ff-file-name-history-use-recentf t)
;; 					; rebind tab to run persistent action
;; 	    (define-key helm-command-map (kbd "<tab>")
;; 	      'helm-execute-persistent-action)
;; 					; make TAB works in terminal
;; 	    (define-key helm-command-map (kbd "C-i")
;; 	      'helm-execute-persistent-action)
;; 					; list actions using C-z
;; 	    (define-key helm-command-map (kbd "C-z")
;; 	      'helm-select-action)

;; 	    (when (executable-find "curl")
;; 	      (setq helm-google-suggest-use-curl-p t))

;; 	    (helm-mode t))
;;   :bind (("C-x C-f" . helm-find-files)
;; 	 ("C-c h" . helm-mini)
;; 	 ("C-h a" . helm-apropos)
;; 	 ("C-x C-b" . helm-buffers-list)
;; 	 ("C-x b" . helm-buffers-list)
;; 	 ("M-y" . helm-show-kill-ring)
;; 	 ("M-x" . helm-M-x)
;;          ;; These don't seem to work
;; 	 ;; ("C-x c o" . helm-occur)
;; 	 ;; ("C-x c s" . helm-swoop)
;; 	 ;; ("C-x c y" . helm-yas-complete)
;; 	 ;; ("C-x c Y" . helm-yas-create-snippet-on-region)
;; 	 ;; ("C-x c b" . my/helm-do-grep-book-notes)
;; 	 ;; ("C-x c SPC" . helm-all-mark-rings)
;;          )
;;   :diminish helm-mode)

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


;; Project management

(use-package projectile
  :bind (:map projectile-mode-map
              ("C-c p" . projectile-command-map))
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
  :pin melpa)
