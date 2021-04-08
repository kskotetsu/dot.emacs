(set-file-name-coding-system 'cp932)
(set-buffer-file-coding-system 'utf-8-with-signature-dos)
(prefer-coding-system 'utf-8-with-signature-dos)			; 極力UTF-8とする
;(global-set-key (kbd "C-o") 'toggle-input-method)

;;(setq default-input-method "W32-IME")
;;(setq-default w32-ime-mode-line-state-indicator "[A]")
;;(setq w32-ime-mode-line-state-indicator-list '("[A]" "[J]" "[A]"))
;(w32-ime-initialize)


;; tr-ime
(tr-ime-advanced-install)
(setq default-input-method "W32-IME")
(w32-ime-initialize)

;; IM のデフォルトを IME に設定
(setq default-input-method "W32-IME")
;; IME のモードライン表示設定
(setq-default w32-ime-mode-line-state-indicator "[--]")
(setq w32-ime-mode-line-state-indicator-list '("[--]" "[あ]" "[--]"))
;; IME 初期化
(w32-ime-initialize)
;; IME 制御（yes/no などの入力の時に IME を off にする）
(wrap-function-to-control-ime 'universal-argument t nil)
(wrap-function-to-control-ime 'read-string nil nil)
(wrap-function-to-control-ime 'read-char nil nil)
(wrap-function-to-control-ime 'read-from-minibuffer nil nil)
(wrap-function-to-control-ime 'y-or-n-p nil nil)
(wrap-function-to-control-ime 'yes-or-no-p nil nil)
(wrap-function-to-control-ime 'map-y-or-n-p nil nil)
(wrap-function-to-control-ime 'register-read-with-preview nil nil)

;; IME の未確定文字列のフォント設定
;(set-frame-font "Meiryo UI-12" nil t)
(modify-all-frames-parameters '((ime-font . "Meiryo UI-12")))

