;;--------------------------------------------------------------------;
;; 基本設定
;;--------------------------------------------------------------------
;(if (not window-system)
;  ;; Terminal 上での動作設定
;  )

;; マウスのホイールスクロールスピードを調節
;; (連続して回しているととんでもない早さになってしまう。特にLogicoolのマウス)
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 1))
(defun scroll-up-with-lines ()
  "" (interactive) (scroll-up 1))
(global-set-key [wheel-up] 'scroll-down-with-lines)
(global-set-key [wheel-down] 'scroll-up-with-lines)
(global-set-key [double-wheel-up] 'scroll-down-with-lines)
(global-set-key [double-wheel-down] 'scroll-up-with-lines)
(global-set-key [triple-wheel-up] 'scroll-down-with-lines)
(global-set-key [triple-wheel-down] 'scroll-up-with-lines)

;; ビープを鳴らさない
(setq visible-bell nil)

;; 最近開いたファイルをたくさん残す
(recentf-mode)
(setq recentf-max-menu-items 20)
(setq recentf-max-saved-items 1000)

(require 'auto-save-buffers-enhanced)
(setq auto-save-buffers-enhanced-interval 1)
(auto-save-buffers-enhanced t)

;;--------------------------------------------------------------------;
;; 日本語設定
;;--------------------------------------------------------------------
; 言語を日本語にする
;(set-language-environment 'Japanese)
(set-language-environment 'utf-8)
(prefer-coding-system 'utf-8)			; 極力UTF-8とする
(set-selection-coding-system 'utf-8)	; クリップボードの文字コード
(set-terminal-coding-system 'utf-8)		; 端末の文字コード
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'cp932)

;; ファイル名の文字コード
(require 'ucs-normalize)
(set-file-name-coding-system 'utf-8-hfs)
(setq locale-coding-system 'utf-8)

;; GCの頻度を増やす
(setq gc-cons-threshold 100000) 

;; GCの頻度を減らす
;(setq gc-cons-threshold 5242880)

;;---------------------------------------------------------------------
;; 検索設定
(setq case-fold-search t)               ;検索では大文字小文字を区別しない

;; バッファー名の問い合わせで大文字小文字の区別をしない
(setq read-buffer-completion-ignore-case t)
;; ファイル名の問い合わせで大文字小文字の区別をしない
(setq read-file-name-completion-ignore-case t)

;IME ON/OFF時のカーソルカラー
;(add-hook 'input-method-activate-hook
;(lambda() (set-cursor-color "green")))
;(add-hook 'input-method-inactivate-hook
;(lambda() (set-cursor-color "white")))

; diff-hl.el
; バージョン管理下のコードをハイライト
;(global-diff-hl-mode)
;(add-hook 'dired-mode-hook 'diff-hl-dired-mode)
;(unless (window-system) (diff-hl-margin-mode))

;; ------------------------------------------------------------------------
;; 日にちの挿入
(defun my-get-date-gen (form) (insert (format-time-string form)))
(defun my-insert-date () (interactive) (my-get-date-gen "%Y年%m月%d日"))

(server-start)

