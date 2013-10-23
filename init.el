;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;--------------------------------------------------------------------;
;; 引数をload-pathに追加する．
;; (add-to-load-path "/hoge/hoge/")で/hoge/hogeがload-pathに追加される
;;--------------------------------------------------------------------
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
	   (add-to-list 'load-path path))
	(mapcar 'expand-file-name paths)))

;;--------------------------------------------------------------------
;; eval-safe
;; http://www.sodan.org/~knagano/emacs/dotemacs.html#eval-safe
;;--------------------------------------------------------------------
(defmacro eval-safe (&rest body)
  "安全な評価。評価に失敗してもそこで止まらない。"
  `(condition-case err
       (progn ,@body)
     (error (message "[eval-safe] %s" err))))

;;--------------------------------------------------------------------
;; load-pathを追加
;;--------------------------------------------------------------------
(add-to-load-path "~/.emacs.d/elisp/"	;;elisp格納ディレクトリ
		  "~/.emacs.d/elisp/w3m";;w3m格納ディレクトリ
		  "~/.emacs.d/elisp/org-7.8.03";;org-mode格納ディレクトリ
		  "~/.emacs.d/elisp/nyan-mode";;w3m格納ディレクトリ
		  "~/.emacs.d/conf"	;;個別の設定格納ディレクトリ
		  "~/.emacs.d/elisp/twittering-mode-2.0.0"
		  )

(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

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
(set-language-environment 'Japanese)
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

