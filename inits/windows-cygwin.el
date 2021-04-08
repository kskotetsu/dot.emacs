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
;; (require 'shell)


;; (setq explicit-shell-file-name "bash.exe")
;; ;(setq explicit-shell-file-name "cmd.exe")
;; ;(setq shell-command-switch "--noediting")
;; (setq explicit-bash.exe-args '("--login" "--noediting" "-i"))
;; (setq shell-file-name "bash.exe")

;; (setq explicit-shell-file-name "cmdproxy.exe")
;; (setq shell-file-name "cmdproxy.exe")

;; ;; http://d.hatena.ne.jp/armbrust/20120909/134718360
;; ;; fakecygcmdを使ってシェルのC-Cを効くようにする

;; ;; ssh の関数 の実装を流用して乗っ取る
;; (defadvice comint-interrupt-subjob (around ad-comint-interrupt-subjob activate)
;;   (process-send-string nil "\C-c"))

;; ;; shell 設定
;; (setq explicit-shell-file-name "f_bash")
;; (setq shell-file-name "bash") ; これは f_ にしてはいけない
;; (setq shell-command-switch "-c")
;; ;(setq explicit-shell-file-name "f_cmd")
;; ;(setq shell-file-name "cmd") ; これは f_ にしてはいけない
;; ;(setq shell-command-switch "-c")

;; ;; ;; (M-! and M-| and compile.el)
;; ;; (setq shell-file-name "bash.exe")
;; ;; (modify-coding-system-alist 'process ".*sh\\.exe" 'cp932)

;; ;; ;; shellモードの時の^M抑制
;; ;; (add-hook 'comint-output-filter-functions 'shell-strip-ctrl-m nil t)

;; ;; ;; shell-modeでの補完 (for drive letter)
;; ;; (setq shell-file-name-chars "~/A-Za-z0-9_^$!#%&{}@'`.,;()-")

;; ;; ;; エスケープシーケンス処理の設定
;; ;; (autoload 'ansi-color-for-comint-mode-on "ansi-color"
;; ;;   "Set `ansi-color-for-comint-mode' to t." t)

;; ;; ;(eval-after-load "gnutls"
;; ;; ;  '(setq gnutls-trustfiles "c:/cygwin/usr/ssl/certs/ca-bundle.crt")

;; (eval-after-load "gnutls" '(setq gnutls-trustfiles (mapcar 'expand-file-name gnutls-trustfiles)))

;; ;(executable-find "cmdproxy")
;; (executable-find "bash")

;; ;; (defun my-shell-setup ()
;; ;;   "For Cygwin bash under Emacs 20"
;; ;;   (setq comint-scroll-show-maximum-output 'this)
;; ;;   (make-variable-buffer-local 'comint-completion-addsuffix))
;; ;; (setq comint-completion-addsuffix t)
;; ;; ;; (setq comint-process-echoes t) ;; reported that this is no longer needed
;; ;; (setq comint-eol-on-send t)
;; ;; (setq w32-quote-process-args ?\")

;; ;; (setq shell-mode-hook 'my-shell-setup)


;; ;; -----------------------------------
;; ;; start-process での起動時に、fakecygpty.exe を経由させたいプログラム名を列挙する
;; ;; suffix に .exe が付くコマンドは、その suffix を記載しないこと
;; (setq fakecygpty-program-list '("sh" "bash" "zsh" "ssh" "scp" "rsync" "sftp" "irb" "ipython" "ipdb" "pdb" "psql" "sqlite3" "gtags" "ag"))

;; ;; start-process での起動時に、fakecygpty.exe を経由させたくないプロセスが走るバッファ名を列挙する
;; (setq fakecygpty-exclusion-buffer-name-list '("*grep*" "*ag search\.*"))

;; ;; fakecygpty-program-list に登録されているプログラムを fakecygpty.exe 経由で起動する
;; (defadvice start-process (around ad-start-process-to-fake last activate)
;;   (let ((buffer-name (if (bufferp (ad-get-arg 1))
;;                          (buffer-name (ad-get-arg 1))
;;                        (ad-get-arg 1))))
;;     (if (and (member (replace-regexp-in-string "\\.exe$" "" (file-name-nondirectory (ad-get-arg 2)))
;;                      fakecygpty-program-list)
;;              (not (member buffer-name fakecygpty-exclusion-buffer-name-list)))
;;         (progn
;;           (ad-set-args 3 (cons (ad-get-arg 2) (ad-get-args 3)))
;;           (ad-set-arg 2 "fakecygpty")
;;           ad-do-it)
;;       ad-do-it)))

;; (setq c-eldoc-cpp-command "C:\\cygwin\\bin\\cpp ")


;; ;; emacs-24.4 では、fakecygpty を経由して起動したプロセスに対し、4096バイトを超える入力を一回に送り込むと
;; ;; レスポンスが帰ってこない状況となる。これを改善する。（NTEmacsスレッド４ 714氏 の投稿を一部修正したもの）
;; (defconst w32-pipe-limit 4096)

;; (defadvice process-send-string (around ad-process-send-string activate)
;;   (if (not (eq (process-type (ad-get-arg 0)) 'real))
;;       ad-do-it
;;     (let* ((process (or (ad-get-arg 0)
;;                         (get-buffer-process (current-buffer))))
;;            (send-string (encode-coding-string (ad-get-arg 1)
;;                                               (cdr (process-coding-system (get-process process)))))
;;            (send-string-length (length send-string)))
;;       (if (<= send-string-length w32-pipe-limit)
;;           ad-do-it
;;         (let ((inhibit-eol-conversion t)
;;               (from 0)
;;               (to))
;;           (while (< from send-string-length)
;;             (setq to (min (+ from w32-pipe-limit) send-string-length))
;;             (ad-set-arg 1 (substring send-string from to))
;;             ad-do-it
;;             (setq from to)))))))

