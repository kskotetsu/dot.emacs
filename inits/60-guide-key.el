;; ------------------------------------------------------------------------
;; guide-key
(require 'guide-key)

(setq guide-key/guide-key-sequence '("C-x r" "C-x 4" "C-x c" "M-s" "C-z" "M-g"))
(setq guide-key/highlight-command-regexp "rectangle")
(setq guide-key/popup-window-position 'bottom)

(defun my-guide-key ()
  (guide-key/add-local-guide-key-sequence "C-c")
  (guide-key/add-local-guide-key-sequence "C-c C-x")
  (guide-key/add-local-highlight-command-regexp "org-")
)


(add-hook 'org-mode-hook 'my-guide-key)

(guide-key-mode 1)

