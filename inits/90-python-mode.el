;; Python
;(el-get 'sync 'ac-python)
(require 'python)
;(require 'ac-python)

(add-hook 'python-mode-hook
                   '(lambda()
                        (setq indent-tabs-mode nil)
                        (setq indent-level 4)
                        (setq python-indent 4)
                        (setq tab-width 4)
						(flycheck-mode t)
						))
;(add-to-list 'ac-modes 'python-mode)

;(add-hook 'python-mode-hook 'flycheck-mode)

