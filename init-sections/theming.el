;;; Theming

;; Old Theme
(use-package leuven-theme
  :config (progn
	    (load-theme 'leuven t t)
            (set-face-foreground 'mode-line "RosyBrown")
            (set-face-foreground 'mode-line-inactive "#DDD")
            ))

;; Experimental New Theme
;; (use-package grayscale-theme)
