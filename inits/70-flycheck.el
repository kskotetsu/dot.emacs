;; 逐次文法チェックする

;(package-install 'flycheck)
;(package-install 'flycheck-tip)

;(setq flycheck-check-syntax-automatically '(mode-enabled save))

;; emacs lispで余計なチェックをしない
;(eval-after-load 'flycheck (setq-default flycheck-disabled-checkers '(emacs-lisp-checkdoc)))
(eval-after-load 'flycheck '(setq flycheck-checkers (delq 'emacs-lisp-checkdoc flycheck-checkers)))

;; テンポラリバッファでflycheckしようとするとエラーが出る
(defun flycheck-disable-on-temp-buffers ()
   (unless (and buffer-file-name (file-exists-p buffer-file-name) (flycheck-mode -1))))

;(add-hook 'emacs-lisp-mode-hook 'flycheck-disable-on-temp-buffers)

;; エラーに飛ぶ
(require 'smartrep)
(smartrep-define-key
    global-map "M-g" '(("M-n" . 'flycheck-tip-cycle)
                       ("M-p" . 'flycheck-tip-cycle-reverse)))

