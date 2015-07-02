;;;; Important first stuff

;;; Setting the path
(let* ((extra '("/usr/texbin" "/usr/local/bin" "/Applications/ghc-7.8.4.app/Contents/bin"))
       (extra-path-form (mapconcat (lambda (x) (concat ":" x)) extra "")))
  (setenv "PATH" (concat (getenv "PATH") extra-path-form))
  (setq exec-path (append exec-path extra)))

;;;; Packages

;;; Set sources
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-archives
   (quote
    (("melpa" . "http://melpa.org/packages/")
     ("melpa-stable" . "http://stable-melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")))))

(package-initialize)

;;; Use package Setup 
(package-install 'use-package)
(package-install 'bind-key)
(eval-when-compile
  (require 'use-package))
;; (require 'diminish)                ;; if you use :diminish
(require 'bind-key)                ;; if you use any :bind variant


;;; Haskell
(use-package haskell-mode
  :config (progn
	    (add-hook 'haskell-mode-hook 'haskell-indentation-mode)
	    (add-hook 'haskell-mode-hook 'interactive-haskell-mode)))

;;; Amber theme
(use-package ample-theme
  :config (progn (load-theme 'ample t t)
               (load-theme 'ample-flat t t)
               (load-theme 'ample-light t t)
               (enable-theme 'ample-flat))
  :ensure t)

;;; Winner Mode
(winner-mode 1)

;;; Undo Tree
(use-package undo-tree
  :config (undo-tree-mode t)
  :ensure t)

;;; Evil Mode
(use-package evil
  :config (progn
	    ;; Evil Mode Switcher
	    (defun toggle-evil-mode ()
	      (interactive)
	      (if (not evil-mode)
		  (progn
		    (evil-mode 1) 
		    (enable-theme 'ample))
		(progn
		  (evil-mode 0) 
		  (enable-theme 'ample-flat))))
	    (global-set-key (kbd "<C-escape>") 'toggle-evil-mode)

	    ;; Redefining Keys
	    (evil-declare-key 'normal global-map (kbd "C-e") 'evil-end-of-line)
	    (evil-declare-key 'insert global-map (kbd "C-e") 'end-of-line)
	    (mapcar (lambda (state)
		    (evil-declare-key state
		      (kbd "C-f") 'evil-forward-char
		      (kbd "C-b") 'evil-backward-char
		      (kbd "C-d") 'evil-delete-char
		      (kbd "C-n") 'evil-next-line
		      (kbd "C-p") 'evil-previous-line
		      (kbd "C-w") 'evil-delete
		      (kbd "C-y") 'yank
		      (kbd "C-k") 'kill-line))
		  '(normal insert visual))

	    (define-key evil-normal-state-map (kbd "q") nil))
  :ensure t)

;;; Rainbow Delimiters
(use-package rainbow-delimiters
  :config (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  :ensure t
  :pin melpa-stable)

;;; Magit
(use-package magit
  :bind (("C-x g" . magit-status)
	 ("C-x M-g" . magit-dispatch-popup))
  :ensure t
  :pin melpa-stable)

;;;; Misc

;;; Fix scrolling and bells
(global-set-key [wheel-right] 'ignore)	; This is because wheel-right
					; takes me off screen too easily
(global-set-key [wheel-left] 'scroll-right)

(defun my-bell-function ()
  (unless (memq this-command
    	'(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;;; Removing the tool bar
(tool-bar-mode -1)

;;; Edit this config
(global-set-key (kbd "<f12>")
		(lambda ()
		  (interactive)
		  (find-file-other-window user-init-file)))

;;; Hippie Expand
(global-set-key "\M- " 'hippie-expand)

;;; Dealing with parens
(show-paren-mode 1)

;;; Better Scrolling
(setq redisplay-dont-pause t
      scroll-margin 7
      scroll-step 1
      scroll-conservatively 10
      scroll-preserve-screen-position 1
      mouse-wheel-scroll-amount '(1 ((shift) . 1))  ; one line at a time
      mouse-wheel-progressive-speed nil)            ; don't accelerate

;;; C Code
(setq c-default-style "linux"
      c-basic-offset 4)
