;;; Emacs Init file

;; Setting up the package management comes first.
(load "~/.emacs.d/init-sections/package-management.el")

;; Things that come before.
(load "~/.emacs.d/init-sections/globals.el")
(load "~/.emacs.d/init-sections/custom.el")

;; Look and Feel.
(load "~/.emacs.d/init-sections/theming.el")
(load "~/.emacs.d/init-sections/emacs-comfort.el")
(load "~/.emacs.d/init-sections/evil.el")

;; Mix of things
(load "~/.emacs.d/init-sections/misc-minor-modes.el")

;; General programming
(load "~/.emacs.d/init-sections/search-and-project-management.el")

;; Language Specific.
(load "~/.emacs.d/init-sections/latex.el")
(load "~/.emacs.d/init-sections/org.el")
(load "~/.emacs.d/init-sections/programming-modes.el")

;; Safety Features
(load "~/.emacs.d/init-sections/emacs-safety.el")

(if (eq system-type 'darwin)
    (load "~/.emacs.d/init-sections/osx.el"))

;; Lets try have this here, for some reason the lambda function isn't working
(load "~/.emacs.d/init-sections/syntax-management.el")

(provide 'init)
