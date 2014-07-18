;; Python
;(el-get 'sync 'ac-python)
(require 'epc)
(require 'python)
(require 'jedi)
;(require 'ac-python)

(add-hook 'python-mode-hook
                   '(lambda()
                        (setq indent-tabs-mode nil)
                        (setq indent-level 4)
                        (setq python-indent 4)
                        (setq tab-width 4)
						(flycheck-mode t)
						(jedi:setup)
						(local-set-key (kbd "<f1> j") 'jedi:show-doc)
						))
;(add-to-list 'ac-modes 'python-mode)

;(add-hook 'python-mode-hook 'flycheck-mode)
(setq jedi:complete-on-dot t)

(eval-after-load "jedi"
    '(setq jedi:server-command (list "/Users/kskotetsu/.pyenv/shims/python" jedi:server-script)))
