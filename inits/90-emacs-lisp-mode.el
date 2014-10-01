;; emacs-lisp編集時設定

(defun my-elisp-mode ()
  (flycheck-mode)
  (eldoc-mode)
  )


;; elispのときはflycheck
(add-hook 'emacs-lisp-mode-hook 'my-elisp-mode)

