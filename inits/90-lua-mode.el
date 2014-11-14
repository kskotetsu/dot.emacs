; -*- coding: utf-8 -*-

;; Lua-mode

(defun my-lua-mode()
  (highlight-symbol-mode)
  (flycheck-mode t)
  (setq indent-tabs-mode t)
  (show-paren-mode t)						;対応する括弧を表示
  (setq tab-width 4)

  (setq lua-indent-level 4)
  )

(add-hook 'lua-mode-hook 'my-lua-mode)


;; (flycheck-define-checker lua
;;   "A Lua syntax checker using the Lua compiler.

;; See URL `http://www.lua.org/'."
;;   :command ("luac" "-p" source)
;;   :error-patterns
;;   ((error line-start
;;           (minimal-match (zero-or-more not-newline))
;;           ":" line ": " (message) line-end))
;;   :modes lua-mode)
