;;; OSX Specific Things

;; Use spotlight for locating
(setq locate-command "mdfind"
      mac-option-modifier 'meta
      mac-right-option-modifier 'hyper)

;; stop opening a new frame (window) for each file
(setq ns-pop-up-frames nil)

;; Org
(add-to-list 'org-file-apps '(directory . emacs))
