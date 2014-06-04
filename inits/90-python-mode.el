;; Python
(add-hook 'python-mode-hook
                   '(lambda()
                        (setq indent-tabs-mode nil)
                        (setq indent-level 4)
                        (setq python-indent 4)
                        (setq tab-width 4)
						(flycheck-mode t)
						))

;(add-hook 'python-mode-hook 'flycheck-mode)

