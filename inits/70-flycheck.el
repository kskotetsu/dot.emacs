;; 逐次文法チェックする

(package-install 'flycheck)

;; テンポラリバッファでflycheckしようとするとエラーが出る
(defun flycheck-disable-on-temp-buffers ()
   (unless (and buffer-file-name (file-exists-p buffer-file-name) (flycheck-mode -1)

(add-hook 'emacs-lisp-mode-hook 'flycheck-disable-on-temp-buffers)


