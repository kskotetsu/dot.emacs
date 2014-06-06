;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; session.el
;; http://emacs-session.sourceforge.net/
(when (require 'session nil t)
  (setq session-save-file-coding-system 'utf-8-unix)
  (setq session-initialize '(session places))
  (setq session-globals-max-size 1024)
  (setq session-globals-max-string (* 1024 1024))
  (setq session-globals-include '((kill-ring 512)
                                  (session-file-alist 512)
                                  (file-name-history 512)
                                  (tags-table-set-list 128)
                                  (tags-table-list 128)))
  (add-hook 'after-init-hook 'session-initialize)
  ;; Save session info every 30 minutes
  (setq my-timer-for-session-save-session (run-at-time t 900 'session-save-session)))
