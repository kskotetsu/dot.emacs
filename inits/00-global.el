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
(require 'recentf)
(setq recentf-auto-cleanup 'never) ;; 開けないファイルを消さないようにする。サーバー上のファイル対策
(setq recentf-max-menu-items 20)
(setq recentf-max-saved-items 1000)
(recentf-mode)

;; *.~ とかのバックアップファイルを作らない
(setq make-backup-files nil)

;; .#* とかのバックアップファイルを作らない
(setq auto-save-default nil)

;(ido-mode 1)
;(global-ede-mode 1)
(require 'speedbar)
(require 'semantic/sb)
(semantic-mode 1)
(require 'imenu)

(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)

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
;(setq gc-cons-threshold 100000) 

;; GCの頻度を減らす
(setq gc-cons-threshold 5242880)

;; コンソールなどを閉じるときに確認しない
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (flet ((process-list ())) ad-do-it))

;;---------------------------------------------------------------------
;; 検索設定
(setq case-fold-search t)               ;検索では大文字小文字を区別しない

;IME ON/OFF時のカーソルカラー
;(add-hook 'input-method-activate-hook
;(lambda() (set-cursor-color "green")))
;(add-hook 'input-method-inactivate-hook
;(lambda() (set-cursor-color "white")))

;;---------------------------------------------------------------------
;; auto-insert-mode
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/insert/")
(setq auto-insert-alist
	  (nconc '(
			   ("\\.el$"		.		["template.el" my-template])
			   ("\\.cpp$"		.		["template.cpp" my-template])
			   ("\\.h$"			.		["template.h" my-template])
			   ("\\.py$"		.		["template.py" my-template])
			   ("\\.rb$"		.		["template.rb" my-template])
			   ("\\.sh$"		.		["template.sh" my-template])
			   ) auto-insert-alist))

(defvar template-replacements-alists
  '(("%file%"             . (lambda () (file-name-nondirectory (buffer-file-name))))
    ("%file-without-ext%" . (lambda () (file-name-sans-extension (file-name-nondirectory (buffer-file-name)))))
    ("%include-guard%"    . (lambda () (format "__%s_H__" (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))))))
    ("%time%" 			  . (lambda () (current-time-string)))
	))

(defun my-template ()
  (time-stamp)
  (mapc #'(lambda(c)
        (progn
          (goto-char (point-min))
          (replace-string (car c) (funcall (cdr c)) nil)))
    template-replacements-alists)
  (goto-char (point-max))
  (message "done."))

(add-hook 'find-file-not-found-hooks 'auto-insert)

;; シバン(ファイル先頭の#!/usr/bin/sh)があったら自動的に実行権限をつける
(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

;; dired２画面モードでコピー先等を反対のバッファに
(setq dired-dwim-target t)

;; プロジェクト管理
(projectile-global-mode)
