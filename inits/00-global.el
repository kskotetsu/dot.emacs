;;--------------------------------------------------------------------;
;; 基本設定
;;--------------------------------------------------------------------
;(if (not window-system)
;  ;; Terminal 上での動作設定
;  )

;; スタート画面なしに
;(setq inhibit-startup-message t)

;; C-hはバックスペース
(global-set-key "\C-h" 'delete-backward-char)

;; scroll
(setq scroll-conservatively 35
       scroll-margin 3
       scroll-step 1)

(global-linum-mode t)
(setq linum-delay t)
;; 行番号高速化
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

(setq tab-width 4)
(setq default-tab-width 4)
(setq c-basic-offset 4)

;; マウスのホイールスクロールスピードを調節
;; (連続して回しているととんでもない早さになってしまう。特にLogicoolのマウス)
;; (defun scroll-down-with-lines ()
;;   "" (interactive) (scroll-down 1))
;; (defun scroll-up-with-lines ()
;;   "" (interactive) (scroll-up 1))
;; (global-set-key [wheel-up] 'scroll-down-with-lines)
;; (global-set-key [wheel-down] 'scroll-up-with-lines)
;; (global-set-key [double-wheel-up] 'scroll-down-with-lines)
;; (global-set-key [double-wheel-down] 'scroll-up-with-lines)
;; (global-set-key [triple-wheel-up] 'scroll-down-with-lines)
;; (global-set-key [triple-wheel-down] 'scroll-up-with-lines)

;; ビープを鳴らさない
(setq visible-bell nil)
;; ツールバーをオフ
(tool-bar-mode 0)

;; 最近開いたファイルをたくさん残す
(recentf-mode)
(setq recentf-max-menu-items 20)
(setq recentf-max-saved-items 1000)

;;起動時のフレームサイズを設定する
(setq initial-frame-alist
      (append (list
        '(width . 120)
        '(height . 48)
        )
        initial-frame-alist))
(setq default-frame-alist initial-frame-alist)


;;--------------------------------------------------------------------;
;; 日本語設定
;;--------------------------------------------------------------------
; 言語を日本語にする
;(set-language-environment 'Japanese)
(set-language-environment 'utf-8)
; 極力UTF-8とする
(prefer-coding-system 'utf-8)
;; クリップボードの文字コード
(set-selection-coding-system 'utf-8)
;; 端末の文字コード
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
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

; フレームタイトルの設定
(setq frame-title-format "%b")

;; 重複ファイルを hoge<dir1>などのように
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
(setq uniquify-ignore-buffers-re "*[^*]+*")


;; ------------------------------------------------------------------------
;; C++モード
; プリコンパイルヘッダの作り方
; clang++ -cc1 -emit-pch -x c++-header ./stdafx.h -o stdafx.pch　-I(インクルードディレクトリ)
(add-hook 'c++-mode-hook '(lambda ()
			    ;(my-ac-cc-mode-setup)
			    (gtags-mode 1)
			    (setq c-auto-newline nil)
			    
			    (setq c-auto-newline nil)
														;;(linum-mode)
			    (setq c++-tab-always-indent nil)		; [TAB] キーで、TABコードを入力
			    (setq c-tab-always-indent nil)			; [TAB] キーで、TABコードを入力
			    (setq indent-tabs-mode t)
			    (show-paren-mode t)						;対応する括弧を表示
			    (setq tab-width 4)
			    (c-toggle-hungry-state -1)
			    (setq truncate-lines t)					;長い行を折り返し表示しない
				;(setq show-paren-style 'expression)
			    (c-set-style "stroustrup")	
			    (local-set-key "\C-m" 'newline-and-indent)
			    (local-set-key "\C-j" 'newline-and-indent)
			    (setq dabbrev-case-fold-search nil)
				;; (setq comment-start "// "
				;; 		comment-end " "
				;; 		)
			    (font-lock-fontify-buffer)
			    (setq font-lock-keywords c++-font-lock-keywords-2)
				;; http://d.hatena.ne.jp/i_s/20091026/1256557730
			    (c-set-offset 'innamespace 0)			; namespace {}の中はインデントしない
			    (c-set-offset 'arglist-close 0)			; 関数の引数リストの閉じ括弧はインデントしない
			    (c-set-offset 'label 0)
			    (c-set-offset 'substatement-open 0)
			    (c-set-offset 'statement-case-intro 2)
			    (c-set-offset 'inline-open 0)
			    (c-set-offset 'case-label 2)
			    
			    ))
