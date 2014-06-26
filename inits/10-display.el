;; スタート画面なしに
;(setq inhibit-startup-message t)

;; カラーテーマの設定
(el-get 'sync 'color-theme)
(el-get 'sync 'color-theme-solarized)
(el-get 'sync 'color-theme-tomorrow)
(color-theme-solarized-dark)
;(color-theme-tomorrow)

; 長い行を折り返し表示しない
(setq truncate-lines t)
;(setq truncate-lines nil)

; ツールバーをオフ
(tool-bar-mode 0)

; フレームタイトルの設定
(setq frame-title-format "%b")

;;起動時のフレームサイズを設定する
(setq initial-frame-alist
      (append (list
        '(width . 120)
        '(height . 48)
        )
        initial-frame-alist))
(setq default-frame-alist initial-frame-alist)

;; 重複ファイルを hoge<dir1>などのように
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")

;; タブ設定
(setq tab-width 4)
(setq default-tab-width 4)
(setq c-basic-offset 4)

;; 対応する括弧を表示
(show-paren-mode t)
(setq show-paren-delay 0)
;(setq show-paren-style 'parenthesis)
(setq show-paren-style 'mixed)
(set-face-attribute 'show-paren-match-face nil
                     :background nil :foreground "sienna2"
                     :underline t :weight 'extra-bold)
;(set-face-background 'show-paren-match "royal blue")

(global-linum-mode nil)
(setq linum-delay t)

;; 行番号高速化
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; scroll
(setq scroll-conservatively 35
       scroll-margin 3
       scroll-step 1)

;; 空白文字を可視化
(global-whitespace-mode 1)
(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
        (tab-mark   ?\t   [?\xBB ?\t])
        ))
(set-face-foreground 'whitespace-space "firebrick")
(set-face-background 'whitespace-space nil)
(set-face-bold-p 'whitespace-space t)
(set-face-foreground 'whitespace-tab "gray25")
(set-face-background 'whitespace-tab nil)
(set-face-underline  'whitespace-tab nil)
