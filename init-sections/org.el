;;; Org Mode
(use-package org
  :config (progn
	    (setq org-directory "~/.org/")
	    ;; (let ((notes (concat org-directory "/notes.org")))
	    ;;   (setq org-default-notes-file notes
	    ;;	    org-agenda-files (list notes)))
	    (setq org-log-done 'time
		  org-todo-keywords
		  '((sequence "TODO(t)" "WAIT(w@/!)" "|" "DONE(d@!)" "CANCELED(c@!)")
		    (sequence "MAYBE(m)" "|" "CANCELED(c@!)"))
		  org-startup-indented t
		  org-special-ctrl-a/e t
		  ;; Refiling
		  org-refile-targets '((org-agenda-files :maxlevel . 9))
		  org-outline-path-complete-in-steps nil
		  org-refile-use-outline-path t
		  org-refile-allow-creating-parent-nodes (quote confirm)
		  ;; Capturing
		  org-capture-templates
		  '(("t" "Todo" entry
		     (file+headline "~/.org/tasks.org" "Tasks")
		     "* TODO %?")
		    ("T" "Referenced Todo" entry
		     (file+headline "~/.org/tasks.org" "Tasks")
		     "* TODO %?\n  %i\n  %a")
		    ("c" "Consume" entry
		     (file+headline "~/.org/tasks.org" "Consume")
		     "* MAYBE %?")
		    ("b" "Buy" entry
		     (file+headline "~/.org/tasks.org" "Shopping")
		     "* TODO %?")
		    ("p" "Projects" entry
		     (file+headline "~/.org/notes.org" "Projects")
		     "* MAYBE %?")
		    ("n" "Notes" entry
		     (file+headline "~/.org/notes.org" "Unsorted")
		     "* %?")
		    ("e" "Emacs note" entry
		     (file+headline "~/.org/emacs.org" "Captured")
		     "* %?")
		    ("j" "Journal" entry (file+datetree "~/.org/journal.org")
		     "* %?\nEntered on %U\n  %i\n  %a"))))
  :bind (("C-c l" . org-store-link)
	 ("C-c c" . org-capture)
	 ("C-c a" . org-agenda)
	 ("C-c b" . org-iswitchb))
  :ensure t)
