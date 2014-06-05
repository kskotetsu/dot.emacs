;; 逐次文法チェックする

;(package-install 'flycheck)
;(package-install 'flycheck-tip)

(setq flycheck-check-syntax-automatically '(mode-enabled save))

;; テンポラリバッファでflycheckしようとするとエラーが出る
(defun flycheck-disable-on-temp-buffers ()
   (unless (and buffer-file-name (file-exists-p buffer-file-name) (flycheck-mode -1))))

(add-hook 'emacs-lisp-mode-hook 'flycheck-disable-on-temp-buffers)

(require 'smartrep)
(smartrep-define-key
    global-map "M-g" '(("M-n" . 'flycheck-tip-cycle)
                       ("M-p" . 'flycheck-tip-cycle-reverse)))
