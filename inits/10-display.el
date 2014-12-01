;; スタート画面なしに
;(setq inhibit-startup-message t)

;; カラーテーマの設定
(el-get 'sync 'color-theme)
(el-get 'sync 'color-theme-solarized)
(el-get 'sync 'color-theme-tomorrow)
;(color-theme-solarized-dark)
(color-theme-molokai)

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

;; 行番号
(global-linum-mode -1)
(setq linum-delay t)

;; 行番号高速化
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; カーソル行をハイライト
(global-hl-line-mode t)

;; diff-hl.el
;; バージョン管理下のコードをハイライト
;; 行番号と同時に使用できない
(global-diff-hl-mode)
(diff-hl-margin-mode)
(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
;(unless (window-system) (diff-hl-margin-mode))

;; scroll
(setq scroll-conservatively 35
	  scroll-margin 3
	  scroll-step 1)

;; ターミナルではスクロールマージンを入れるとがくがくする
(add-hook 'term-mode-hook
		  (lambda ()
			(make-local-variable 'scroll-margin)
			(setq scroll-margin 0)))

;; 空白文字を可視化
(global-whitespace-mode t)

(setq whitespace-style '(face tabs tab-mark spaces space-mark))
(setq whitespace-space-regexp "\\(\x3000+\\)")
(setq whitespace-display-mappings
      '((space-mark ?\x3000 [?\□])
		;(tab-mark   ?\t   [?\xBB ?\t])
        ))
(set-face-foreground 'whitespace-space "firebrick")
(set-face-background 'whitespace-space nil)
(set-face-bold-p 'whitespace-space nil)
(set-face-foreground 'whitespace-tab "gray25")
(set-face-background 'whitespace-tab nil)
(set-face-underline  'whitespace-tab nil)

;; 変数をハイライト
(require 'highlight-symbol)
(set-face-background 'highlight-symbol-face "dark slate blue")
(set-face-foreground 'highlight-symbol-face "gray90")

(defun window-toggle-division ()
  "ウィンドウ 2 分割時に、縦分割<->横分割"
  (interactive)
  (unless (= (count-windows 1) 2)
    (error "ウィンドウが 2 分割されていません。"))
  (let ((before-height)
        (other-buf (window-buffer (next-window))))
    (setq before-height (window-height))
    (delete-other-windows)
    (if (= (window-height) before-height)
        (split-window-vertically)
      (split-window-horizontally))
    (other-window 1)
    (switch-to-buffer other-buf)
    (other-window -1)))

;; other-windowのときにいい感じに分割する
;; http://blog.shibayu36.org/entry/2012/12/18/161455
(defun split-window-vertically-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-vertically)
    (progn
      (split-window-vertically
       (- (window-height) (/ (window-height) num_wins)))
      (split-window-vertically-n (- num_wins 1)))))

(defun split-window-horizontally-n (num_wins)
  (interactive "p")
  (if (= num_wins 2)
      (split-window-horizontally)
    (progn
      (split-window-horizontally
       (- (window-width) (/ (window-width) num_wins)))
      (split-window-horizontally-n (- num_wins 1)))))

(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (if (>= (window-body-width) 270)
        (split-window-horizontally-n 3)
      (split-window-horizontally)))
  (other-window 1))

