;;; Org Mode
(use-package org
  :config (progn
            (org-clock-persistence-insinuate)

	    (setq
	     ;; Files
	     org-agenda-files '("emacs.org" "tasks.org" "notes.org" "work.org")
	     org-log-done 'time
             org-log-into-drawer t
	     org-todo-keywords
	     '((sequence "TODO(t)" "WAIT(w/!)" "|" "DONE(d!)" "DEFERED(l!)" "CANCELED(c!)")
	       (sequence "MAYBE(m)" "|" "CANCELED(c@!)")
               (sequence "QUESTION(q!)" "|" "ANSWERED(a!)"))
	     org-startup-indented t
	     org-special-ctrl-a/e t

             ;; Clocking
             org-clock-idle-time 5
             org-clock-persist t

	     ;; Refiling
	     org-refile-targets '((org-agenda-files :maxlevel . 9))
	     org-outline-path-complete-in-steps nil
	     org-refile-use-outline-path t
	     org-refile-allow-creating-parent-nodes (quote confirm)

	     ;; Capturing
	     org-capture-templates
	     '(("t" "Todo" entry
		(file+headline "tasks.org" "Tasks")
		"* TODO %?")
	       ("T" "Referenced Todo" entry
		(file+headline "tasks.org" "Tasks")
		"* TODO %?\n  %i\n  %a")
	       ("c" "Consume" entry
		(file+headline "tasks.org" "Consume")
		"* MAYBE %?")
	       ("b" "Buy" entry
		(file+headline "tasks.org" "Shopping")
		"* TODO %?")
	       ("p" "Projects" entry
		(file+headline "notes.org" "Projects")
		"* MAYBE %?")
	       ("n" "Notes" entry
		(file+headline "notes.org" "Unsorted")
		"* %?")
	       ("S" "Link with Selected Text" entry
		(file+headline "notes.org" "Captured Links")
                "* %^{Title}\nSource: %u, %c\n #+BEGIN_QUOTE\n%i\n#+END_QUOTE\n\n\n%?")
	       ("L" "Link" entry
		(file+headline "notes.org" "Captured Links")
                "* %? [[%:link][%:description]] \nCaptured On: %U")
	       ("e" "Emacs note" entry
		(file+headline "emacs.org" "Captured")
		"* %?")
	       ("j" "Journal" entry (file+datetree "journal.org")
		"* %?\nEntered on %U\n  %i\n  %a"))
                                        ; Exporting
             org-export-with-section-numbers nil
             org-html-include-timestamps nil
             org-export-with-sub-superscripts nil
             org-export-with-toc nil
             org-html-toplevel-hlevel 2
             org-export-htmlize-output-type 'css))
  :bind (("C-c l" . org-store-link)
	 ("C-c c" . org-capture)
	 ("C-c a" . org-agenda)
	 ("C-c b" . org-iswitchb))
  :pin "org")

;; Scratch

(defun MA-day ()
  "This doesn't add much value so far."
  (interactive)
  (let ((org-export-with-tasks nil)
        (async nil)
        (subtreep t)
        (visible-only nil)
        (body-only t)
        (ext-plist
         (list
          :ascii-charset 'utf-8
           :ascii-headline-spacing '(0 . 2)
           :ascii-paragraph-spacing 'auto
           :ascii-inner-margin 0
           :ascii-format-inlinetask-function
           '(lambda (a b c d e f g h i) 'nil))))
    (org-export-to-buffer 'ascii "*MA Day*"
      async subtreep visible-only body-only ext-plist (lambda () nil))))
