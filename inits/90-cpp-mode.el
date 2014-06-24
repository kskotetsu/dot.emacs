;(el-get 'sync 'cc-mode+)
;(require 'cc-mode+)
(setq gtags-path-style 'relative)
(setq auto-mode-alist (append (list
							   '("\\.cpp"		.		c++-mode)
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

;; ------------------------------------------------------------------------
;; C++モード
; プリコンパイルヘッダの作り方
; clang++ -cc1 -emit-pch -x c++-header ./stdafx.h -o stdafx.pch　-I(インクルードディレクトリ)
(add-hook 'c++-mode-hook '(lambda ()
			    (my-ac-cc-mode-setup)
			    (gtags-mode 1)
				(imenu-add-menubar-index)
				(setq c-auto-newline nil)
				;(linum-mode)
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
			    (c-set-offset 'statement-case-intro 2)
			    (c-set-offset 'inline-open 0)
			    (c-set-offset 'case-label 2)
			    
			    ))

; (add-to-list 'speedbar-fetch-etags-parse-list
;		'("\\.cpp" . speedbar-parse-c-or-c++tag))

;; ------------------------------------------------------------------------


