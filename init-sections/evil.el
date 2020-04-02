;;; Evil

;; Undo Tree
(use-package undo-tree
  :config (progn
	    (global-undo-tree-mode)
	    (setq undo-tree-visualizer-timestamps t
		  undo-tree-visualizer-diff t
		  undo-tree-auto-save-history t
		  undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo"))))
  :diminish undo-tree-mode)

(use-package key-chord
  :config (key-chord-mode 1))

;; Evil Mode
(use-package evil
  :init (setq evil-want-C-u-scroll t)
  :config (progn
	    ;; Redefining Keys
	    (evil-declare-key 'normal global-map (kbd "C-e") 'evil-end-of-line)
	    (evil-declare-key 'insert global-map (kbd "C-e") 'end-of-line)
            (evil-declare-key 'normal global-map (kbd "] l") 'flycheck-next-error)
            (evil-declare-key 'normal global-map (kbd "[ l") 'flycheck-previous-error)

	    (mapc (lambda (state)	; For some reason this only works with mapcar
		    ;; (evil-declare-key state global-map (kbd "C-f") 'evil-forward-char)
		    ;; (evil-declare-key state global-map (kbd "C-b") 'evil-backward-char)
		    ;; (evil-declare-key state global-map (kbd "C-d") 'evil-delete-char)
		    (evil-declare-key state global-map (kbd "C-n") 'evil-next-line)
		    (evil-declare-key state global-map (kbd "C-p") 'evil-previous-line)
                                        ;(evil-declare-key state global-map (kbd "C-w") 'evil-delete)
		    (evil-declare-key state global-map (kbd "C-y") 'yank)
		    (evil-declare-key state global-map (kbd "C-k") 'kill-line))
		  '(normal insert visual))


            ;; Fix the "q" key action
                                        ; (define-key evil-normal-state-map (kbd "q") nil)
                                        ; (define-key evil-normal-state-map (kbd "q") 'evil-record-macro)
            (add-hook 'view-mode-hook 'evil-motion-state)

	    ;; Fixing up certain states
	    (evil-set-initial-state 'special-mode 'emacs)
	    (evil-set-initial-state 'dired-mode 'emacs)
	    (evil-set-initial-state 'magit-mode 'emacs)
	    (evil-set-initial-state 'magit-popup-mode 'emacs)
                                        ;(evil-set-initial-state 'org-mode 'normal)
	    (evil-set-initial-state 'sql-interactive-mode 'emacs)
	    (evil-set-initial-state 'neotree-mode 'emacs)
	    (evil-set-initial-state 'haskell-interactive-mode 'emacs)
	    (evil-set-initial-state 'haskell-error-mode 'emacs)
	    (evil-set-initial-state 'cider-stacktrace-mode 'emacs)

            ;; Enable smash escape (ie 'jk' and 'kj' quickly to exit insert mode)
            (key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)
            (key-chord-define evil-insert-state-map  "kj" 'evil-normal-state)
            (define-key evil-normal-state-map (kbd "M-.") nil)

            ;; Turning on Evil mode
	    (evil-mode 1)))

(use-package evil-surround
  :config (global-evil-surround-mode 1))

;; Evil Unimpared, stolen from Sylvain Benner <sylvain.benner@gmail.com>
;; https://github.com/zmaas/evil-unimpaired/blob/master/evil-unimpaired.el

(use-package dash)
(use-package f)

(defun evil-unimpaired/paste-above ()
  (interactive)
  (evil-insert-newline-above)
  (evil-paste-after 1))

(defun evil-unimpaired/paste-below ()
  (interactive)
  (evil-insert-newline-below)
  (evil-paste-after 1))

(defun evil-unimpaired/insert-space-above (count)
  (interactive "p")
  (dotimes (_ count) (save-excursion (evil-insert-newline-above))))

(defun evil-unimpaired/insert-space-below (count)
  (interactive "p")
  (dotimes (_ count) (save-excursion (evil-insert-newline-below))))

(define-key evil-normal-state-map (kbd "[ SPC") 'evil-unimpaired/insert-space-above)
(define-key evil-normal-state-map (kbd "] SPC") 'evil-unimpaired/insert-space-below)

(when (featurep 'flycheck)
	(define-key evil-normal-state-map (kbd "] l") 'flycheck-next-error)
	(define-key evil-normal-state-map (kbd "[ l") 'flycheck-previous-error)
	(define-key evil-normal-state-map (kbd "] q") 'flycheck-next-error)
	(define-key evil-normal-state-map (kbd "[ q") 'flycheck-previous-error))

;; (define-key evil-normal-state-map (kbd "[ e") 'move-text-up)
;; (define-key evil-normal-state-map (kbd "] e") 'move-text-down)
;; (define-key evil-visual-state-map (kbd "[ e") ":move'<--1")
;; (define-key evil-visual-state-map (kbd "] e") ":move'>+1")

;; select pasted text
(define-key evil-normal-state-map (kbd "g p") (kbd "` [ v ` ]"))

;; paste above or below with newline
(define-key evil-normal-state-map (kbd "[ p") 'evil-unimpaired/paste-above)
(define-key evil-normal-state-map (kbd "] p") 'evil-unimpaired/paste-below)


(use-package evil-commentary
  :config (evil-commentary-mode)
  :diminish evil-commentary-mode)

(use-package evil-exchange
  :config (evil-exchange-cx-install))

(use-package evil-leader
  :config (progn
            (global-evil-leader-mode)))

(use-package evil-numbers
  :config (progn
            (define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
            (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt)))

