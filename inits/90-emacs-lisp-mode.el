;; emacs-lisp編集時設定

;; elispのときはflycheck
(add-hook 'emacs-lisp-mode-hook
		  '(lambda()
			 (flycheck-mode)
			 (eldoc-mode)
			 ))

