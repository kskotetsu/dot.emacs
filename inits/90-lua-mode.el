; -*- coding: utf-8 -*-

;; Lua-mode

(defun my-lua-mode
  (highlight-symbol-mode)
  (setq indent-tabs-mode t)
  (show-paren-mode t)						;対応する括弧を表示
  (setq tab-width 4)

  (setq lua-indent-level 4)
)

(add-hook 'lua-mode-hook 'my-lua-mode)

