;; Python
;(el-get 'sync 'ac-python)
(require 'epc)
(require 'python)
(require 'jedi)
;(require 'ac-python)

(defun python-add-breakpoint ()
  "Add a break point"
  (interactive)
  (newline-and-indent)
  (insert "import ipdb; ipdb.set_trace()")
  (highlight-lines-matching-regexp "^[ ]*import ipdb; ipdb.set_trace()"))


(defun my-python-mode ()
  (setq imenu-create-index-function 'python-imenu-create-index)
  (setq indent-tabs-mode nil)
  (setq indent-level 4)
  (setq python-indent 4)
  (setq tab-width 4)
  (setq python-indent-guess-indent-offset nil)
  (flycheck-mode t)
  (jedi:setup)
  (setq jedi:complete-on-dot t)
  (local-set-key (kbd "<f1> j") 'jedi:show-doc)
  (define-key python-mode-map (kbd "C-c C-b") 'python-add-breakpoint)
  (setq
   python-shell-interpreter "ipython"
   python-shell-interpreter-args ""
   python-shell-prompt-regexp "In \\[[0-9]+\\]: "
   python-shell-prompt-output-regexp "Out\\[[0-9]+\\]: "
   python-shell-completion-setup-code
   "from IPython.core.completerlib import module_completion"
   python-shell-completion-module-string-code
   "';'.join(module_completion('''%s'''))\n"
   python-shell-completion-string-code
    "';'.join(get_ipython().Completer.all_completions('''%s'''))\n" )
  )



(add-hook 'python-mode-hook 'my-python-mode)

; for mac
(eval-after-load "jedi"
  '(setq jedi:server-command (list "/Users/kskotetsu/.pyenv/shims/python" jedi:server-script))
  )
