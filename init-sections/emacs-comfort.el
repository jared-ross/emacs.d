;;; Emacs Comfort

;; Exec Path From Shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Save registers
;; (desktop-save-mode)

;; Dired
(require 'dired)
(put 'dired-find-alternate-file 'disabled nil) ; disables warning
(define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file) ; was dired-advertised-find-file
(define-key dired-mode-map (kbd "^") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory
(define-key dired-mode-map (kbd "<backspace>") (lambda () (interactive) (find-alternate-file "..")))  ; was dired-up-directory

(add-hook 'dired-mode-hook
          (lambda ()
            (dired-hide-details-mode)))


;; Org

(require 'org)
(set-register ?h (cons 'file (concat org-directory "home.org")))


;; (define-key dired-mode-map (kbd "`") 'jared-dired-open-term)


(defun jared-dired-open-term ()
  "Open an `ansi-term' that corresponds to current directory."
  (interactive)
  (let ((current-dir (dired-current-directory)))
    (term-send-string
     (ansi-term)
     (if (file-remote-p current-dir)
         (let ((v (tramp-dissect-file-name current-dir t)))
           (format "ssh %s@%s\n"
                   (aref v 1) (aref v 2)))
       (format "cd '%s'\n" current-dir)))))


(add-hook 'prog-mode-hook
          (lambda ()
            (setq display-line-numbers 'relative)))


;; Keep system clipboard seperate
(setq select-enable-clipboard t)

;; Startup Screen
(setq initial-buffer-choice "~/org/home.org")

;; Folding
(use-package origami)


;; Async emacs
(use-package async
  :config (progn
            (async-bytecomp-package-mode 1)))

;; Hydra
(use-package hydra)

;; Fixing window sizing

;; (use-package golden-ratio
;;   :config (golden-ratio-mode 1)
;;   :diminish golden-ratio-mode)

;; History
(require 'savehist)
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; Sentences end with a single space
(setq sentence-end-double-space nil)

;; Lets never have tabs
(setq-default indent-tabs-mode nil)

;; Killing Text - From https://github.com/itsjeyd/emacs-config/blob/emacs24/init.el
(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Term
(require 'term)
(global-set-key (kbd "C-x C-`") (lambda ()
                                  (interactive)
                                  (term "/bin/bash")))

(use-package eterm-256color
  :config (add-hook 'term-mode-hook #'eterm-256color-mode))




;; EShell

(require 'eshell)
(setq eshell-where-to-jump 'begin)
(setq eshell-review-quick-commands nil)
(setq eshell-smart-space-goes-to-end t)

;; Fix scrolling and bells

;; Stop scrolling past the bottom
(setq scroll-conservatively 108) ; This doesn't seem to work though...

(global-set-key [wheel-right] 'ignore)	; This is because wheel-right
                                        ; takes me off screen too easily
(global-set-key [wheel-left] 'scroll-right)

(defun my-bell-function ()
  "This bell function doesn't ring on certian occasions."
  (unless (memq this-command
        '(isearch-abort abort-recursive-edit exit-minibuffer
              keyboard-quit mwheel-scroll down up next-line previous-line
              backward-char forward-char))
    (ding)))
(setq ring-bell-function 'my-bell-function)

;; Removing the tool bar
(tool-bar-mode -1)

;; Edit this config
(global-set-key (kbd "C-<f12>")
                (lambda ()
                  (interactive)
                  (find-file-other-window user-init-file)))

;;; Fixing Re-builder
(require 're-builder)
(setq reb-re-syntax 'string)

;; Renaming Current file
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not filename)
        (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
          (message "A buffer named '%s' already exists!" new-name)
        (progn
          (rename-file name new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil))))))

(defun window-split-toggle ()
  "Toggle between horizontal and vertical split with two windows."
  (interactive)
  (if (> (length (window-list)) 2)
      (error "Can't toggle with more than 2 windows!")
    (let ((func (if (window-full-height-p)
                    #'split-window-vertically
                  #'split-window-horizontally)))
      (delete-other-windows)
      (funcall func)
      (save-selected-window
        (other-window 1)
        (switch-to-buffer (other-buffer))))))


(put 'narrow-to-region 'disabled nil)


;; Byte compileing .emacs.d
(defun jared-recompile-emacs ()
  (interactive)
  (byte-recompile-directory "~/.emacs.d/" 0))

(use-package eterm-256color)

;; Turn off keeping track of installed packages automatically
(defun package--save-selected-packages (&rest opt) nil)
