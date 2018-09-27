;;; Emacs Init file

(condition-case nil
    (load "~/.emacs.d/local.el")
  (error nil))

;; Setting up the package management comes first.
(load "~/.emacs.d/init-sections/package-management.el")

;; Things that should come before other things
(load "~/.emacs.d/init-sections/globals.el")
(load "~/.emacs.d/init-sections/custom.el")

;; Host Specifics
(if (eq system-type 'darwin)
    (load "~/.emacs.d/init-sections/osx.el"))

;; Look and Feel
(load "~/.emacs.d/init-sections/theming.el")
(load "~/.emacs.d/init-sections/emacs-comfort.el")
(load "~/.emacs.d/init-sections/evil.el")

;; Safety Features
(load "~/.emacs.d/init-sections/emacs-safety.el")

;; General Code Management
(load "~/.emacs.d/init-sections/search-and-project-management.el")
(load "~/.emacs.d/init-sections/window-management.el")
(load "~/.emacs.d/init-sections/syntax-management.el")

;; Mix of things
(load "~/.emacs.d/init-sections/misc-minor-modes.el")
(load "~/.emacs.d/init-sections/misc-major-modes.el")

;; Language Specific.
(load "~/.emacs.d/init-sections/latex.el")
(load "~/.emacs.d/init-sections/org.el")
(load "~/.emacs.d/init-sections/programming-modes.el")

(server-start)
(provide 'init)
