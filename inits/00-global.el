;;--------------------------------------------------------------------;
;; 基本設定
;;--------------------------------------------------------------------
;(if (not window-system)
;  ;; Terminal 上での動作設定
;  )

;; マウスのホイールスクロールスピードを調節
;; (連続して回しているととんでもない早さになってしまう。特にLogicoolのマウス)
(defun scroll-down-with-lines ()
  "" (interactive) (scroll-down 3))
(defun scroll-up-with-lines ()
  "" (interactive) (scroll-up 3))
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
(set-default-coding-systems 'utf-8-with-signature-dos)
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
  (cl-flet ((process-list ())) ad-do-it))

;; 日付のフォーマットを英語にするためにロケール変更
(setq system-time-locale "C")

;; 日付挿入コマンド
(defun insert-current-time()
  (interactive)
  (insert (format-time-string "%Y-%m-%d(%a) %H:%M:%S" (current-time))))
;;(define-key global-map "\C-cd" `insert-current-time)

;;---------------------------------------------------------------------
;; 検索設定
(setq case-fold-search t)               ; 検索では大文字小文字を区別しない

(global-ace-isearch-mode 1)
(setq ace-isearch-jump-delay 1.0)	; ace-jumpに移行する時間を0.5->1.0secに
;(global-ace-isearch-mode +1)
(setq ace-isearch-use-function-from-isearch nil)
(define-key isearch-mode-map (kbd "M-o") 'helm-multi-swoop-all-from-isearch)
;(setq ace-jump-mode-case-fold nil)

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

;; diredを2つのウィンドウで開いている時に、デフォルトの移動orコピー先をもう一方のdiredで開いているディレクトリにする
(setq dired-dwim-target t)
;; ディレクトリを再帰的にコピーする
(setq dired-recursive-copies 'always)
;; diredバッファでC-sした時にファイル名だけにマッチするように
(setq dired-isearch-filenames t)

;; プロジェクト管理
(projectile-global-mode)
(setq projectile-tags-file-name "GTAGS")
(setq projectile-tags-command "gtags -f %s %s")
(setq projectile-project-root-files (quote ("rebar.config" "project.clj" "pom.xml" "build.sbt" "build.gradle" "Gemfile" "requirements.txt" "package.json" "gulpfile.js" "Gruntfile.js" "bower.json" "composer.json" "Cargo.toml" "mix.exs" ".projectile")))
;(when windows-p
;  (setq projectile-indexing-method 'alien))

;; 大きいプロジェクトだと劇的に改善するらしい.
(setq projectile-enable-caching t)

;; ファイルの種別ごとの文字コード
;(modify-coding-system-alist 'file "\\.java\\'" 'utf-8) ;; Java - See more at: http://yohshiy.blog.fc2.com/blog-entry-273.html#sthash.LB7sMm9C.dpuf
;(modify-coding-system-alist 'file "\\*vc-change-log\\*" 'shift_jis)

;; cua-mode
;; Ctrl-RETで矩形選択スタート
(cua-mode)
(setq cua-enable-cua-keys nil)

;(add-to-list 'rainbow-delimiters-ignore-modes 'fundamental-mode) ;helmとの干渉回避
;(custom-set-faces '(rainbow-delimiters-depth-1-face
;					((t (:foreground "#586e75"))))) ;文字列の色と被るため,変更

;; デスクトップモード
(desktop-save-mode)
(setq desktop-buffers-not-to-save
	  (concat "\\("
			  "^nn\\.a[0-9]+\\|\\.log\\|(ftp)\\|^tags\\|^TAGS"
			  "\\|\\.emacs.*\\|\\.diary\\|\\.newsrc-dribble\\|\\.bbdb"
			  "\\)$"))

(add-to-list 'desktop-modes-not-to-save 'dired-mode)
(add-to-list 'desktop-modes-not-to-save 'Info-mode)
(add-to-list 'desktop-modes-not-to-save 'info-lookup-mode)
(add-to-list 'desktop-modes-not-to-save 'fundamental-mode)


;; foreign-regexp
;; (require 'foreign-regexp)

;; (custom-set-variables
;;  '(foreign-regexp/regexp-type 'ruby) ;; Choose your taste of foreign regexp
;;                                     ;; from 'perl, 'ruby or 'javascript.
;;  '(reb-re-syntax 'foreign-regexp))   ;; Tell re-builder to use foreign regex.

