;; ------------------------------------------------------------------------
;; シェル
;(package-install 'cygwin-mount)

;(require 'cygwin-mount)
;; shellの文字化けを回避
;; (add-hook 'shell-mode-hook
;;           (lambda ()
;;             (set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)
;;             ))

;; (setq shell-mode-hook
;;       (function
;;        (lambda ()

;; 	 ;; シェルモードの入出力文字コード
;; 	 (set-buffer-process-coding-system 'sjis-dos 'sjis-unix)
;; 	 (set-buffer-file-coding-system    'sjis-unix)
;; 	 )))

;; (setq cygwin-mount-cygwin-bin-directory
;;       (concat (getenv "CYGWIN_DIR") "\\bin"))
;; ;(require 'setup-cygwin)
;; (cygwin-mount-activate)

;; ------------------------------------------------------------------------
;; @ shell
(require 'shell)
;; (setq explicit-shell-file-name "bash.exe")
;; (setq shell-command-switch "-c")
;; (setq shell-file-name "bash.exe")

;; ;; (M-! and M-| and compile.el)
;; (setq shell-file-name "bash.exe")
;; (modify-coding-system-alist 'process ".*sh\\.exe" 'cp932)

;; ;; shellモードの時の^M抑制
;; (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

;; ;; shell-modeでの補完 (for drive letter)
;; (setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@'`.,;()-")

;; ;; エスケープシーケンス処理の設定
;; (autoload 'ansi-color-for-comint-mode-on "ansi-color"
;;   "Set `ansi-color-for-comint-mode' to t." t)

;; ;(eval-after-load "gnutls"
;; ;  '(setq gnutls-trustfiles "c:/cygwin/usr/ssl/certs/ca-bundle.crt")

(eval-after-load "gnutls" '(setq gnutls-trustfiles (mapcar 'expand-file-name gnutls-trustfiles)))