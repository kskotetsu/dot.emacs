;(el-get 'sync 'cc-mode+)
;(require 'cc-mode+)

(setq auto-mode-alist (append (list
							   '("\\.cpp$"		.		c++-mode)
							   '("\\.h$"		.		c++-mode)
							   '("\\.hpp$"		.		c++-mode)
							   )
							  auto-mode-alist))

(defun my-ac-cc-mode-setup ()
  ;;4文字入力時点で補完画面を出す．nilなら補完キーによって出る
  (setq ac-auto-start 4)
  ;;(setq ac-clang-prefix-header "~/.emacs.d/ac-dict/stdafx.pch")
  ;(setq ac-clang-flags '("-w" "-ferror-limit" "1"))
  (setq ac-sources '(
		     ;ac-source-clang
		     ac-source-yasnippet  
		     ac-source-gtags
			 ac-source-imenu)
		)
  )

(defun my-c-mode-update-gtags ()
  (let* ((file (buffer-file-name (current-buffer)))
     (dir (directory-file-name (file-name-directory file))))
    (when (executable-find "global")
      (start-process "gtags-update" nil
             "global" "-uv"))))

(defun my-cpp-mode ()
  (semantic-mode 1)
  ;; (custom-set-variables '(helm-mini-default-sources
  ;; 						'(helm-source-buffers-list
  ;; 						  ;helm-source-semantic
  ;; 						  ;helm-source-imenu
  ;; 						  ;helm-source-ls-git
  ;; 						  helm-source-recentf
  ;; 						  helm-source-buffer-not-found
  ;; 						  )))
  (my-ac-cc-mode-setup)
  (gtags-mode 1)
  ;(ggtags-mode 1) ; タグの詳細自動表示時にキーリピートがおかしくなるので使わない
  (helm-gtags-mode)
  (highlight-symbol-mode)
  (imenu-add-to-menubar "Func")
  (setq c-eldoc-includes "-I./ -I../ -I\"C:/Program Files (x86)/Microsoft Visual Studio 9.0/VC/include\" -IC:/home/yamamura/work/mithril/program/lib/orbiter/include -Ic:/home/yamamura/work/mithril/program/code/src ")
  (set (make-local-variable 'eldoc-idle-delay) 0.20)
  (c-turn-on-eldoc-mode)
  (setq c-auto-newline nil)								;(linum-mode)
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
  (c-set-offset 'statement-case-intro 4)
  (c-set-offset 'inline-open 0)
  (c-set-offset 'case-label 4)
  (add-hook 'after-save-hook
			'my-c-mode-update-gtags)

  ;; (flymake-mode t)
  ;; (let* ((temp-file (flymake-init-create-temp-buffer-copy
  ;;                    'flymake-create-temp-inplace))
  ;;        (local-file (file-relative-name
  ;;                     temp-file
  ;;                     (file-name-directory buffer-file-name))))
  ;; 	(list "C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/bin/cl.exe" (list "/nologo" "/W4" "/Wp64" "/Zs" local-file)))
  ;; (push '("\\.cpp\\'" flymake-vc-init) flymake-allowed-file-name-masks)
  ;; (flycheck-mode t)

  ;; (flycheck-define-checker c/c++-vc
  ;; 	"vc"
  ;; 	:command ("cl"
  ;; 			  "-Wall"
  ;; 			  "-Ic:/home/yamamura/work/ffm/sample/trunk/code/src"
  ;; 			  source)
  ;; 	:error-patterns
  ;; 	((error line-start
  ;; 			(file-name) "(" line ") : fatal error " (message)
  ;; 			line-end)
  ;; 	 (warning line-start
  ;; 			  (file-name) "(" line ") : warning " (message)
  ;; 			  line-end))
  ;; 	:modes (c-mode c++-mode))

  ;; (flycheck-select-checker 'c/c++-vc)
  ;; (setq flycheck-clang-ms-extensions t)
  ;; (setq flycheck-clang-no-exceptions t)
  ;; (setq flycheck-clang-warnings
  ;; 		(list
  ;; 		 "-w"
  ;; 		 ))

  ;; (flycheck-string-list-p
  ;;  (list
  ;; 	"WIN32"
  ;; 	"__w64"
  ;; 	"__possibly_notnullterminated"
  ;; 	"_WINDOWS"
  ;; 	"NDEBUG"
  ;; 	"ML_PLATFORM_DX9"
  ;; 	"_OROCHI"
  ;; 	"UNICODE"
  ;; 	"_UNICODE"
  ;; 	"NT_INCLUDED"
  ;; 	))
						   
  ;; (setq flycheck-clang-include-path
  ;; 		(list 
  ;; 		 (expand-file-name "C:/Program Files (x86)/Microsoft SDKs/Windows/v7.0A/include")
  ;; 		 (expand-file-name "C:/Program Files (x86)/Microsoft Visual Studio 10.0/VC/include")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/OROCHI/program/middleware/BISHAMON/inc/Win32/inc")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/OROCHI/program/middleware/YEBIS/include/Win32")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/OROCHI/program/middleware/Gx/src")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/OROCHI/program/middleware/Gx/src/Gsl")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/OROCHI/program/middleware/Gx/opensource/Expat/src")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/OROCHI/program/middleware/Gx/opensource/Pawn/src/amx")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/OROCHI/program/middleware/Gx/opensource/Pawn/src/compiler")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/OROCHI/program/middleware/Gx/opensource/Squish/src")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/OROCHI/program/middleware/Gx/opensource/Zlib/src")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/OROCHI/program/middleware/Gx/opensource/Bullet/src")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/code/src")
  ;; 		 (expand-file-name "C:/home/yamamura/work/ffm/sample/trunk/lib/orbiter/include"))
  ;; 		)
  )


;; ------------------------------------------------------------------------
;; C++モード
; プリコンパイルヘッダの作り方
; clang++ -cc1 -emit-pch -x c++-header ./stdafx.h -o stdafx.pch　-I(インクルードディレクトリ)
(add-hook 'c++-mode-hook 'my-cpp-mode)
;; (add-hook 'c++-mode-hook '(lambda ()
;; 				(semantic-mode 1)
;; 				;; (custom-set-variables '(helm-mini-default-sources
;; 				;; 						'(helm-source-buffers-list
;; 				;; 						  ;helm-source-semantic
;; 				;; 						  ;helm-source-imenu
;; 				;; 						  ;helm-source-ls-git
;; 				;; 						  helm-source-recentf
;; 				;; 						  helm-source-buffer-not-found
;; 				;; 						  )))
;; 			    (my-ac-cc-mode-setup)
;; 			    (gtags-mode 1)
;; 				(highlight-symbol-mode)
;; 				(imenu-add-to-menubar "Func")
;; 				(setq c-auto-newline nil)
;; 				;(linum-mode)
;; 			    (setq c++-tab-always-indent nil)		; [TAB] キーで、TABコードを入力
;; 			    (setq c-tab-always-indent nil)			; [TAB] キーで、TABコードを入力
;; 			    (setq indent-tabs-mode t)
;; 			    (show-paren-mode t)						;対応する括弧を表示
;; 			    (setq tab-width 4)
;; 			    (c-toggle-hungry-state -1)
;; 			    (setq truncate-lines t)					;長い行を折り返し表示しない
;; 				;(setq show-paren-style 'expression)
;; 			    (c-set-style "stroustrup")	
;; 			    (local-set-key "\C-m" 'newline-and-indent)
;; 			    (local-set-key "\C-j" 'newline-and-indent)
;; 			    (setq dabbrev-case-fold-search nil)
;; 				;; (setq comment-start "// "
;; 				;; 		comment-end " "
;; 				;; 		)
;; 			    (font-lock-fontify-buffer)
;; 			    (setq font-lock-keywords c++-font-lock-keywords-2)
;; 				;; http://d.hatena.ne.jp/i_s/20091026/1256557730
;; 			    (c-set-offset 'innamespace 0)			; namespace {}の中はインデントしない
;; 			    (c-set-offset 'arglist-close 0)			; 関数の引数リストの閉じ括弧はインデントしない
;; 			    (c-set-offset 'label 0)
;; 			    (c-set-offset 'substatement-open 0)
;; 			    (c-set-offset 'statement-case-intro 2)
;; 			    (c-set-offset 'inline-open 0)
;; 			    (c-set-offset 'case-label 2)
			    
;; 			    ))

; (add-to-list 'speedbar-fetch-etags-parse-list
;		'("\\.cpp" . speedbar-parse-c-or-c++tag))

;; ------------------------------------------------------------------------


