(set-file-name-coding-system 'cp932)
(set-buffer-file-coding-system 'utf-8-with-signature-dos)
(prefer-coding-system 'utf-8-dos)			; 極力UTF-8とする
;(global-set-key (kbd "C-o") 'toggle-input-method)

(setq default-input-method "W32-IME")
(setq-default w32-ime-mode-line-state-indicator "[A]")
(setq w32-ime-mode-line-state-indicator-list '("[A]" "[J]" "[A]"))
(w32-ime-initialize)
