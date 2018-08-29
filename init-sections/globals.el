;;; Globals --- Working with global settings

(use-package exec-path-from-shell
  :config (progn
	    (setq exec-path-from-shell-shell-name "sh")
	    (exec-path-from-shell-initialize)))
