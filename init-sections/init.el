;;; Initialisation --- Everything that needs to go before everything else

;; Setting the Path
(let* ((extra '("/usr/local/texbin"
		"/usr/local/bin"
		"/Applications/ghc-7.8.4.app/Contents/bin"
		""))
       (extra-path-form (mapconcat (lambda (x) (concat ":" x)) extra "")))
  (setenv "PATH" (concat (getenv "PATH") extra-path-form))
  (setq exec-path (append exec-path extra)))
