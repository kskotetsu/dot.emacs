;; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;;--------------------------------------------------------------------;
;; inits/*.elの分け方
;; 　00-	emacs本体のグローバルな基本設定
;; 　10-	表示周りなど、emacs動作の基本的な設定
;; 　20-	全体のキーバインド等、個人的な基本設定
;; 　50-	他の拡張の元になるような必須拡張
;; 　60-	準必須拡張
;; 　70-	通常の拡張
;; 　80-	
;; 　90-	各言語用モード拡張など
;;  cocoa-	mac専用拡張
;;  windows-ウィンドウズ専用拡張
;;--------------------------------------------------------------------;

;;--------------------------------------------------------------------;
;; 引数をload-pathに追加する．
;; (add-to-load-path "/hoge/hoge/")で/hoge/hogeがload-pathに追加される
;;--------------------------------------------------------------------
(defun add-to-load-path (&rest paths)
  (mapc '(lambda (path)
	   (add-to-list 'load-path path))
	(mapcar 'expand-file-name paths)))

;;--------------------------------------------------------------------
;; load-pathを追加
;;--------------------------------------------------------------------
;; (add-to-load-path "~/.emacs.d/elisp/"	;;elisp格納ディレクトリ
;; 		  "~/.emacs.d/elisp/w3m";;w3m格納ディレクトリ
;; 		  "~/.emacs.d/elisp/org-7.8.03";;org-mode格納ディレクトリ
;; 		  "~/.emacs.d/elisp/nyan-mode";;w3m格納ディレクトリ
;; 		  "~/.emacs.d/conf"	;;個別の設定格納ディレクトリ
;; 		  "~/.emacs.d/elisp/twittering-mode-2.0.0"
;; 		  )

;(add-to-list 'load-path (expand-file-name "~/.emacs.d/elisp"))

(let ((default-directory (expand-file-name "~/.emacs.d/elisp")))
  (add-to-list 'load-path default-directory)
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
      (normal-top-level-add-subdirs-to-load-path)))

;; -------------------------------------------------------------------
;; package
(require 'package)

; Add package-archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) ; ついでにmarmaladeも追加

; Initialize
(package-initialize)

(require 'cl)

(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    init-loader
	exec-path-from-shell
	session
	projectile
	elscreen
	undohist
	undo-tree
	recentf-ext
	;tabbar
	diff-hl
	gtags
	e2wm
	anzu
	window-numbering
	ace-jump-mode
	sequential-command
	guide-key
	rainbow-delimiters
	;guide-key-tip
	auto-complete
	ac-dabbrev
	expand-region
	;icicles
	flycheck
	flycheck-tip
	yasnippet
	rainbow-mode
	popwin
	multi-term
	quickrun
	helm
	helm-ag
	helm-c-yasnippet
	helm-ls-git
	helm-package
	helm-cmd-t
	helm-projectile
	ace-isearch
	gist
	magit
	helm-gist
	smartrep
	git-gutter-fringe+
	git-timemachine
	org
	open-junk-file
	;auto-highlight-symbol
	highlight-symbol
	enh-ruby-mode
	ruby-mode
	ruby-block
	ruby-end
	ruby-block
	inf-ruby
	robe
	ipython
	python
	;python-mode
	epc
	jedi
	lua-mode
	zeal-at-point
	dash-at-point
    ))

(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))


;; -------------------------------------------------------------------
;; el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")
(setq el-get-dir "~/.emacs.d/el-get/")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(setq el-get-sources
      '(
        (:name dabbrev-ja
               :description "dabbrev-ja"
               :type http
               :url "http://namazu.org/~tsuchiya/elisp/dabbrev-ja.el"
               :load-path (".")
               )
        (:name dabbrev-highlight
               :description "dabbrev-highlight"
               :type http
               :url "http://www.namazu.org/~tsuchiya/elisp/dabbrev-highlight.el"
			   :load-path (".")
			   )
        (:name migemo
               :description "migemo"
               :type http
               :url "https://raw.githubusercontent.com/emacs-jp/migemo/master/migemo.el"
			   :load-path (".")
			   )
	))

(el-get 'sync)

;; -------------------------------------------------------------------
;; init-loader

(unless (require 'init-loader nil 'noerror)
  (package-install 'init-loader)
  )
(require 'init-loader)
;(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")

;; init.logはエラーのときだけ
(custom-set-variables
 '(init-loader-show-log-after-init 'error-only))

(cd "~/")
(setq default-directory "~/")
(setq command-line-default-directory "~/")

(server-start)

;; desktop
(desktop-load-default)
(desktop-read)
(desktop-save-mode)
