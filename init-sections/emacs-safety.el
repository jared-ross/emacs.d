;;; Emacs Safety

;; Prevent accidentally quiting Emacs
(setq confirm-kill-emacs 'yes-or-no-p)

;;; Backing up
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))
