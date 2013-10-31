;; スタート画面なしに
;(setq inhibit-startup-message t)

;; カラーテーマの設定
(el-get 'sync 'color-theme-solarized)
(load-theme 'solarized-dark t)
;(color-theme-sanityinc-solarized-dark)

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


(setq tab-width 4)
(setq default-tab-width 4)
(setq c-basic-offset 4)

(global-linum-mode nil)
(setq linum-delay t)

;; 行番号高速化
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; scroll
(setq scroll-conservatively 35
       scroll-margin 3
       scroll-step 1)
