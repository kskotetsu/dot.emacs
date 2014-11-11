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
(setq explicit-shell-file-name "bash.exe")
;(setq shell-command-switch "--noediting")
(setq explicit-bash.exe-args '("--login" "--noediting" "-i"))
(setq shell-file-name "bash.exe")

;(setq explicit-shell-file-name "cmdproxy.exe")
;(setq shell-file-name "cmdproxy.exe")

;; http://d.hatena.ne.jp/armbrust/20120909/134718360
;; fakecygcmdを使ってシェルのC-Cを効くようにする

;; ssh の関数 の実装を流用して乗っ取る
(defadvice comint-interrupt-subjob (around ad-comint-interrupt-subjob activate)
  (process-send-string nil "\C-c"))

;; shell 設定
(setq explicit-shell-file-name "f_bash")
(setq shell-file-name "bash") ; これは f_ にしてはいけない
(setq shell-command-switch "-c")
;(setq explicit-shell-file-name "f_cmd")
;(setq shell-file-name "cmd") ; これは f_ にしてはいけない
;(setq shell-command-switch "-c")

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

;(executable-find "cmdproxy")
(executable-find "bash")

;; (defun my-shell-setup ()
;;   "For Cygwin bash under Emacs 20"
;;   (setq comint-scroll-show-maximum-output 'this)
;;   (make-variable-buffer-local 'comint-completion-addsuffix))
;; (setq comint-completion-addsuffix t)
;; ;; (setq comint-process-echoes t) ;; reported that this is no longer needed
;; (setq comint-eol-on-send t)
;; (setq w32-quote-process-args ?\")

;; (setq shell-mode-hook 'my-shell-setup)
