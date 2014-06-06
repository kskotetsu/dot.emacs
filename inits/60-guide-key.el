;; ------------------------------------------------------------------------
;; guide-key
(require 'guide-key)

(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x c"))
(setq guide-key/highlight-command-regexp "rectangle")
(setq guide-key/popup-window-position 'bottom)

(add-hook 'org-mode-hook '(lambda ()
								  (guide-key/add-local-guide-key-sequence "C-c")
								  (guide-key/add-local-guide-key-sequence "C-c C-x")
								  (guide-key/add-local-highlight-command-regexp "org-")
								  ))

(guide-key-mode 1)

