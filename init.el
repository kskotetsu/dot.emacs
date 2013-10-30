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

(el-get 'sync)

;; -------------------------------------------------------------------
;; init-loader
(require 'init-loader)
;(setq init-loader-show-log-after-init nil)
(init-loader-load "~/.emacs.d/inits")

(cd "~/")
