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

; profiling
(require 'profiler)
(profiler-start 'cpu)

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

;; HTTPS 系のリポジトリ
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; (add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;; (add-to-list 'package-archives '("marmalade" . "https://marmalade-repo.org/packages/") t)

;; HTTP 系のリポジトリ
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
;;(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/") t)

;; marmalade　は HTTP アクセスすると証明書エラーでフリーズするので注意
;; (add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/") t)

;; Add package-archives
;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;(add-to-list 'package-archives '("melpa" . "http://stable.melpa.org/packages/") t)
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/")) ; ついでにmarmaladeも追加

; Initialize
(package-initialize)

;;(require 'cl)

(defvar installing-package-list
  '(
    ;; ここに使っているパッケージを書く。
    init-loader
	exec-path-from-shell
	session
	projectile
	migemo
	ggtags
	elscreen
	elscreen-persist
	switch-window
	undohist
	undo-tree
	recentf-ext
	;auto-save-buffers-enhanced
	;foreign-regexp
	visual-regexp-steroids
	;tabbar
	diff-hl
	gtags
	e2wm
	anzu
	window-numbering
	ace-jump-mode
	ace-jump-zap
	sequential-command
	guide-key
	rainbow-delimiters
	;guide-key-tip
	;auto-complete
	irony
	company
	company-quickhelp
	company-jedi
	company-irony
	ac-dabbrev
	expand-region
	;icicles
	flycheck
	flycheck-tip
	yasnippet
	rainbow-mode
	popwin
	imenu-anywhere
	multi-term
	quickrun
	bm
	;calfw
	;calfw-gcal
	helm
	helm-ag
	helm-c-yasnippet
	helm-ls-git
	helm-package
	helm-cmd-t
	helm-projectile
	helm-bm
	helm-gtags
	wgrep
	wgrep-helm
	wgrep-ag
	ace-isearch
	gist
	magit
	helm-gist
	smartrep
	;git-gutter-fringe+
	git-timemachine
	org
	open-junk-file
	;auto-highlight-symbol
	highlight-symbol
	enh-ruby-mode
	ruby-mode
	ruby-block
	ruby-end
	inf-ruby
	robe
	ipython
	python
	pyenv-mode
	yaml-mode
	ansible
	;python-mode
	;epc
	;jedi
	batch-mode
	lua-mode
	;c-eldoc
	;zeal-at-point
	;dash-at-point
	dockerfile-mode
	tr-ime
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
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(avy-migemo-function-names
   (quote
    (swiper--add-overlays-migemo
     (swiper--re-builder :around swiper--re-builder-migemo-around)
     (ivy--regex :around ivy--regex-migemo-around)
     (ivy--regex-ignore-order :around ivy--regex-ignore-order-migemo-around)
     (ivy--regex-plus :around ivy--regex-plus-migemo-around)
     ivy--highlight-default-migemo ivy-occur-revert-buffer-migemo ivy-occur-press-migemo avy-migemo-goto-char avy-migemo-goto-char-2 avy-migemo-goto-char-in-line avy-migemo-goto-char-timer avy-migemo-goto-subword-1 avy-migemo-goto-word-1 avy-migemo-isearch avy-migemo-org-goto-heading-timer avy-migemo--overlay-at avy-migemo--overlay-at-full)))
 '(company-idle-delay 0.5)
 '(custom-safe-themes
   (quote
    ("c3c0a3702e1d6c0373a0f6a557788dfd49ec9e66e753fb24493579859c8e95ab" default)))
 '(foreign-regexp/regexp-type (quote ruby))
 '(helm-ff-auto-update-initial-value nil)
 '(helm-mini-default-sources
   (quote
    (helm-source-buffers-list helm-source-recentf helm-source-ls-git helm-source-buffer-not-found)))
 '(horizontal-scroll-bar nil t)
 '(horizontal-scroll-bars nil)
 '(init-loader-show-log-after-init (quote error-only))
 '(org-agenda-format-date "%Y/%m/%d ")
 '(package-selected-packages
   (quote
    (helm-swoop srefactor visual-regexp visual-regexp-steroids counsel counsel-projectile dracula-theme smart-hungry-delete symbol-overlay volatile-highlights beacon dumb-jump helm-rg avy avy-migemo swiper-helm ivy-yasnippet editorconfig-generate editorconfig editorconfig-charset-extras google-translate powerline php-mode yaml-mode wgrep-helm undohist switch-window summarye sudden-death smooth-scroll smartrep shut-up session sequential-command ruby-end ruby-block recentf-ext rainbow-mode rainbow-delimiters pyenv-mode nyan-mode lua-mode jedi ipython init-loader hl-line+ highlight-symbol helm-package helm-ls-git helm-img-tiqav helm-gist helm-cmd-t helm-c-yasnippet helm-bm guide-key-tip gtags git-timemachine git-rebase-mode git-gutter-fringe git-commit-mode ggtags foreign-regexp flycheck-tip expand-region exec-path-from-shell evil enh-ruby-mode elscreen-persist e2wm dockerfile-mode diff-hl dash-at-point cygwin-mount csharp-mode company-quickhelp company-jedi company-irony company-ansible color-theme-monokai color-theme-molokai color-identifiers-mode col-highlight cedit c-eldoc batch-mode auto-save-buffers-enhanced anzu ansible ag ack-menu ack ace-jump-zap ace-isearch ac-dabbrev)))
 '(reb-re-syntax (quote foreign-regexp))
 '(session-use-package t nil (session))
 '(yas-trigger-key "TAB"))

(cd "~/")
(setq default-directory "~/")
(setq command-line-default-directory "~/")

(server-start)

;; desktop
(desktop-load-default)
(setq desktop-load-locked-desktop t)
(call-interactively 'desktop-read t (vector "~/.emacs.d/desktops/" t))
(desktop-read)
(desktop-save-mode)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-scrollbar-bg ((t (:background "#3df1410a539f"))))
 '(company-scrollbar-fg ((t (:background "#330c359a44ea"))))
 '(company-tooltip ((t (:inherit default :background "#2c832ebd3c17"))))
 '(company-tooltip-common ((t (:inherit font-lock-constant-face))))
 '(company-tooltip-selection ((t (:inherit font-lock-function-name-face))))
 '(org-agenda-date ((t :weight bold)))
 '(org-date ((t (:foreground "DodgerBlue1" :underline t))))
 '(org-level-1 ((t (:foreground "LightSkyBlue" :height 150))))
 '(org-level-2 ((t (:foreground "DarkGoldenrod" :height 100))))
 '(org-level-3 ((t (:foreground "DodgerBlue3" :height 100))))
 '(org-level-4 ((t (:foreground "chocolate1" :height 100))))
 '(org-level-5 ((t (:foreground "PaleGreen" :height 100))))
 '(org-level-6 ((t (:foreground "Aquamarine" :height 100))))
 '(org-link ((t (:foreground "saddle brown" :underline t)))))

;; powerline
(powerline-default-theme)

(profiler-report)
(profiler-stop)

;; (require 'cl) を見逃す
(setq byte-compile-warnings '(not cl-functions obsolete))

;; Local Variables:
;; byte-compile-warnings: (not cl-functions obsolete)
;; End:
